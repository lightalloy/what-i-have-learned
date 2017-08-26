Inject dependencies into objects rather than having objects creating their dependencies.

http://solnic.eu/2013/12/17/the-world-needs-another-post-about-dependency-injection-in-ruby.html

```ruby
class Hacker

  def self.build(layout = 'us')
    new(Keyboard.new(:layout => layout))
  end

  def initialize(keyboard)
    @keyboard = keyboard
  end

  # stuff
end


Hacker.build('us')

# there might be a case we already have a keyboard, that's gonna work too
Hacker.new(keyboard_we_already_had)
```

https://www.icelab.com.au/notes/effective-ruby-dependency-injection-at-scale

