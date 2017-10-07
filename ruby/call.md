# Short syntax for #call

If you implement a #call method for a certain object, you can use it via dot:

obj.() instead of obj.call

```ruby
class RobotService
  def call(times = 1)
    times.times do |_i|
      puts 'Robot Dance!'
    end
  end
end

robo = RobotService.new
puts 'robo.call'
robo.call # => Robot Dance!

puts 'robo.(2)'
robo.(2)
# =>
# Robot Dance!
# Robot Dance!

puts 'robo.()'
robo.()
# =>
# Robot Dance!

```

