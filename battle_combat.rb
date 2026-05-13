# === COMBAT MECHANICS ===
module BattleCombat
  # Player attacks with damage calculation and critical hit chance
  def player_attack
    base = rand(1..@player.atk)
    crit_chance = (@player.crit || 0.0) + (@player.luck || 0.0)
    crit_chance = 1.0 if crit_chance > 1.0
    if rand < crit_chance
      damage = (base * 2).to_i
      @enemy.hp -= damage
      puts "You land a critical hit for #{damage} damage! [#{@enemy.name} HP: #{hp_display(@enemy.hp)}]"
    else
      damage = base
      @enemy.hp -= damage
      puts "You attack the #{@enemy.name} for #{damage} damage! [#{@enemy.name} HP: #{hp_display(@enemy.hp)}]"
    end

    if @enemy.hp <= 0
      puts "You defeated the #{@enemy.name}!"
      if rand < loot_drop_chance_for_room(@room)
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

  # Enemy attacks player with defense reduction
  def enemy_attack
    raw = rand(1..@enemy.atk)
    reduction = (@player.defense || 0)
    damage = raw - reduction
    damage = 1 if damage <= 0
    @player.hp -= damage
    puts "The #{@enemy.name} attacks you for #{damage} damage! [#{@player.name} HP: #{hp_display(@player.hp)}]"

    puts "You have been defeated..." if @player.hp <= 0
  end

  # Attempt to escape from battle - uses luck stat
  def attempt_run
    base_chance = 0.1
    luck = @player.luck || 0.0
    escape_chance = base_chance + luck
    escape_chance = 0.75 if escape_chance > 0.75

    if rand < escape_chance
      puts "You successfully escaped the room!"
      return true
    else
      puts "You failed to escape! The #{@enemy.name} strikes as you flee..."
      enemy_attack
      return false
    end
  end

  # Determine enemy grade based on room depth (affects difficulty)
  def select_grade_for_room(room)
    # return one of :C, :B, :A, :S based on room depth probabilities
    case room
    when 1..2
      choices = [:C, :C, :C, :C, :C] # keep the first rooms stable
    when 3..4
      choices = [:C, :C, :C, :B, :B, :A] # mostly C, some B, rare A
    when 5..7
      choices = [:C, :C, :B, :B, :A, :A, :S] # gradual rise in threat
    else
      choices = [:C, :B, :B, :A, :A, :S] # deeper rooms favor stronger grades
    end

    choices.sample
  end

  # Loot drop probability increases with room depth
  def loot_drop_chance_for_room(room)
    case room
    when 1..2
      0.4
    when 3..4
      0.45
    when 5..7
      0.5
    else
      0.55
    end
  end
end
