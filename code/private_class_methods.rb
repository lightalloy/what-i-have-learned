class LightAlloy
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def instance_play
    Setting.play("#{name}, play instance videos")
  end

  def self.public_play
    play('public videos')
  end

  def self.play(video)
    puts video
  end

  private_class_method :play
end

begin
  LightAlloy.play('something')
rescue NoMethodError => e
  puts "Sorry, #{e}"
end

LightAlloy.public_play

player = LightAlloy.new('Anna')

begin
  player.instance_play
rescue NoMethodError => e
  puts "Sorry, #{e}"
end
