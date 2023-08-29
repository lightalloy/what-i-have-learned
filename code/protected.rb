class Food
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def price; 10; end

  protected

  def protected_price; 7 end

  private

  def private_price; 5; end
end

class Tomato < Food

  def price_info
    "#{name}: #{price} rub"
  end

  def protected_price_info
    "#{name}: #{protected_price} rub"
  end

  def private_price_info
    "#{name}: #{private_price} rub"
  end

  protected

  def protected_price
    10
  end

  # def protected_for_tomatoes
  #   'just for tomatoes'
  # end
end

tomato = Tomato.new('red tomato')

# You can call protected and private methods in subclasses

p tomato.price_info
p tomato.protected_price_info
p tomato.private_price_info

# You can call protected methods if the caller is_a? other_food.class
class Cucumber < Food
  def compare_prices(other_food)
    p "#{price} vs #{other_food.price}"
    p "#{protected_price} vs #{other_food.protected_price}" # => ok!
    # No siblings!
    # p other_food.protected_for_tomatoes # protected method `protected_for_tomatoes' called for #<Tomato:
    # p another_food.private_price # NoMethodError
  end

  protected

  def protected_price
    4
  end
end

cucumber = Cucumber.new('green guy')
cucumber2 = Cucumber.new('small one')

cucumber.compare_prices(tomato)
# cucumber.compare_prices(cucumber2)

exit

class Car
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def price; 20; end
  def protected_price; 15; end

  def compare_prices(other_item)
    p "#{price} vs #{other_item.price}"
    p "#{protected_price} vs #{other_item.protected_price}" # => protected method `protected_price' called for #<Cucumber:
  end
end

p Car.new('zhiguli').compare_prices(cucumber)





