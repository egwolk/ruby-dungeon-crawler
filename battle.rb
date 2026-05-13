require_relative 'battle_combat'
require_relative 'battle_inventory'
require_relative 'battle_items'

class Battle
  include BattleCombat
  include BattleInventory
  include BattleItems

  def initialize(player, enemy, room)
    @player = player
    @enemy = enemy
    @room = room
    # scale enemy by room-based grade when battle starts
    enemy_grade = select_grade_for_room(@room)
    @enemy.apply_grade!(enemy_grade) if @enemy.respond_to?(:apply_grade!)
  end

  def start
    puts "\nA wild #{@enemy.name} appears! [HP: #{@enemy.hp}]"

    loop do
      puts "Adventurer #{@player.name} stats [HP: #{@player.hp} | ATK: #{@player.atk} | DEF: #{@player.defense} | CRIT: #{@player.crit} | LUCK: #{@player.luck}]"
      puts "\nWhat will you do?"
      puts "1. Attack"
      puts "2. Inventory"
      puts "3. Run"
      puts "4. Give Up"

      choice = gets.chomp

      case choice
      when "1" then player_attack
      when "2" then show_inventory
      when "3"
        escaped = attempt_run
        break if escaped
      when "4"
        puts "Adventurer #{@player.name} surrenders and could not defeat the dungeon."
        @player.hp = 0
      else puts "Invalid choice."
      end

      break if battle_over?
    end
  end

  private

  def battle_over?
    @player.hp <= 0 || @enemy.hp <= 0
  end
end
