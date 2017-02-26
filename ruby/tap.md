# [Object#tap](http://ruby-doc.org/core-2.4.0/Object.html#method-i-tap)
According to the docs it yields self to the block, and then returns self.
Used in order to perform operations on intermediate results within the chain.
```ruby
class Object
  def tap
    yield self
    self
  end
end
```

So instead of telling to do something and return the result it tells to do something and return the initial object.

```ruby
mood = 'stressed'

# not tapped
mood.reverse # prints "desserts" and returns "desserts"

# tapped
mood.tap { |m| p m.reverse } # prints "desserts" and returns "stressed"
```

So the object is unchanged, but the needed action is done in the block.
How can it be useful? 
In some situation this technique can make your code more compact:
```ruby
# instead of writing:
def mood_stuff(mood)
  ...
  p mood.reverse
  mood
end

# we can do:
def mood_stuff(mood)
  ...
  mood.tap{ |m| p m.reverse }
end
```

The compact version:
```ruby
some_object.tap(&:serialize)
```


