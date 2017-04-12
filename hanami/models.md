# [Models](https://blog.codeminer42.com/from-rails-to-hanami-models-d1175d2d5b33#.pzxt9nhiy)

## Entities
lib/entities
domain object, holds attributes, don't persist data.

## Repositories
lib/repositories
responsible for dealing with the persistence of our entities.

```ruby
repo = TaskRepository.new
task1 = repo.create(title: 'house cleaning', priority: 0)
task2 = Task.new(title: 'homework', priority: 1)
repo.create(task2)
```

Methods: first , last , update , all , find , clear

Methods like where, limit, order are private and only available for methods inside the repository.

```ruby
class TaskRepository < Hanami::Repository
  def high_priority(limit: 3)
    tasks
      .where('priority <= 1')
      .limit(limit)
  end
end
```

The tasks method is created by Hanami behind the scenes and is base relation where you will do your queries.

