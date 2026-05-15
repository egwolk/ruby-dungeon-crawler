require_relative 'inventory'
require_relative 'item'

# === PLAYER CLASS ===
class Player
  attr_accessor :name, :hp, :atk, :inventory, :defense, :crit, :luck

  # Balanced base stats: slightly lower HP/ATK to allow item scaling to matter
  def initialize(name, hp=100, atk=10, defense=1, crit=0.05, luck=0.01)
    @name = name
    @hp = hp
    @atk = atk
    @inventory = Inventory.new
    @defense = defense
    @crit = crit
    @luck = luck
  end
end