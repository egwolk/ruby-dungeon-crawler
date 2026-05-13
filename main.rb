require_relative 'player'
require_relative 'enemy'
require_relative 'battle'
require 'io/console'

# === UTILITY ===
def wait_for_enter
  loop do
    key = STDIN.getch
    return if key == "\r" || key == "\n"
  end
end

# === GAME STARTUP ===
puts "Welcome to the Dungeon!"
print "Press [ENTER] to start your adventure"
wait_for_enter
system("clear") || system("cls")

print "Enter your name: "
name = gets.chomp
while name.strip.empty?
  print "Name cannot be blank. Enter your name: "
  name = gets.chomp
end
system("clear") || system("cls")

player = Player.new(name)
puts "Hello, #{player.name}!"
print "You enter the dungeon...Press [ENTER] to continue"
wait_for_enter
system("clear") || system("cls")

# === MAIN GAME LOOP ===
room = 1

loop do
  puts "\n--- Room #{room} ---"

  enemy = Enemy.random(room)
  Battle.new(player, enemy, room).start

  break if player.hp <= 0

  room += 1
  print "\nYou move deeper into the dungeon...[ENTER]continue"
  wait_for_enter
  system("clear") || system("cls")
end

puts "\nGame over! You made it through #{room - 1} room(s). Thanks for playing!"
puts "[ENTER]continue..."
wait_for_enter
system("clear") || system("cls")