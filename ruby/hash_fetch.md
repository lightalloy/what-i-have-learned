# [Hash#fetch](https://ruby-doc.org/core-2.4.0/Hash.html#fetch-method)

If hash keys are required for further operations, you can assert their presence by Hash#fetch
Let's compare Hash#fetch with Hash#[]:
```ruby
def unsafe_hello(options)
  human = options[:human]
  puts "Hello, #{human}"
end

def hello(options)
  human = options.fetch(:human)
  puts "Hello, #{human}"
end

# Fetching existing keys:
options = { pet: 'Pie', human: 'Fionna' }
# Same output:
unsafe_hello(options) # => 'Fionna' 
hello(options) # => 'Fionna'

# Fetching non-existant keys:
invalid_options = { humon: 'Susan Strong' } # oops, typo
# Typo remains unnoticed with #[] and may cause problems later
unsafe_hello(options) # => 'Hello, '
hello(invalid_options) # => KeyError: key not found: :human
```

Hash#fetch discerns falsey values (nil or false) from non-existant ones:

```ruby
# We can handle falsey values
valid_options = { human: 'Susan Strong', pet: nil }
valid_options.fetch(:pet) # => nil
```

# TODO: #fetch with block