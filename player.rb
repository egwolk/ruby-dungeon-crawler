class Player
  attr_accessor :name, :hp, :atk

  def initialize(name, hp=100, atk=3)
    @name = name
    @hp = hp
    @atk = atk
  end
end