class Enemy
  attr_accessor :name, :hp, :atk
  attr_reader :grade, :grade_mult

  TYPES = [
    { name: "Goblin",   hp: 30,  atk: 5, },
    { name: "Orc",      hp: 60,  atk: 12 },
    { name: "Skeleton", hp: 40,  atk: 8  },
  ]

  def initialize(type)
    @name   = type[:name]
    @hp     = type[:hp]
    @atk = type[:atk]
    @grade = :C
    @grade_mult = 1
  end

  def self.random
    new(TYPES.sample)
  end

  GRADE_MULT = {
    C: 1,
    B: 2,
    A: 3,
    S: 4
  }

  # Apply a grade to this enemy, scaling hp and atk
  def apply_grade!(grade)
    grade = grade || :C
    mult = GRADE_MULT[grade] || 1
    # scale stats (round to integer)
    @hp = (@hp * mult).to_i
    @atk = (@atk * mult).to_i
    @grade = grade
    @grade_mult = mult
  end
end