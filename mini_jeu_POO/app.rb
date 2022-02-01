require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

player1 = Player.new("Dieu")
player2 = Player.new("Lucifer")

while (player1.health > 0 && player2.health > 0)
    puts "Voici l'état de nos joueurs :"
    player1.show_state
    player2.show_state

    puts "\npassons à la phase d'attaque"
    player1.attack(player2)
    player2.attack(player1)
end

binding.pry