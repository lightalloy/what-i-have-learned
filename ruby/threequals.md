# Threequals
[Object#===](http://ruby-doc.org/core-2.4.0/Object.html#method-i-3D-3D-3D)

Usual equality: #== returns true only if obj and other are the same object.
Threequals (or case equality): #=== , the same as #==, but typically overridden by descendants to provide meaningful semantics in case statements

E.g. regexp threequals check if string matches:
```ruby
regexp = /^[a-z]*$/
car = 'red_devyatka'

regexp == car # => false
regexp === car # => true

# in case statement
sound = 'aaaaaa'

case sound
when'aaa' then '3 a'
when /^[a-z]*$/ then 'silent'
when /^[A-Z]*$/ then 'loud'
else
  'strange'
end
# => silent
```
