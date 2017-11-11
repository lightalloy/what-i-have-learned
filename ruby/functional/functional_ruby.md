(Tim Riley's series)

[2. Inactive records: the value objects your app deserves](https://www.icelab.com.au/notes/inactive-records-the-value-objects-your-app-deserves/)
Typical Rails app - models have lots of responsibilities, backbone of a Rails app.

But they have mutable state, which may lead to complications.

If you’re working with an ActiveRecord object, you never really know what you’re working with (new object, loaded from db, holds invalid attrs, preloaded associations or not)

That are cons of the ActiveRecord pattern - it mixes the structure and the business logic.

Active record => inactive records, value objects.

Value object is one whose notion of equality is based on the values of the attributes it contains, not its object identity, it's immutable.

Value objects could be also `Article` or `Category`

Usage of dry-types. A value object made using a Dry::Types::Struct is that it cannot be initialized with invalid data.

Technically, these examples are *entities* rather than strict value types, but they still behave effectively as value objects.

Value objects bring safety and simplicity, you'll get rid of nil checks. You won't need to worry about unexpected side effects.

You'll need other changes to the app, like repos or data mappers for db, objects for handling validation.

[3. Functional command objects in Ruby](https://www.icelab.com.au/notes/functional-command-objects-in-ruby/)
Commands - many names: service objects, interactors, use cases, etc.
Putting all the logic in the controllers would be a poor choice.
Let's see another approach:
We'll use a validation object, an object to persist data and the common object itself.

What if we used this code:
```ruby
class CreateArticle
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def call
    result = ValidateArticle.call(params)

    if result.success?
      PersistArticle.call(params)
    end
  end
end
```
It has several problems: 
- we use specific data as the object' state.
So every instance of the `CreateArticle` can only be used once.
- the `CreateArticle` class is coupled to concrete classes.

Better approach:

```ruby
class CreateArticle
  attr_reader :validate_article, :persist_article

  def initialize(validate_article, persist_article)
    @validate_article = validate_article
    @persist_article = persist_article
  end

  def call(params)
    result = validate_article.call(params)

    if result.success?
      persist_article.call(params)
    end
  end
end

create_article = CreateArticle.new(validate_article, persist_article)
create_article.call("title" => "Hello World")
create_article.call("title" => "Hello Dave")
```

The object's collaborators are passed into the initializer.
The object doesn't care about the implementation, but only their interface.

The params are now passed directly into the call method, which has no side effects.
Same input has to result the same output.

It feels like a *function*. So this functional object is now interchangeable with Ruby's own procs and lambdas.

It's easy to compose such objects.
These objects are very easy to test.

[4. Effective Ruby dependency injection at scale](https://www.icelab.com.au/notes/effective-ruby-dependency-injection-at-scale)

But what if you need not 1 or 2, but 1 or 2 hundreds of dependencies.
To make DI work at that scale we need Inversion of Controle container.

We can use dry-container to make sure those dependencies are available when we need them.

```ruby
require "dry-container"

# Set up the container
class MyContainer
  extend Dry::Container::Mixin
end

# Register our objects
MyContainer.register "validate_article" do
  ValidateArticle.new
end

MyContainer.register "persist_article" do
  PersistArticle.new
end

MyContainer.register "create_article" do
  CreateArticle.new(
    MyContainer["validate_article"],
    MyContainer["persist_article"],
  )
end

# Now we can use `CreateArticle` with its dependencies already available
MyContainer["create_article"].("title" => "Hello world")
```

Inversion of control containers are like a big old hash, that manages access to your app's objects.
We can register our apps objects once and use them everywhere.

You can register objects within namespaces.
E.g. "articles.validate_article" or "persistence.commands.persist_article"

In a large app we would like to avoid the configuration boilerplate. So we could use dry-auto_inject 

```ruby
require "dry-container"
require "dry-auto_inject"

# Set up the container
class MyContainer
  extend Dry::Container::Mixin
end

# This time, register our objects without passing any dependencies
MyContainer.register "validate_article", -> { ValidateArticle.new }
MyContainer.register "persist_article", -> { PersistArticle.new }
MyContainer.register "create_article", -> { CreateArticle.new }

# Set up an AutoInject to use our container
AutoInject = Dry::AutoInject(MyContainer)

# And auto-inject the dependencies into CreateArticle
class CreateArticle
  include AutoInject["validate_article", "persist_article"]

  # AutoInject makes `validate_article` and `persist_article` available to use
  def call(params)
    result = validate_article.call(params)

    if result.success?
      persist_article.call(params)
    end
  end
end
```

To get rid of competitive container registration, we can use *dry-component*, a dependency management system, based around dry-container and dry-auto_inject.

Let’s say our three objects are defined in `lib/validate_article.rb`, `lib/persist_article.rb`, and `lib/create_article.rb` files. We can make them all available in a container automatically with the following setup in a top-level my_app.rb file:
```ruby
require "dry-component"
require "dry/component/container"

class MyApp < Dry::Component::Container
  configure do |config|
    config.root = Pathname(__FILE__).realpath.dirname
    config.auto_register = "lib"
  end

  # Add "lib/" onto Ruby's load path
  load_paths! "lib"
end

# Finalize the container to run the auto-registration
MyApp.finalize!

# Now everything is ready for us to use
MyApp["validate_article"].("title" => "Hello world")
```

The autoregistration works great using a simple convention around file and class names.

[5. Better code with an inversion of control container](https://www.icelab.com.au/notes/better-code-with-an-inversion-of-control-container)

> High-level modules should not depend on low-level modules. Both should depend on abstractions.

> Abstractions should not depend on details. Details should depend on abstractions.

If we create `CreateArticle` without injecting dependencies (use class names `ValidateArticle` and `PersistArticle` in the class code), a high-level module (`CreateArticle`) will depend on low-level modules (`ValidateArticle`, `PersistArticle`)

```ruby
class CreateArticle
  include AutoInject["validate_article", "persist_article"]

  def call(params)
    result = validate_article.call(params)

    if result.success?
      persist_article.call(params)
    end
  end
end
```
It's easy to replace `validate_article` and `persist_article` with instances of other classes.
But any implementation that wants to behave as low-level “article validator” or “article persister” module must adhere to the interface expectations set here in the high-level module (e.g. both must respond to #call(attrs), and the validator’s call must return an object offering #success?, etc.).

Advantages:
- focus more on interface instead of implementation
- lower coupling between components

### Single responsibility
`CreateArticle` is readable in a single glance, it really has single responsibility.

> A class should have only one reason to change

### Function Composition
We work with a wide range of responsibility object.
Objects'll have narrower interfaces.

Objects'll be easier to understand and use.

Functional objects: their interface is only the `call` method, they're immutable.

Many functional objects are registered in a container.

An auto-inject statement acts more like a function import:
`include AutoInject[“validate_article”, “persist_article”]`

## [A change-positive Ruby web application architecture](https://www.icelab.com.au/notes/a-change-positive-ruby-web-application-architecture)

> A look into a post-Rails, post-MVC world

Rails’ implementation of MVC gives you a couple of large buckets to throw your code into and little else. And it comes with significant long-term risks.

AR models have too much responsibility: data modelling, persistence, validation, type coercion, your own domain logic and even more.

ActiveRecord’s API is so broad that the entire application winds up coupled to db schema.
You can even write arbitrary parts of your db schema from within a view template.

Rails wants to offer convenience above all else. But that way the app ends up saddling our app with a poor arrangement of responsibilities. It means that you effectively write your app *from inside its database adapter*.

So you write your app inside of Rails - it's your key architectural choice.

On the side of the models, you have the details of your database leaking everywhere, and from the controller side, you have HTTP details leaking everywhere. Rails gives you no hint about how to architect a clean app.

Rails apps offer productivity when you just get started but get harder and harder to change over time.

### A welcome change
Change-positive web apps should be:
- composed of many small pieces, tightly focused, loosely coupled.
- offer a facility to make it simple to combine these small pieces into larger, more complex ones.
- the flow of data through your system easy to follow (immutability, functional objects)

- stand alone (first - ruby app, then - web app)
- respect its boudaries
- choose appropriate tools to manage the work across these boundaries: http router, persistence library 
- provide its own distinct interfaces around these boundaries (mediate the data coming across these boundaries and shape them into forms that are sensible to use within our app’s own core components)
*use tools in service of our app, not the other way around*

Our app’s core high-level components should be oriented around verbs, not nouns.
A web app is really a series of actions. A single-focused, standalone component modelled as a verb is easier to change than a controller that does 7 different things.

Each of our app’s components should know as little as possible about the world outside - just enough information to access the other objects, as it needs to serve its function.

We should strive for simple, not easy. Stay mindful of opportunities for abstraction, of course, but never rush into them.

## [Put HTTP in its place with Roda](https://www.icelab.com.au/notes/put-http-in-its-place-with-roda/)
Apps boundaries: we need to interact with the external world (users, db, etc)

The first boundary: http request.
We need to keep our app’s core standing apart from any HTTP handling.
We need a tool that can handle HTTP on one side and interact with our app on another.

### An expressive, flexible HTTP toolkit
Roda is a “routing tree web toolkit”.
Roda processes each incoming request through this route block, branching by various matchers into increasingly specific routing blocks until a response is returned.
Context for a particular branch can be established just once and be used anywhere within it.
It has a slim core and a plugin system.

### A distinct HTTP interface for our app
`dry-web`
A plugin to make the objects in our app’s container readily available to use within Roda routes.
Ways that Roda interacts with your web app:
- `r.view` fetches an object from the container and sends `#call` to it right away (`r.view "views.articles.index"`), expecting that object to return HTML
- resolve objects from the container and make them available as variables for us to work with inside a route block
```ruby
  r.post do
    r.resolve "operations.create_article" do |create_article|
      # In reality, we'll want to handle success or failure differently
      # here, but this is a topic for another time.
      create_article.(r[:post])
      r.redirect "/articles"
    end
  end
```

## [A conversational introduction to rom-rb](https://www.icelab.com.au/notes/a-conversational-introduction-to-rom-rb)
Db persistence.
If we use ActiveRecord pattern, the models will be deeply intertwined with every aspect of your app functionality.

`rom-rm` - builds a clean separation of responsibilities.
It's a flexible persistence and data mapping toolkit for Ruby.

It separates queries and commands.
You'll have to learn several concepts, but you'll get a persistence layer, that can be tailored to your app's needs.

### Getting Started
Relations - the interface to a particular collection in our data source, which in SQL terms is either a table or a view.

Repositories - the primary persistence interfaces in our app.
- hide low-level persistence details
- return objects that are appropriate for your app's domain
```ruby
# uses `articles` relation
class Articles < ROM::Repository[:articles]
...
end
```
All relations and commands will be bundled in one container that can be injected to your app.
```ruby
config = ROM::Configuration.new(:sql, "sqlite::memory")
config.register_relation Relations::Articles
container = ROM.container(config)
# create a migration
# ...
# play
repo = Repositories::Articles.new(container)
first_article = repo.create(title: "Hello rom-rb")
puts repo.published.inspect
puts repo[first_article.id].inspect
```

https://www.icelab.com.au/notes/conversational-rom-rb-part-2-types-associations-and-update-commands














