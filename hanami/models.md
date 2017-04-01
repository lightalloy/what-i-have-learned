# Models

## Entities
lib/entities
domain object, holds attributes, don't persist data.

## Repositories
lib/repositories
responsible for dealing with the persistence of our entities.

'''
repo = TaskRepository.new

task1 = repo.create(title: 'house cleaning', priority: 0)
task2 = Task.new(title: 'homework', priority: 1)
repo.create(task2)
'''

Methods: first , last , update , all , find , clear

Methods like where, limit, order are private and only available for methods inside the repository.

'''
class TaskRepository < Hanami::Repository
  def high_priority(limit: 3)
    tasks
      .where('priority <= 1')
      .limit(limit)
  end
end
'''

The tasks method is created by Hanami behind the scenes and is base relation where you will do your queries.

