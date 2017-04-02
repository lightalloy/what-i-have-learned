# [Anti-Pattern: Iteratively Building a Collection](https://robots.thoughtbot.com/iteration-as-an-anti-pattern)
(Code from the article)

## Building and array
```ruby
def signer_key_ids
  result = []

  signers.each do |signer|
    result << signer.key_id
  end

  result
end

def signer_key_ids
  signers.map { |signer| signer.key_id }
end
```

## Building an array from multiple arrays

```ruby
def signer_uids
  result = []

  signers.each do |signer|
    result << signer.uids
  end

  result.flatten
end
```
=>
```ruby
def signer_uids
  signers.flat_map(&:uids)
end
```

## Build a hash from an array
```ruby
def signer_keys_and_uids
  result = {}

  signers.each do |signer|
    result[signer.key_id] = signer.uids
  end

  result
end
```
=>

```ruby
def signer_keys_and_uids
  signers.inject({}) do |result, signer|
    result.merge(signer.key_id => signer.uids)
  end
end
```

## Build a Boolean from an array
```ruby
def mutually_signed?
  result = true

  signers.each do |signer|
    result = result && signer.signed_by?(self)
  end

  result
end
```
=>
```ruby
def mutually_signed?
  signers.all?(&:signed_by?)
end
```
