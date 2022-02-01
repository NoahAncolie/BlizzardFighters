require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

class Game
    attr_accessor :humanPlayer, :ennemies, :ennemies_left

    def initialize(player_name, nb_ennemies)
        @humanPlayer = HumanPlayer.new(player_name)
        @ennemies_left = nb_ennemies.to_i - 5
        @ennemies = Array.new
        if nb_ennemies.to_i <= 5
            nb_ennemies.to_i.times do |i|
                @ennemies << Player.new("ennemy#{i}")
            end
        else
            5.times do |i|
                @ennemies << Player.new("ennemy#{i}")
            end
        end
    end

    def new_ennemies_in_sight
        rand(0..2).times do |i|
            @ennemies << Player.new("ennemy#{@ennemies_left}")
            @ennemies_left -= 1
        end
    end

    def kill_ennemies
        @ennemies.each { |ennemi| ennemi.health <= 0? @ennemies.delete(ennemi) : nil}
    end

    def is_still_going
        if @humanPlayer.health > 0 && @ennemies_left > 0 && @ennemies.length > 0
            return true
        end
        return false
    end

    def show_players
        @humanPlayer.show_state
        print "\n\n"
        @ennemies.each do |ennemi|
            ennemi.show_state
        end
    end

    def menu
        puts "\nThey are #{@ennemies_left} enemies behind their lines\n\n"
        puts "\n\n=== What will you do ? ===\n\n"
        puts "    W => Find better weapon"
        puts "    H => try to Heal"
        @ennemies.length.times do |i|
            puts "attack #{@ennemies[i].name}, enter #{i}"
        end
    end

    def menu_choice
        print "choose\n>"
        choice = gets.chomp
        if choice == "W"
          @humanPlayer.search_weapon
        elsif choice == "H"
          @humanPlayer.search_health_pack
        elsif choice != "W" && choice != "H" && choice.to_i > @ennemies.length - 1
            puts "choose again"
            self.menu_choice
        else
          @humanPlayer.attack(@ennemies[choice.to_i])
          kill_ennemies
        end
    end

    def ennemies_attack
        @ennemies.each do |ennemi|
            ennemi.attack(@humanPlayer)
        end
    end

    def end
        if @humanPlayer.health > 0
            puts "\nYou finally cleared the misty mountain of all danger\nit's king ows you much. Good for you.\n\n         END."
        else
            puts "\n\nYou lost. Buy my stickers ==> noahancolie.fr <=="
        end
    end
end

puts"    ====================================="
puts"    ===                               ==="
puts"    ==        BLIZZARD FIGHTERS        =="
puts"    ===                               ==="
puts"    =====================================\n\n"

print"Name > "
name = gets.chomp
print"How many Ennemies ? >"
nb_ennemies = gets.chomp

game = Game.new(name, nb_ennemies)

while (game.is_still_going)
    game.new_ennemies_in_sight
    game.show_players
    game.menu
    game.menu_choice
    game.ennemies_attack
end

game.end