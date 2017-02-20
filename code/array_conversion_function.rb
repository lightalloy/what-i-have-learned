# Kernel#Array conversion function examples
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

herd(lonely) # "Sheep Indie feels good!"
herd([lonely, friend])
# "Sheep Indie feels good!"
# "Sheep Extravert feels good!"

# What if I try it with structs?
Lamb = Struct.new(:name)

bubble = Lamb.new('Bubble')
lamp = Lamb.new('Lamp')

herd([bubble, lamp])
# "Sheep Bubble feels good!"
# "Sheep Lamp feels good!"
begin
  herd(bubble)
# => undefined method `name' for "Bubble":String (NoMethodError)
rescue NoMethodError => e
  p e
end
