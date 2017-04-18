# Cheats:

## db migrate
be hanami db migrate
HANAMI_ENV=test be hanami db migrate

## console
hanami console

## controller
be hanami g action web 'workouts#index'

## models
be hanami g model workout

### select all records
WorkoutRepository.new.all

### find record
repository = UserRepository.new
#### by id
repository.find(user_id)
#### by attribute
repository.where(github_id: id)

### create record
repo = WorkoutRepository.new

workout = repo.create(actvity: 'running', date: Date.today)
--
or
--
workout2 = Workout.new(activity: 'swimming')
repo.create(workout2)
