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
        puts "#{index + 1}. #{item.name} (#{item.type})"
      end
    end
  end

  def size
    @items.size
  end

  def full?
    @items.size >= @max_slots
  end
end
