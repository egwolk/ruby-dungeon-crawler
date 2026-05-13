require_relative 'inventory'
require_relative 'item'

class Player
  attr_accessor :name, :hp, :atk, :inventory, :defense, :crit, :luck

  def initialize(name, hp=110, atk=11, defense=1, crit=0.05, luck=0.1)
    @name = name
    @hp = hp
    @atk = atk
    @inventory = Inventory.new
    @defense = defense
    @crit = crit
    @luck = luck
  end
end