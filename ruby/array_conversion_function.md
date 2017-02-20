# Kernel#Array
[Kernel#Array in ruby-doc](https://ruby-doc.org/core-2.4.0/Kernel.html#method-i-Array)  
One of the ruby capitalized built-in conversion functions. Takes an argument and tries hard to convert it to Array.

```ruby
Array(nil) # => []
Array('ruby') # => ['ruby']
Array([4,2]) # => [4,2]
Array(a: 'sheep', b: 'lamb') # => [[:a, 'sheep'], [:b, 'lamb']]
```

May be useful when you need to be able to handle both singular values and collections (and accidental nil values)

```ruby
class Sheep
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

lonely = Sheep.new('Indie')
friend = Sheep.new('Extravert')

def herd(sheep)
  cuties = Array(sheep)
  # no need to check if it's Array woo-hoo!
  cuties.each do |cutie|
    p "Sheep #{cutie.name} feels good!"
  end
end

herd(lonely) # => "Sheep Indie feels good!"
herd([lonely, friend])
#  => "Sheep Indie feels good!"
#     "Sheep Extravert feels good!"
```

But what if I try this with structs?

```ruby
Lamb = Struct.new(:name, :parent)

bubble = Lamb.new('Bubble', 'Indie')
lamp = Lamb.new('Lamp', 'Sun')

herd([bubble, lamp])
# => "Sheep Bubble feels good!"
#    "Sheep Lamp feels good!"
herd(bubble)
# => # => undefined method `name' for "Bubble":String (NoMethodError)
```
When Array conversion function gets Struct as an argument, it produces an array of its attributes.

```ruby
Array(bubble)
# => ["Bubble", "Indie"]
```
