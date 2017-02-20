# Draft

Ruby's Proc objects have the threequals defined as an alias to #call
Case statements use the "threequals" (#===) operator to determine if a condition matches.

matches
'''
even = ->(x) { (x % 2) == 0 }

case number
when 42
  puts "the ultimate answer"
when even
  puts "even"
else
  puts "odd"
end
'''