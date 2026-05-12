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
      if rand < 0.6  # 60% chance to get loot
        loot = Item.random_loot 
        @player.inventory.add_item(loot)
      else
        puts "But found no loot..."
      end
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
    
    return if @player.inventory.items.empty?
    
    puts "\nSelect an item to use (or 0 to go back):"
    choice = gets.chomp.to_i
    
    if choice == 0
      return
    elsif choice > 0 && choice <= @player.inventory.items.size
      item = @player.inventory.items[choice - 1]
      use_item(item, choice - 1)
    else
      puts "Invalid selection."
    end
  end

  def use_item(item, index)
    case item.type
    when :heal_potion
      puts "\nDrink #{item.name} to restore #{item.value} HP? (Y/N)"
      confirm = gets.chomp.downcase
      
      if confirm == "y"
        old_hp = @player.hp
        @player.hp += item.value
        @player.hp = 100 if @player.hp > 100  # Cap at max HP
        puts "You drank the potion and restored #{@player.hp - old_hp} HP!"
        @player.inventory.remove_item(index)
      else
        puts "You decided not to use it."
      end
    else
      puts "You can't use that right now."
    end
  end

  def battle_over?
    @player.hp <= 0 || @enemy.hp <= 0
  end
end