module BattleCombat
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
        print "Take it? (Y/N)"
        take_loot = read_yes_no_choice
        system("clear") || system("cls")

        if take_loot == "y"
          @player.inventory.add_item(loot)
        else
          puts "You left the #{loot.name} behind..."
        end
      else
        print "But found no loot..."
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
