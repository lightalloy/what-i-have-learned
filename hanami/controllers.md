# [Controllers](https://blog.codeminer42.com/from-rails-to-hanami-controllers-ad7ef6d09dd0)

Controllers are modules that group many action classes together.
Hanami has separate class for each action.

## Exposure

We don’t share every instance variable of the action with the view. 
When we want to do so, we must say so:

```ruby
expose :tasks
```

## Params
Similar to Hash with more features.
### Validations
Hanami encourages us to use validations only when we need it, which is on the controller code.
Uses dry-validation gem from dry-rb.

```ruby
params do
  required(:title).filled
end
```

We can put the param validation rules in a separate class
```ruby
module Web::Controllers::Tasks
  class TaskParams < Web::Action::Params
    params do
      required(:title).filled
      required(:priority).filled
    endm
  end
end
```
In controller:
```ruby
params TaskParams
```

## Redirecting
```ruby
redirect_to routes.task_path(@task.id)
```
If the param validation fails, Hanami will render the status code as 422, and on the create view we will tell it to render the new template

### Exception Handling

```ruby
handle_exception PermissionDenied => 403

def call(params)
  raise PermissionDenied unless current_user.admin?
  @task = TaskRepository.new.find(params[:id])
end
```

## Callbacks

Instead of a symbol with a method name you could use a proc!

```ruby
before :check_permission

private

def check_permission
  raise PermissionDenied unless current_user.admin?
end
```















