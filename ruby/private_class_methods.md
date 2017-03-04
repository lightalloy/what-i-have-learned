# [Private class methods](http://ruby-doc.org/core-2.4.0/Module.html#method-i-module_function)

Defining private class methods:
```ruby
private_class_method :some_method
```

Usage:

```ruby
class LightAlloy
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.public_play
    play('public videos')
  end

  def self.play(video)
    puts video
  end

  private_class_method :play
end
```

You can't directly access private methods:
```ruby
LightAlloy.play('something')
# => NoMethodError: private method `play' called for LightAlloy:Class
```

You can access private methods in public class methods:

```ruby
LightAlloy.public_play
# => public videos
```

In instance methods you have to call class methods with a receiver like this:
```ruby
def instance_play
  Setting.play("#{name}, play instance videos")
end
```
So you can't use private class methods in instance methods.


Alternate syntax to make method private:
```ruby
class LightAlloy
  class << self
    private
    def play(video)
      puts video
    end
  end
end
# method is private
LightAlloy.play('something')
# => NoMethodError: private method `play' called for LightAlloy:Class
```

Usual private will not take effect:
```ruby
class LightAlloy
  private
  def play(video)
    puts video
  end
end
# it's public method:
LightAlloy.play('some_video') # => some_video
```

private_class_method is often used to (hide the default constructor new)[http://ruby-doc.org/core-2.4.0/Module.html#method-i-private_class_method].