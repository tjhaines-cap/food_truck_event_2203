require './lib/item'
require './lib/food_truck'
require './lib/event'

describe Event do

  it 'exists and had readable attributes' do
    event = Event.new("South Pearl Street Farmers Market")
    expect(event).to be_a(Event)
    expect(event.name).to eq("South Pearl Street Farmers Market")
    expect(event.food_trucks).to eq([])
  end

  describe 'iteration 2' do

    before (:each) do
      @event = Event.new("South Pearl Street Farmers Market")
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @item1 = Item.new({name: "Peach Pie (Slice)", price: "$3.75"})
      @item2 = Item.new({name: "Apple Pie (Slice)", price: "$2.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @food_truck3.stock(@item1, 65)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can add food trucks' do
      expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    end

    it 'can list food truck names' do
      expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can list food trucks that sell a given item' do
      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
      expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
    end
  end

  describe 'iteration 3' do

    before (:each) do
      @event = Event.new("South Pearl Street Farmers Market")
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @item1 = Item.new({name: "Peach Pie (Slice)", price: "$3.75"})
      @item2 = Item.new({name: "Apple Pie (Slice)", price: "$2.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can return a list of sorted items' do
      expect(@event.sorted_item_list).to eq([@item2, @item4, @item1, @item3])
    end

    it 'can create a hash with each items number of trucks it is in and total quantity' do
      expect(@event.item_occurrences_quantity).to eq({
        @item1 => [2, 100],
        @item2 => [1, 7],
        @item3 => [2, 35],
        @item4 => [1, 50]
        })
    end

    it 'can determine overstocked items' do
      expect(@event.overstocked_items).to eq([@item1])
    end

    it 'can put total inventory into a hash' do
      expect(@event.total_inventory).to eq({
    @item1 => {
       quantity: 100,
       food_trucks: [@food_truck1, @food_truck3]
     },
     @item2 => {
       quantity: 7,
       food_trucks: [@food_truck1]
     },
     @item4 => {
       quantity: 50,
       food_trucks: [@food_truck2]
     },
     @item3 => {
       quantity: 35,
       food_trucks: [@food_truck2, @food_truck3]
     },
   })
    end
  end

  describe 'iteration 4' do

    before (:each) do
      @event = Event.new("South Pearl Street Farmers Market")
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @item1 = Item.new({name: "Peach Pie (Slice)", price: "$3.75"})
      @item2 = Item.new({name: "Apple Pie (Slice)", price: "$2.50"})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'has a date' do
      allow(Date).to receive(:today).and_return(Date.parse("24-02-2020"))
      event1 = Event.new("Hot Air Balloon Festival")
      expect(event1.date).to eq("24/02/2020")
    end

    it 'can sell items' do
      expect(@event.sell(@item1, 200)).to eq(false)
      expect(@event.sell(@item5, 1)).to eq(false)
      expect(@event.sell(@item4, 5)).to eq(true)
      expect(@food_truck2.check_stock(@item4)).to eq(45)
      expect(@event.sell(@item1, 40)).to eq(true)
      expect(@food_truck1.check_stock(@item1)).to eq(0)
      expect(@food_truck3.check_stock(@item1)).to eq(60)
    end

  end

end
