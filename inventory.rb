class Inventory
  def initialize(max_slots = 10)
    @items = []
    @max_slots = max_slots
  end

  def add_item(item)
    if @items.size < @max_slots
      @items << item
      puts "You picked up #{item.name}!"
      return true
    else
      puts "Inventory full! Cannot pick up #{item.name}."
      return false
    end
  end

  def remove_item(index)
    @items.delete_at(index)
  end

  def items
    @items
  end

  def list
    if @items.empty?
      puts "It is empty."
    else
      puts "\n--- Inventory (#{@items.size}/#{@max_slots}) ---"
      @items.each_with_index do |item, index|
        equipped_mark = item.equipped ? " [equipped]" : ""
        puts "#{index + 1}. [#{item.grade}] #{item.name} #{item.stat} #{item.value}#{equipped_mark}"
      end
    end
  end

  def equip_item(index, player)
    item = @items[index]
    equippable = [:weapon, :shield, :ring, :hat]
    unless item && equippable.include?(item.type)
      puts "Can't equip that item."
      puts "[ENTER]continue"
      gets
      system("clear") || system("cls")
      return
    end

    slot = item.type

    # If another item of same slot is equipped, switch to the new one
    existing = @items.find { |i| i.equipped && i.type == slot }
    if existing && existing != item
      unequip_item(@items.index(existing), player)
    end

    if item.equipped
      puts "#{item.name} is already equipped."
      puts "[ENTER]continue"
      gets
      system("clear") || system("cls")
      return
    end

    item.equipped = true
    case slot
    when :weapon
      player.atk += item.value
    when :shield
      player.defense += item.value
    when :ring
      player.crit += item.value
      player.crit = 1.0 if player.crit > 1.0
    when :hat
      player.luck += item.value
      player.luck = 1.0 if player.luck > 1.0
    end
    puts "You equipped #{item.name}."
    puts "[ENTER]continue"
    gets
    system("clear") || system("cls")
  end

  def unequip_item(index, player)
    item = @items[index]
    unless item && item.equipped
      puts "That item is not equipped."
      puts "[ENTER]continue"
      gets
      system("clear") || system("cls")
      return
    end

    item.equipped = false
    case item.type
    when :weapon
      player.atk -= item.value
    when :shield
      player.defense -= item.value
    when :ring
      player.crit -= item.value
      player.crit = 0.0 if player.crit < 0.0
    when :hat
      player.luck -= item.value
      player.luck = 0.0 if player.luck < 0.0
    end
    puts "You unequipped #{item.name}."
    puts "[ENTER]continue"
    gets
    system("clear") || system("cls")
  end

  def size
    @items.size
  end

  def full?
    @items.size >= @max_slots
  end
end
