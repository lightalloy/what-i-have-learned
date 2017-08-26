# http://ruby-metaprogramming.rubylearning.com/html/ruby_metaprogramming_3.html

def who
  person = "Matz"
  p "who person - #{person}"
  yield("rocks")
end

person = "Matsumoto"
who do |y|
  puts("#{person}, #{y} the world") # => Matsumoto, rocks the world
  city = "Tokyo"
end
