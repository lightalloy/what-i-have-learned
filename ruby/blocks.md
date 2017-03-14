# Blocks

Check out [free excerpt "Using Blocks"](https://www.oreilly.com/learning/using-blocks-in-ruby) from the book "Head First Ruby" for a very detailed explanation. It's great!

A block is a chunk of code that you associate with a method call. While the
method runs, it can invoke (execute) the block one or more times. (Definition from the book).

Ordinary blocks usage:

```ruby
def do_fun_stuff(name)
  puts "#{name}: go for a walk"
  yield
  puts "drink tea"
end

# with block
do_fun_stuff('Anna') { puts 'learn bubble sort' }
# => 
# Anna: go for a walk
# learn bubble sort - the passed block run
# drink tea
```

A method usable both with and without a block:
```ruby
def do_fun_stuff(name)
  puts "#{name}: go for a walk"
  yield if block_given? # block code will run only if it's passed
  puts "drink tea"
end

# without a block
do_fun_stuff('Jane')
# => 
# Jane: go for a walk
# drink tea
```

Yielding a block multiple times:

```ruby
def do_fun_stuff(name)
  puts "#{name}: go for a walk"
  yield
  yield
  puts "drink tea"
end

do_fun_stuff('Anna') { puts 'sleep' }
# => 
# Anna: go for a walk
# sleep
# sleep
# drink tea
```

Yield can take parameters:

```ruby
def do_fun_things(name)
  puts "#{name}: go for a walk"
  yield(name)
  puts "drink tea"
end

do_fun_things('Daria') { |name| puts "Hi, #{name}" }
# Daria: go for a walk
# Hi, Daria
# drink tea
```

Slightly more complex example:
```ruby
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

def humanize(name)
  human = Human.new(name)
  yield(human)
  human.description
end

# Same method can be called with different blocks:
humanize('Anna') do |human|
  human.wear_hat('blue')
  human.interests = 'programming'
end
# =>
# name: Anna
# hat: blue hat
# interests: programming

humanize('Anna') do |human|
  human.interests = 'laziness'
end
# =>
# name: Anna
# hat: none
# interests: laziness
```

Reusing blocks:
```ruby
my_proc = ->(x) { p "some stuff is #{x}" }

def testing_blocks
  p "do stuff"
  yield
end

def testing_blocks2
  p "do stuff 2"
  yield
end

testing_blocks { my_proc }
testing_blocks2 { my_proc }

```

block.call instead of yield:
```ruby
def do_fun_stuff(name, &:fun_block)
  puts "#{name}: go for a walk"
  fun_block.call
  puts "drink tea"
end
```

But it's preferable to choose yield over &block, cause yield is much faster. (benchmarks)[http://mudge.name/2011/01/26/passing-blocks-in-ruby-without-block.html]

You can't pass more then one block:
```ruby
def test_blocks(&block1, &block2)
   block1.call
   block2.call 
end
# => syntax error, unexpected ',', expecting ')'
```

Method_missing with yield:
```ruby

```

