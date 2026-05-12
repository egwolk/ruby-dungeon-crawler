require_relative 'inventory'
require_relative 'item'

class Player
  attr_accessor :name, :hp, :atk, :inventory, :gold

  def initialize(name, hp=100, atk=10)
    @name = name
    @hp = hp
    @atk = atk
    @inventory = Inventory.new
    @gold = gold
  end
end