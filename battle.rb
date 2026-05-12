class Battle
  def initialize(player, enemy)
    @player = player
    @enemy = enemy
  end

  def start
    puts "\nA wild #{@enemy.name} appears! (HP: #{@enemy.hp})"

    loop do
      puts "\nWhat will you do?"
      puts "1. Attack"
      puts "2. Inventory"
      puts "3. Run"

      choice = gets.chomp

      case choice
      when "1" then player_attack
      when "2" then show_inventory
      when "3" then puts "Run coming soon!"
      else puts "Invalid choice."
      end

      break if battle_over?
    end
  end

  private

  def player_attack
    damage = rand(1..@player.atk)
    @enemy.hp -= damage
    puts "You attack the #{@enemy.name} for #{damage} damage! (#{@enemy.name} HP: #{@enemy.hp})"

    if @enemy.hp <= 0
      puts "You defeated the #{@enemy.name}!"
      loot = Item.random_loot 
      @player.inventory.add_item(loot)
      return
    end
    enemy_attack
  end

  def enemy_attack
    damage = rand(1..@enemy.atk)
    @player.hp -= damage
    puts "The #{@enemy.name} attacks you for #{damage} damage! (Your HP: #{@player.hp})"

    puts "You have been defeated..." if @player.hp <= 0
  end

  def show_inventory
    puts "\nYou check your bag..."
    @player.inventory.list
  end

  def battle_over?
    @player.hp <= 0 || @enemy.hp <= 0
  end
end