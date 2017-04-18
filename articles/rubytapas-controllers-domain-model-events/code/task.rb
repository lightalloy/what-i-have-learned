class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :assignee, class_name: "User"

  attr_accessible :project_id
  around_save :notify_on_save

  def readers(include_contributors = true)
    contribs = Array(contributors) if include_contributors
    ((contribs || []) + [self.author] + [self.assignee]).compact.uniq
  end

  def contributors
    self.project && self.project.contributors
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event_name, *args)
    @listeners && @listeners.each do |listener|
      if listener.respond_to?(event_name)
        listener.public_send(event_name, self, *args)
      end
    end
  end

  def notify_on_save
    is_create_save = !persisted?
    project_changed = project_id_changed?
    status_changed = status_changed?
    assignee_changed = assignee_id_changed?
    old_project_id = project_id_was
    old_status = status_was
    old_assignee = User.find_by_id(assignee_id_was)
    yield
    if is_create_save
      notify_listeners(:on_create)
    else
      notify_listeners(:on_project_change, old_project_id, project_id) if project_changed
      notify_listeners(:on_status_change, old_status, status) if status_changed
      notify_listeners(:on_assignment_change, old_assignee, assignee) if assignee_changed
      new_assignee = assignee if assignee_changed
      notify_listeners(:on_update, new_assignee)
    end
  end
end
