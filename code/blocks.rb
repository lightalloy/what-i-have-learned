puts '----passing block to a method----'

# passing block to a method
def do_fun_stuff(name)
  puts "#{name}: go for a walk"
  yield# if block_given?
  puts "drink tea"
end
# without a block
# do_fun_stuff('Jane')
# => 
# Jane: go for a walk
# drink tea

# with block
do_fun_stuff('Anna') { puts 'learn bubble sort' }
# => 
# Anna: go for a walk
# learn bubble sort - the passed block run
# drink tea

puts '----yield with parameters----'
# yield with parameters

class Human
  attr_accessor :name, :hat, :interests
  def initialize(name)
  	@name = name
  end

  def wear_hat(colour = 'red')
  	@hat ||= "#{colour} hat"
  end

  def description
  	puts [:name, :hat, :interests].map { |key| "#{key}: #{public_send(key) || 'none'}" }.join("\n")
  end
end

def humanize(name, &block)
  human = Human.new(name)
  yield(human)
  human.description
end

# calling the same method with different blocks: 
# Ex. 1
humanize('Anna') do |human|
  human.wear_hat('blue')
  human.interests = 'programming'
end
# =>
# name: Anna
# hat: blue hat
# interests: programming

puts '-------------'
# Ex. 2
humanize('Anna') do |human|
  human.interests = 'laziness'
end
# =>
# name: Anna
# hat: none
# interests: laziness
puts '----yield with parameters simple----'

def do_fun_things(name)
  puts "#{name}: go for a walk"
  yield(name)
  puts "drink tea"
end

do_fun_things('Daria') { |name| puts "Hi, #{name}" }

# syntax with fun_block.call



