class PusherTaskListener
  def initialize(socket_id, queue=QC, worker=PusherWorker)
    @socket_id = socket_id
    @worker = worker
    @queue = queue
  end

  def on_create(task)
    push_task(task, 'create_task')
    push_project_update(task.project.id) if task.project
  end

  def on_project_change(task, previous_project_id, new_project_id)
    push_project_update(previous_project_id) if previous_project_id
    push_project_update(new_project_id) if new_project_id
  end

  def on_assignment_change(task, previous_assignee, new_assignee)
    push_task(task, 'create_task', new_assignee) if new_assignee
    push_task(task, 'delete_task', previous_assignee) if previous_assignee
  end

  def on_update(task, new_assignee)
    update_users = task.readers - [new_assignee] if task.project
    push_task(task, 'update_task', update_users)
  end

  private
  def enqueue(fn_name, *args)
    args << @socket_id
    @queue.enqueue "#{@worker}.#{fn_name}", *args
  end

  def push_task(task, event, users=nil)
    users = task.readers unless users
    users = Array(users)
    enqueue 'push_task', task.id, event, users.map(&:id)
  end

  def push_task_deletion(task, notifiees)
    enqueue 'push_task_deletion', task.id, notifiees.map(&:id)
  end

  def push_project_update(project_id)
    enqueue 'push_task_project_updates', project_id
  end
end

