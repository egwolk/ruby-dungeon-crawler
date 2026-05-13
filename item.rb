class Item
  attr_reader :name, :type, :value, :stat, :grade, :grade_mult
  attr_accessor :equipped

  TYPES = {
    potion:  { 
      name: "Health Potion",  
      type: :potion,  
      value: 30, 
      stat: "hp",
    },
    sword: { 
      name: "Iron Sword",     
      type: :weapon,       
      value: 5, 
      stat: "atk",
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
    },
    hat: { 
      name: "Lucky Hat",     
      type: :hat,       
      value: 0.3, 
      stat: "luck",
    }
  }

  GRADE_MULT = {
    C: 1,
    B: 2,
    A: 3,
    S: 4
  }

  def initialize(type, grade = :C)
    item_data = TYPES[type]
    @name = item_data[:name]
    @type = item_data[:type]
    base_value = item_data[:value]
    @stat = item_data[:stat]
    @gold = item_data[:gold]
    @grade = grade
    @grade_mult = GRADE_MULT[grade] || 1
    @value = base_value * @grade_mult
    @equipped = false
  end

  def self.random_loot(grade = :C)
    new(TYPES.keys.sample, grade)
  end
end