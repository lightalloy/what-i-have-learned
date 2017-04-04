# [And/or vs &&/||](http://www.virtuouscode.com/2014/08/26/how-to-use-rubys-english-andor-operators-without-going-nuts/)

English operators and/or have much lower operator precendece than &&/||
So don't use and/or in boolean calculations.

They can be used for control flow:

```ruby
$stdin.gets or raise 'smth'
# same as
raise 'smth' unless $stdin.gets
```

```ruby
do_smth and notify 'smth'
# same as
notify 'smth' if do_smth
```

Another example:

```ruby
data = ''
path = '/some/path/to/file.txt'

# long version
if File.exist?(path)
  if file = File.new(path, 'r')
    data << file.gets
  end
end

# won't work with &&
# File.exists?(path) && file = File.new(path, 'r') && data << file.gets

# ok with and
File.exists?(path) and file = File.new(path, 'r') and data << file.gets
```
