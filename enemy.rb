# === ENEMY CLASS ===
class Enemy
  attr_accessor :name, :hp, :atk
  attr_reader :grade, :grade_mult

  # Enemy type definitions
  TYPES = [
    { name: "Goblin",   hp: 32,  atk: 7 },
    { name: "Orc",      hp: 48,  atk: 13 },
    { name: "Skeleton", hp: 40,  atk: 9  },
  ]

  def initialize(type)
    @name   = type[:name]
    @hp     = type[:hp]
    @atk = type[:atk]
    @grade = :C
    @grade_mult = 1
  end

  def self.random(room = 1)
    pool = case room
    when 1..2
      [TYPES[0], TYPES[0], TYPES[0], TYPES[2]]
    when 3..4
      [TYPES[0], TYPES[0], TYPES[1], TYPES[2]]
    else
      [TYPES[0], TYPES[1], TYPES[1], TYPES[2], TYPES[2]]
    end

    new(pool.sample)
  end

  # Grade multipliers for difficulty scaling
  GRADE_MULT = {
    C: 1.0,
    B: 1.3,
    A: 1.6,
    S: 2.2
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