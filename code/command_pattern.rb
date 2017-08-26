
# single-command, can be changed to manage multiple command
class PastureManager
  attr_accessor :commands

  def initialize(commands = [])
    @commands = commands
  end

  def add_command(command)
    commands.push command
  end

  def execute
    commands.each(&:execute)
  end
end

# command receivers
class Girl
  def sing
    puts 'Ba-ba, black sheep, have you any whool?'
  end
end

class Sheep
  def frolick
    puts 'Ba-Ba'
  end
end

# commands
class SheepCommand
  attr_accessor :sheep
  def initialize(sheep = Sheep.new)
    @sheep = sheep
  end

  def execute
    sheep.frolick
  end
end

class GirlCommand
  attr_accessor :girl
  def initialize(girl = Girl.new)
    @girl = girl
  end

  def execute
    girl.sing
  end
end


manager = PastureManager.new
manager.add_command(GirlCommand.new)
manager.add_command(SheepCommand.new)
manager.add_command(GirlCommand.new)
manager.execute

