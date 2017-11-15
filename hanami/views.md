# [Views](https://blog.codeminer42.com/from-rails-to-hanami-views-66d27bcba404)
## Templates
Files with contents to be rendered.

## Views
Views are objects responsible for rendering a template and handing data for it to consume.

`Exposure` is the Hanami way to pass data to the views.
The variables that we expose on the actions are made available within the views.

## Presenters
- objects that wrap another object and augment it with logic responsible for representing it in a given context.

Goal: wrap and reuse presentational logic for an object.

```ruby
module Web::Views::Tasks
  class Index
    include Web::View
    # ...
    # overriding tasks and wrapping them in a presenter
    def tasks
      locals[:tasks].map { |task| TaskPresenter.new(task) }
    end
  end
end
```
