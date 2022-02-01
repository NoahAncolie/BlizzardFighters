require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def make_decision(choice, player, ennemies)
  if choice == "W"
    player.search_weapon
  elsif choice == "H"
    player.search_health_pack
  else
    player.attack(ennemies[choice.to_i])
  end
end

puts"    ====================================="
puts"    ===                               ==="
puts"    ==        BLIZZARD FIGHTERS        =="
puts"    ===                               ==="
puts"    =====================================\n\n"

print"Name > "
#DÉFINITION DES VARIABLES
name = gets.chomp
player = HumanPlayer.new(name)
ennemy1 = Player.new("Loup des glaces")
ennemy2 = Player.new("Troll des montagnes")
ennemies = [ennemy1, ennemy2]
#LANCEMENT DU JEU
while (player.health > 0 && (ennemy1.health > 0 || ennemy2.health > 0))
  player.show_state
 # AFFICHER LES CHOIX
  #
  puts "\n\nWHAT U GON' DO ?\n\n"
  puts "W => Find better weapon"
  puts "H => try to Heal"
  puts "\nAttack ennemy"
  print "0 => " 
  ennemy1.show_state
  print "\n1 => "
  ennemy2.show_state
  print "\n\n"
  decision = gets.chomp
#EFFECTUER LES ACTIONS
  #
  make_decision(decision.to_s, player, ennemies)

#RIPOSTE
  #
  puts"\n\n=== L'ennemi passe à l'attaque ==="
  ennemies.each do |ennemy|
    if ennemy.health > 0
      ennemy.attack(player)
    end
  end
end

#FIN DU GAME
#
if player.health > 0
  puts "You finally cleared the misty mountain of all danger\nit's king ows you much. Good for you\n\n         END."
else
  puts "You lost. Buy my stickers ==> noahancolie.fr <=="
end
