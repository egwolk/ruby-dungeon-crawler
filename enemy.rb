class Enemy
  attr_accessor :name, :hp, :atk

  TYPES = [
    { name: "Goblin",   hp: 30,  atk: 5  },
    { name: "Orc",      hp: 60,  atk: 12 },
    { name: "Skeleton", hp: 40,  atk: 8  },
  ]

  def initialize(type)
    @name   = type[:name]
    @hp     = type[:hp]
    @atk = type[:atk]
  end

  def self.random
    new(TYPES.sample)
  end
end