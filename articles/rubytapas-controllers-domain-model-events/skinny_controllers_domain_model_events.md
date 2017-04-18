https://www.rubytapas.com/2017/04/11/skinny-controller-domain-model-events/

A fat controller action, that updates task and sends different notifications depending on what's changed.

## Identify implicit domain lifecycle events
- actions to perform every time when the task is updated
- actions when the task is moved
- actions when the taks is created
- actions when the task status is changed
- when the task has been reassigned

```ruby
class Task
  around_save :notify_on_save

  def notify_listeners(event_name, *args)
    @listeners && @listeners.each do |listener|
      if listener.respond_to?(event_name)
        listener.public_send(event_name, self, *args)
      end
    end
  end

  def notify_on_save
    # checks to determine what kind of save this is
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
```

In controller action:

```ruby
@task.add_listener pusher_listener(@socket_id)
@task.add_listener email_listener(current_user)
```

Listeners are special classes with the methods like:
on_create, on_project_change, on_assignment_change, on_update, on_status_change (view 'code' folder)



