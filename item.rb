class Item
  attr_reader :name, :type, :value, :stat, :gold
  attr_accessor :equipped

  TYPES = {
    potion:  { 
      name: "Health Potion",  
      type: :potion,  
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
    },
    shield: { 
      name: "Sturdy shield",     
      type: :shield,       
      value: 7, 
      stat: "def",
      gold: 25
    },
    ring: { 
      name: "Ruby Ring",     
      type: :ring,       
      value: 0.7, 
      stat: "crit",
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
    @equipped = false
  end

  def self.random_loot
    new(TYPES.keys.sample)
  end
end