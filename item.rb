class Item
  attr_reader :name, :type, :value, :stat, :gold

  TYPES = {
    heal_potion:  { 
      name: "Health Potion",  
      type: :heal_potion,  
      value: 30, 
      stat: "hp",
      gold: 25
    },
    sword: { 
      name: "Iron Sword",     
      type: :weapon,       
      value: 5, 
      stat: "atk",
      gold: 25
    }
  }

  def initialize(type)
    item_data = TYPES[type]
    @name = item_data[:name]
    @type = type
    @value = item_data[:value]
    @stat = item_data[:stat]
    @gold = item_data[:gold]
  end

  def self.random_loot
    new(TYPES.keys.sample)
  end
end