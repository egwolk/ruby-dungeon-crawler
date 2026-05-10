require_relative 'player'
require_relative 'enemy'


puts "Welcome to the Dungeon!"
print "Enter your name: "
name = gets.chomp

player = Player.new(name)
puts "Hello. #{player.name}! You have #{player.hp} HP."
puts "You enter the dungeon..."

enemy = Enemy.random
puts "A #{enemy.name} appears! (HP: #{enemy.hp})"