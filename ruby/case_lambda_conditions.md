# Case lambda conditions
Case statements use the "threequals" (link!) (#===) operator to determine if a condition matches.

Ruby's Proc objects have the threequals defined as an alias to #call
So we can use procs in cases:

```ruby
def string_fact(str)
  str = str.to_s

  # defining procs
  short = ->(x) { x.size < 5 }
  good = ->(x) { x.include?('super') }

  case str
  when short
    puts 'String is too short'
  when 'super-puper'
    puts "That's super-puper!"
  when good
    puts 'String is good enough'
  else
    puts 'Suspicious long string'
  end
end

string_fact('super-puper') # => That's super-puper!
string_fact('good') # =>  String is too short
string_fact('super-ruby-developer') # => String is good enough
string_fact('malicious') # => Suspicious long string

```