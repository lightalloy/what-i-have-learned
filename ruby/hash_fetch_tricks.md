# [Hash#fetch](https://ruby-doc.org/core-2.4.0/Hash.html#fetch-method) for defaults

# TODO: link_to fetch

Hash#fetch can take a block. It's useful when you want to provide default values for missing keys.

```ruby
def hello(options)
  human = options.fetch(:human) { 'Fionna' }
  puts "Hello, #{human}"
end

hello(human: 'Finn', pet: 'Jake') # => Hello, Finn
hello(pet: 'Cake') # => Hello, Fionna
```

Using #fetch with a block is different from 
```ruby
human = options[:human] || 'Fionna'
```
because #fetch can distinguish falsey values from non-existant ones:
```ruby
# hello with fetch using block
def hello(options)
  human = options.fetch(:human) { 'Fionna' }
  phrase = human ? "Hello, #{human}" : "So sad, no humans"
end

# hello with ||
def unsafe_hello(options)
  human = options[:human] || 'Fionna'
  phrase = human ? "Hello, #{human}" : "So sad, no humans"
end

options = { pet: 'Cake', human: false }
hello(options) # => So sad, no humans
# But human is explicitly falsey, so there should be no default humans!
unsafe_hello(options) # => Hello, Fionna
```

## fetch blocks can be reusable
```ruby
DEFAULT_HUMAN = -> { Human.new('Fionna') }
human = options.fetch(:human, &DEFAULT_HUMAN)
```

### Two-argument #fetch

 #fetch can accept a second argument:
```ruby
human = options.fetch(:human, 'Fionna')
```

But there is a difference: the second argument is always evaluated whether it is needed or not.
The block is triggered only if needed.

So if you have or there is a probability to have some expensive computation for default value, use a block.

```ruby
human_cnt = options.fetch(:human_cnt) { default }

def default
  very_expensive_computation
end
```
