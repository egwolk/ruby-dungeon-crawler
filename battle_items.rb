module BattleItems
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
end
