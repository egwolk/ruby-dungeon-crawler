class Battle
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

  def player_attack
    base = rand(1..@player.atk)
    crit_chance = (@player.crit || 0.0) + (@player.luck || 0.0)
    crit_chance = 1.0 if crit_chance > 1.0
    if rand < crit_chance
      damage = (base * 2).to_i
      @enemy.hp -= damage
      puts "You land a critical hit for #{damage} damage! [#{@enemy.name} HP: #{@enemy.hp}]"
    else
      damage = base
      @enemy.hp -= damage
      puts "You attack the #{@enemy.name} for #{damage} damage! [#{@enemy.name} HP: #{@enemy.hp}]"
    end

    if @enemy.hp <= 0
      puts "You defeated the #{@enemy.name}!"
      if rand < 0.6  # 60% chance to get loot
        grade = select_grade_for_room(@room)
        loot = Item.random_loot(grade)
        puts "You found a #{loot.name} [#{loot.grade}]!"
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
    raw = rand(1..@enemy.atk)
    reduction = (@player.defense || 0)
    damage = raw - reduction
    damage = 0 if damage < 0
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
    when :potion
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

  def attempt_run
    base_chance = 0.2
    luck = @player.luck || 0.0
    escape_chance = base_chance + luck
    escape_chance = 0.95 if escape_chance > 0.95

    if rand < escape_chance
      puts "You successfully escaped the room!"
      return true
    else
      puts "You failed to escape! The #{@enemy.name} strikes as you flee..."
      enemy_attack
      return false
    end
  end

  def battle_over?
    @player.hp <= 0 || @enemy.hp <= 0
  end

  def select_grade_for_room(room)
    # return one of :C, :B, :A, :S based on room depth probabilities
    case room
    when 1..2
      choices = [:C, :C, :C, :B] # 75% C, 25% B
    when 3..4
      choices = [:C, :C, :B, :B, :A] # 40% C, 40% B, 20% A
    when 5..7
      choices = [:C, :B, :B, :A, :A, :S] # 16% C, 33% B, 33% A, 16% S approx
    else
      choices = [:C, :B, :A, :A, :S, :S] # deeper rooms favor A/S
    end

    choices.sample
  end
end