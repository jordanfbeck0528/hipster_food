class Event

  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(specific_item)
    trucks = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item|
        # require "pry"; binding.pry
        trucks << food_truck if item[0] == specific_item
      end
    end
    trucks
  end

  def quantity_of_item(item)
    @food_trucks.sum do |food_truck|
      food_truck.inventory[item]
    end
  end

  def all_items
    @food_trucks.map do |food_truck|
      food_truck.inventory.keys
    end.flatten.uniq
  end

  def total_inventory
    total = {}
    all_items.each do |item|
      total[item] = {
      quantity: quantity_of_item(item),
      food_trucks: food_trucks_that_sell(item)
      }
    end
    total
  end

  def overstocked_items
    all_items.select do |item|
      quantity_of_item(item) > 50 &&
      food_trucks_that_sell(item).count >= 2
    end
  end
end
