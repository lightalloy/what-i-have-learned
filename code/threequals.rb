# example for threequals with regexps

regexp = /^[a-z_]*$/
car = 'red_devyatka'

p regexp == car # => false
p regexp === car # => true

# in case statement
sound = 'aaaaaa'

sound_type = case sound
when'aaa' then '3 a'
when /^[a-z]*$/ then 'silent'
when /^[A-Z]*$/ then 'loud'
else
  'strange'
end
p sound_type # => silent
