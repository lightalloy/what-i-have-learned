data = ''

path = '/home/light/sites/codegirls/input.csv.sample'

# long version
if File.exist?(path)
  if file = File.new(path, 'r')
    data << file.gets
  end
end

# won't work with &&
# File.exists?(path) && file = File.new(path, 'r') && data << file.gets

# ok with and
File.exist?(path) and file = File.new(path, 'r') and data << file.gets

p data
