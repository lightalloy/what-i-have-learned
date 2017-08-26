# Composition over Inheritance

Inheritance: share the code from parents to children.

Composition: use other classes and modules, rather than rely on implicit inheritance.
Illustrates a has_a relationship between objects.
Encapsulation, de-coupling, delegation.

'''
class Other
  def other_foo
    puts "other foo"
  end

  def altered
    puts "altered"
  end
end
class Child

  attr_reader :other

  def initialize()
    @other = Other.new()
  end

  def other_foo
    other.other_foo
  end

  def altered
    puts "child altered start"
    other.altered
    puts "child altered end"
  end
end
'''
Other way: using modules and mixins.

Inheritance creates highly coupled classes.
Composition allows to keep objects independent. But if there are many objects, there might be a lot of work.


