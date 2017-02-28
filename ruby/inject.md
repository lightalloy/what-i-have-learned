# [Enumerable#inject](http://ruby-doc.org/core-2.4.0/Enumerable.html#method-i-inject)

Alias to #reduce.

Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.

Just slightly more verbose examples from docs:
```ruby
# Sum some numbers
(2..5).reduce(:+)                             #=> 2+3+4+5 = 14
# Same using a block and inject
(2..5).inject { |sum, n| sum + n }            #=> 2+3+4+5 = 14

# Multiply some numbers
(2..4).inject(10, :*) # 2*3*4*10 => 240
# Same using a block
(2..4).inject(10) { |result, n| result * n } # 2*3*4*10 => 240

# finding biggest number in array
[10, 2, 39, 43 , 5, 10].inject { |memo, a| memo > a ? memo : a }
# 10 vs 2
# 10 vs 39
# 39 vs 43
# 43 vs 5
# 10 vs 5

# find the longest word
longest = %w{ cat sheep bear catapulta ada }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
# detecting longest word on each step
# cat vs sheep
# sheep vs bear
# sheep vs catapulta
# catapulta vs ada

longest # => catapulta

# Injecting hash
LETTERS = [:a, :b, :c]
LETTERS.inject({}) do |hash, n|
  hash[n] = n.to_s.ord
  p hash
  hash
end

# {:a=>1}
# {:a=>1, :b=>2}
# {:a=>1, :b=>2, :c=>3}
```

