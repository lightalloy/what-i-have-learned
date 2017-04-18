class EmailTaskListener
  def initialize(current_user, queue=QC, mailer=::MailWorker)
    @current_user = current_user
    @queue = queue
    @mailer = mailer
  end

  def on_create(task)
    mail_assignment(task) if task.assignee && task.assignee != @current_user
  end

  def on_status_change(task, previous_status, new_status)
    notifiee = task.readers(false) - [@current_user]
    if notifiee
      mail_completion_notice(task, notifiee) if new_status == completed_status
      mail_uncomplete_notice(task, notifiee) if previous_status == completed_status
    end
  end

  def on_assignment_change(task, previous_assignee, new_assignee)
    mail_assignment(task) if new_assignee
    mail_assignment_removal(task, previous_assignee) if previous_assignee
  end

  private
  def enqueue(*args)
    @queue.enqueue *args
  end

  def completed_status
    Status::COMPLETED
  end

  def mail_assignment(task)
    enqueue "#{@mailer}.task_assignment", task.id
  end

  def mail_assignment_removal(task, previous_assignee)
    enqueue "#{@mailer}.task_assignment_removed", task.id, previous_assignee.id
  end

  def mail_completion_notice(task, recipient)
    enqueue "#{@mailer}.task_completion_notice", task.id, @current_user.id, recipient.map(&:id) unless recipient.empty?
  end

  def mail_uncomplete_notice(task, recipient)
    enqueue "#{@mailer}.task_uncomplete_notice", task.id, @current_user.id, recipient.map(&:id) unless recipient.empty?
  end
end
