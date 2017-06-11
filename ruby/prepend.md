# Module#prepend

```ruby
module Eating
  def action
    puts 'eat'
  end
end

# including module
class Parent; end

class Human < Parent
  include Eating
end

Human.ansestors
# => [Human, Eating, Parent, Object, Kernel, BasicObject]

# prepending module
class Human < Parent
  prepend Eating
end

Human.ansestors
# => [Eating, Human, Parent, Object, Kernel, BasicObject]
```

Prepend puts the module to the beginning of the ancestor chain.

```ruby
class Parent
  def action
    puts 'work'
  end
end

module MoreActions
  def action
    puts 'exciting stuff'
    super
  end
end

class Human < Parent
  prepend MoreActions
  def action
    puts 'live'
    super
  end
end

Human.new.action
# =>
# exciting stuff
# live
# work
```

If I would include MoreActions instead of prepend:
```ruby
Human.new.action
# =>
# live
# exciting stuff
# work
```
