class Battle
  def initialize(player, enemy)
    @player = player
    @enemy = enemy
  end

  def start
    puts "\nA wild #{@enemy.name} appears! [HP: #{@enemy.hp}]"

    loop do
      puts "Adventurer #{@player.name} stats [HP: #{@player.hp} | ATK: #{@player.atk}]"
      puts "\nWhat will you do?"
      puts "1. Attack"
      puts "2. Inventory"
      puts "3. Run"
      puts "4. Give Up"

      choice = gets.chomp

      case choice
      when "1" then player_attack
      when "2" then show_inventory
      when "3" then puts "Run coming soon!"
      when "4" then puts "Coming soon!"
      else puts "Invalid choice."
      end

      break if battle_over?
    end
  end

  private

  def player_attack
    damage = rand(1..@player.atk)
    @enemy.hp -= damage
    puts "You attack the #{@enemy.name} for #{damage} damage! [#{@enemy.name} HP: #{@enemy.hp}]"

    if @enemy.hp <= 0
      puts "You defeated the #{@enemy.name}!"
      if rand < 0.6  # 60% chance to get loot
        loot = Item.random_loot 
        puts "You found a #{loot.name}!"
        puts "Take it? (Y/N)"
        take_loot = gets.chomp.downcase
        
        if take_loot == "y"
          @player.inventory.add_item(loot)
        else
          puts "You left the #{loot.name} behind."
        end
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
    puts "The #{@enemy.name} attacks you for #{damage} damage!"

    puts "You have been defeated..." if @player.hp <= 0
  end

  def show_inventory
    puts "\nYou check your bag..."
    @player.inventory.list

    return if @player.inventory.items.empty?

    puts "\nWhat would you like to do?"
    puts "Enter item number to use, 'e' to equip, 'u' to unequip, 'd' to discard, or '0' to go back:"
    choice = gets.chomp.downcase

    if choice == "0"
      return
    elsif choice == "d"
      discard_item
    elsif choice == "e"
      puts "Which item number to equip?"
      num = gets.chomp.to_i
      if num > 0 && num <= @player.inventory.items.size
        @player.inventory.equip_item(num - 1, @player)
      else
        puts "Invalid selection."
      end
    elsif choice == "u"
      puts "Which item number to unequip?"
      num = gets.chomp.to_i
      if num > 0 && num <= @player.inventory.items.size
        @player.inventory.unequip_item(num - 1, @player)
      else
        puts "Invalid selection."
      end
    elsif choice.to_i > 0 && choice.to_i <= @player.inventory.items.size
      item = @player.inventory.items[choice.to_i - 1]
      use_item(item, choice.to_i - 1)
    else
      puts "Invalid selection."
    end
  end

  def discard_item
    puts "\nWhich item do you want to discard? (Enter number):"
    choice = gets.chomp.to_i
    
    if choice > 0 && choice <= @player.inventory.items.size
      item = @player.inventory.items[choice - 1]
      puts "Are you sure you want to discard #{item.name}? (Y/N)"
      confirm = gets.chomp.downcase
      
      if confirm == "y"
        # If item is equipped, unequip first to adjust stats
        if item.equipped
          @player.inventory.unequip_item(choice - 1, @player)
        end
        @player.inventory.remove_item(choice - 1)
        puts "You discarded the #{item.name}."
      else
        puts "You decided to keep it."
      end
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