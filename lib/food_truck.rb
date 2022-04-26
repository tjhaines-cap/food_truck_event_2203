require 'pry'

class FoodTruck

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    item_stock = 0
    if @inventory[item]
      item_stock = @inventory[item]
    end
    return item_stock
  end

  def stock(item, amount)
    if @inventory[item]
      @inventory[item] += amount
    else
      @inventory[item] = amount
    end
  end

  def potential_revenue
    revenue = 0
    @inventory.each do |item, amount|
      revenue += (item.price) * amount.to_f
    end
    return revenue
  end

end
