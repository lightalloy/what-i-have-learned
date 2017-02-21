# module_function
[Module#module_function in ruby-doc](http://ruby-doc.org/core-2.4.0/Module.html#method-i-module_function)

module_function has 2 effects:
- makes the methods available as singleton methods on the module by copying them
- makes the instance-methods private

What does that mean?

Let's start with usual module method:

```ruby
module Adventurous
  def lie_on_the_sofa
    'Mm, comfy'
  end
end

# mix into the class
class Woman
  include Adventurous
  def initialize(name)
    @name = name
  end
end

ann = Woman.new('Ann')
# now method is available for ann
ann.lie_on_the_sofa # => 'Mm, comfy'
```

Method became available for instances of class with mixed module.
Can we use #lie_on_the_sofa with the module as a receiver? No:

```ruby
Adventurous.lie_on_the_sofa # => NoMethodError
```

What if we add module_function?

```ruby
module Adventurous
  def lie_on_the_sofa
    'Mm, comfy'
  end

  module_function :lie_on_the_sofa
end
```

Now #lie_on_the_sofa can be called with the module as a receiver:

```ruby
Adventurous.lie_on_the_sofa # => 'Mm, comfy'
```

Can I still lie on the sofa?
```ruby
ann.lie_on_the_sofa # => private method `lie_on_the_sofa' called for #<Woman:0x005647743da830 @name="Ann"> (NoMethodError)
```

Sorry, Ann, this method is now private.
But no problem, I can lie on the sofa implicitly:
```ruby
class Woman
  include Adventurous
  def initialize(name)
    @name = name
  end

  def be_adventurous
    lie_on_the_sofa
  end
end

ann = Woman.new('Ann')
ann.be_adventurous # => 'Mm, comfy'
```

Module functions (singleton methods) are copies of the original methods. So they may be changed independently:

```ruby
# redefining method for classes with mixed module
module Adventurous
  def lie_on_the_sofa
    "I bought a new sofa, so it's even more comfy"
  end
end
# redefined
ann.lie_on_the_sofa # => I bought a new sofa, so it's even more comfy
# singleton method remains the same
Adventurous.lie_on_the_sofa # => Mm, comfy
```

module_function can be used with no arguments, this way all methods defined below it become module functions:
```ruby

module Adventurous
  module_function
  # another module function
  def lie_on_the_sofa
    'Mm, comfy'
  end
  # another module function
  def eat_burritoes
    'Mm, tasty'
  end
end

```

TODO: example usage in ruby standart libraries and possible usage in real life