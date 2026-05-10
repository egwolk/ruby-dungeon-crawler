require_relative 'player'

puts "Welcome to the Dungeon!"
print "Enter your name: "
name = gets.chomp

player = Player.new(name)
puts "Hello. #{player.name}! You have #{player.hp} HP."
puts "You enter the dungeon..."