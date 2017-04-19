# Squiggly heredoc syntax for multiline strings

Usual:
```ruby
def song
  <<-SONG
    Twinkle, twinkle, little star,
    How we wonder what you are.
    Up above the world so high,
    Like a diamond in the sky.
  SONG
end

puts "song with spaces"
p song
# => "    Twinkle, twinkle, little star,\n    How we wonder what you are.\n    Up above the world so high,\n    Like a diamond in the sky.\n"
```
Squiggly:
```ruby
def squiggly_song
  <<~HEREDOC
    Twinkle, twinkle, little star,
    How we wonder what you are.
    Up above the world so high,
    Like a diamond in the sky.
  HEREDOC
end
puts "squiggly song - without spaces"
p squiggly_song
# => "Twinkle, twinkle, little star,\nHow we wonder what you are.\nUp above the world so high,\nLike a diamond in the sky.\n"
```
