require 'date'

class Event

  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Date.today
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    names_arr = []
    @food_trucks.each do |food_truck|
      names_arr << food_truck.name
    end
    return names_arr
  end

  def food_trucks_that_sell(item)
    food_trucks_sell_item = []
    @food_trucks.each do |food_truck|
      if food_truck.inventory.include?(item)
        food_trucks_sell_item << food_truck
      end
    end
    return food_trucks_sell_item
  end

  def sorted_item_list
    item_list = []
    @food_trucks.each do |food_truck|
      item_list << food_truck.inventory.keys
    end
    uniq_item_list = item_list.flatten.uniq
    sorted_list = uniq_item_list.sort{|item1, item2| item1.name <=> item2.name}
  end

  def item_occurrences_quantity
    item_occurrences_quantity = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
        if item_occurrences_quantity[item]
          item_occurrences_quantity[item][0] += 1
          item_occurrences_quantity[item][1] += amount
        else
          item_occurrences_quantity[item] = [1, amount]
        end
      end
    end
    return item_occurrences_quantity
  end

  def overstocked_items
    item_occurrences_quantity_hash = item_occurrences_quantity
    overstocked = []
    item_occurrences_quantity_hash.each do |item, occurrences_quantity|
      if (occurrences_quantity[0] >= 2) && (occurrences_quantity[1] >=50)
        overstocked << item
      end
    end
    return overstocked
  end

  def total_inventory
    inventory_hash = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
        if inventory_hash[item]
          inventory_hash[item][:quantity] += amount
          inventory_hash[item][:food_trucks] << food_truck
        else
          inventory_hash[item] = {quantity: amount, food_trucks: [food_truck]}
        end
      end
    end
    return inventory_hash
  end

  def date
    date_str = @date.strftime("%d/%m/%Y")
    return date_str
  end

  def sell(item, amount)
    sold = false
    inventory_hash = total_inventory
    if inventory_hash[item] && inventory_hash[item][:quantity] > amount
      sold = true
      inventory_hash[item][:food_trucks].each do |food_truck|
        amount = food_truck.sell(item, amount)
        if amount == 0
          break
        end
      end
    end
    return sold
  end
end
