# module_function tests

# Let's start with usual module method:

# module Adventurous
#   def lie_on_the_sofa
#     'Mm, comfy'
#   end
# end

# # mix into the class
# class Woman
#   include Adventurous
#   def initialize(name)
#     @name = name
#   end
# end

# ann = Woman.new('Ann')

# # now method is available for ann
# ann.lie_on_the_sofa # => 'Mm, comfy'
# # but not available with the module as a receiver
# Adventurous.lie_on_the_sofa # => NoMethodError

# What if we add module_function?

module Adventurous
  def lie_on_the_sofa
    'Mm, comfy'
  end

  module_function :lie_on_the_sofa
end

# Makes available as singleton methods, they may be called with the module as a receiver
Adventurous.lie_on_the_sofa # => 'Mm, comfy'
# Is lying on the sofa still available for ann?
# ann.lie_on_the_sofa
# => private method `lie_on_the_sofa' called for #<Woman:0x005647743da830 @name="Ann"> (NoMethodError)
# The instance-method became private. We can use it this way:

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

# Module functions are copies of the original, and so may be changed independently

# redefining method for classes with mixed module
module Adventurous
  def lie_on_the_sofa
    "I bought a new sofa, so it's even more comfy"
  end
end

# redefined
p ann.lie_on_the_sofa # => I bought a new sofa, so it's even more comfy
# singleton method remains the same
p Adventurous.lie_on_the_sofa # => 'Mm, comfy'