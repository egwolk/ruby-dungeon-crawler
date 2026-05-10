require_relative 'player'
require_relative 'enemy'
require_relative 'battle'


puts "Welcome to the Dungeon!"
print "Enter your name: "
name = gets.chomp

player = Player.new(name)
puts "Hello. #{player.name}! You have #{player.hp} HP."
puts "You enter the dungeon..."

enemy = Enemy.random
Battle.new(player, enemy).start