require_relative 'player'
require_relative 'enemy'
require_relative 'battle'

puts "Welcome to the Dungeon!"
print "Press [ENTER] to start your adventure"
gets
system("clear") || system("cls")

print "Enter your name: "
name = gets.chomp
system("clear") || system("cls")

player = Player.new(name)
puts "Hello, #{player.name}!"
print "You enter the dungeon...Press [ENTER] to continue"
gets
system("clear") || system("cls")
room = 1

loop do
  puts "\n--- Room #{room} ---"

  enemy = Enemy.random
  Battle.new(player, enemy, room).start

  break if player.hp <= 0

  room += 1
  print "\nYou move deeper into the dungeon...[ENTER]continue"
  gets
  system("clear") || system("cls")
end

puts "\nGame over! You made it through #{room - 1} room(s). Thanks for playing!"