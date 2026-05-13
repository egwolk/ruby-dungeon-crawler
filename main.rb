require_relative 'player'
require_relative 'enemy'
require_relative 'battle'

puts "Welcome to the Dungeon!"
print "Enter your name: "
name = gets.chomp

player = Player.new(name)
puts "Hello, #{player.name}!"
puts "You enter the dungeon..."

room = 1

loop do
  puts "\n--- Room #{room} ---"

  enemy = Enemy.random
  Battle.new(player, enemy, room).start

  break if player.hp <= 0

  room += 1
  puts "\nYou move deeper into the dungeon..."
end

puts "\nGame over! You made it through #{room - 1} room(s). Thanks for playing!"