require_relative 'inventory'
require_relative 'item'

class Player
  attr_accessor :name, :hp, :atk, :inventory, :gold, :defense, :crit, :luck

  def initialize(name, hp=100, atk=10, defense=0, crit=0, luck=0.2)
    @name = name
    @hp = hp
    @atk = atk
    @inventory = Inventory.new
    @gold = gold
    @defense = defense
    @crit = crit
    @luck = luck
  end
end