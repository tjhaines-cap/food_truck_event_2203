

class Item

  attr_reader :name, :price

  def initialize(item_info_hash)
    @name = item_info_hash[:name]
    @price = item_info_hash[:price].gsub("$", "").to_f
  end

end
