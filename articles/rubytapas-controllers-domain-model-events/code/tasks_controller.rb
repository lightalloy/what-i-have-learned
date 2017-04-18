class TasksController < ApplicationController
  before_filter :find_task, only: [:show, :update, :destroy]
  before_filter :find_any_task, only: [:accept, :reject, :resend_assignment]
  before_filter :identify_assignee, only: [:create, :update]
  respond_to :json

  def show
    respond_with @task
  end

  def create
    @project = current_user.projects.find_by_id(params[:project_id])

    if @project
      @task = @project.tasks.build(params[:task])
    else
      @task = Task.new(params[:task])
    end
    @task.add_listener pusher_listener(@socket_id)
    @task.add_listener email_listener(current_user)

    @task.author = current_user
    @task.assignee = @assignee
    @task.accept! if @assignee == current_user
    if @task.save
      respond_with @task do |format|
        format.json { render 'show' }
      end
    else
      respond_with @task do |format|
        format.json {render @task.errors.messages, status: :unprocessable_entity}
      end
    end
  end

  def update
    @task.add_listener pusher_listener(@socket_id)
    @task.add_listener email_listener(current_user)

    @task.assignee = @assignee
    @task.accept! if @assignee == current_user && @task.assignee_id_changed?
    if @task.update_attributes(params[:task])
      #respond_with defaults to a blank response, we need the object sent back so that the id can be read
      respond_to do |format|
        format.json {render 'show', status: :accepted}
      end
    else
      respond_with @task do |format|
        format.json {render @task.errors.messages, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    if @task && @task.destroy
      notifiees = @task.readers(false) - [current_user]
      QC.enqueue "MailWorker.task_deletion", @task.name, notifiees.map(&:id), current_user.id unless notifiees.empty?
      data = Rabl::Renderer.json(@task, 'tasks/show', view_path: 'app/views')
      #TODO - make this a queued push somehow
      push_project_update(@task.project.id) if @task.project
      push_task_deletion notifiees
      respond_with nothing: true, status: :no_content
    else
      respond_with nothing: true, status: :not_found
    end
  end

  private

  def find_task
    @task = current_user.all_tasks.find(params[:id])
  end

  def find_any_task
    @task = Task.find(params[:id])
  end

  def identify_assignee
    if params.has_key?(:assignee)
      assignee = params.delete(:assignee)
      @assignee = User.find_by_id(assignee[:id]) if assignee and not assignee.blank?
    else
      @assignee = @task.assignee
    end
  end

  def pusher_listener(socket_id)
    PusherTaskListener.new(socket_id)
  end

  def email_listener(current_person)
    EmailTaskListener.new(current_person)
  end

  def push_task_deletion(notifiees)
    QC.enqueue "PusherWorker.push_task_deletion", @task.id, notifiees.map(&:id), @socket_id
  end

  def push_project_update(project_id)
    QC.enqueue "PusherWorker.push_task_project_updates", project_id, @socket_id
  end
end
