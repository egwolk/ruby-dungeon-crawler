module BattleInventory
  def show_inventory
    puts "\nYou check your bag..."
    @player.inventory.list

    return if @player.inventory.items.empty?

    puts "\nSelect item number or '0' to go back:"
    choice = gets.chomp.to_i

    if choice == 0
      return
    elsif choice > 0 && choice <= @player.inventory.items.size
      item = @player.inventory.items[choice - 1]
      show_item_menu(item, choice - 1)
    else
      puts "Invalid selection."
    end
  end

  def show_item_menu(item, index)
    equippable = [:weapon, :shield, :ring, :hat]
    
    if equippable.include?(item.type)
      handle_equippable_menu(item, index)
    elsif item.type == :potion
      handle_potion_menu(item, index)
    else
      handle_generic_menu(item, index)
    end
  end

  def handle_equippable_menu(item, index)
    puts "\nWhat would you like to do?"
    equipped_status = item.equipped ? "unequip" : "equip"
    puts "1. #{equipped_status.capitalize}"
    puts "2. Discard"
    puts "3. Go back"
    
    choice = gets.chomp
    
    case choice
    when "1"
      if item.equipped
        @player.inventory.unequip_item(index, @player)
      else
        @player.inventory.equip_item(index, @player)
      end
    when "2"
      discard_item_at(index)
    when "3"
      return
    else
      puts "Invalid selection."
    end
  end

  def handle_potion_menu(item, index)
    puts "\nWhat would you like to do?"
    puts "1. Drink"
    puts "2. Discard"
    puts "3. Go back"
    
    choice = gets.chomp
    
    case choice
    when "1"
      use_item(item, index)
    when "2"
      discard_item_at(index)
    when "3"
      return
    else
      puts "Invalid selection."
    end
  end

  def handle_generic_menu(item, index)
    puts "\nWhat would you like to do?"
    puts "1. Discard"
    puts "2. Go back"
    
    choice = gets.chomp
    
    case choice
    when "1"
      discard_item_at(index)
    when "2"
      return
    else
      puts "Invalid selection."
    end
  end

  def discard_item_at(index)
    item = @player.inventory.items[index]
    puts "Are you sure you want to discard #{item.name}? (Y/N)"
    confirm = gets.chomp.downcase
    
    if confirm == "y"
      if item.equipped
        @player.inventory.unequip_item(index, @player)
      end
      @player.inventory.remove_item(index)
      puts "You discarded the #{item.name}."
    else
      puts "You decided to keep it."
    end
  end
end
