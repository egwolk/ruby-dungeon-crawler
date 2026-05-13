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
      puts "Your inventory is empty."
    else
      puts "\n--- Inventory (#{@items.size}/#{@max_slots}) ---"
      @items.each_with_index do |item, index|
        equipped_mark = item.equipped ? " [equipped]" : ""
        puts "#{index + 1}. #{item.name} #{item.stat} #{item.value}#{equipped_mark}"
      end
    end
  end

  def equip_item(index, player)
    item = @items[index]
    unless item && item.stat
      puts "Can't equip that item."
      return
    end

    existing = @items.find { |i| i.equipped && i.stat == item.stat }
    if existing && existing != item
      unequip_item(@items.index(existing), player)
    end

    if item.equipped
      puts "#{item.name} is already equipped."
      return
    end

    item.equipped = true
    case item.stat
    when "atk"
      player.atk += item.value
    when "hp"
      player.hp += item.value
    end
    puts "You equipped #{item.name}."
  end

  def unequip_item(index, player)
    item = @items[index]
    unless item && item.equipped
      puts "That item is not equipped."
      return
    end

    item.equipped = false
    case item.stat
    when "atk"
      player.atk -= item.value
    when "hp"
      player.hp -= item.value
    end
    puts "You unequipped #{item.name}."
  end

  def size
    @items.size
  end

  def full?
    @items.size >= @max_slots
  end
end
