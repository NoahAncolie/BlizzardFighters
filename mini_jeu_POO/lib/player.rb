class Player
  attr_accessor :health, :name

  def initialize(name)
    @name = name
    @health = 10
  end

  def show_state
    puts "#{@name} have #{@health} hp"
  end

  def gets_damage(nb)
    @health -= nb
    if @health < 1
      puts "#{@name} Was killed the Savage Way!"
    end
  end

  def attack(player)
    puts "#{@name} attack #{player.name}"
    damage = compute_damage
    player.gets_damage(damage)
    puts "\nHe inflict him #{damage} damage points"
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @health = 100
    @weapon_level = 1
  end

  def show_state
    puts"#{@name} have #{@health} hp and a weapon level #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    dice = rand(1..6)
    puts"=== You found a new weapon, level #{dice} ==="
    if dice > @weapon_level
      puts"It is better than your actual Weapon : Keep"
      @weapon_level = dice
    else
      puts"It is worse than your actual Weapon : Leave"
    end
  end
  
  def search_health_pack
    dice = rand(1..6)
    if dice == 1
      puts"Nothing has been found"
    elsif dice >= 2 && dice <=5
      puts"You found 50hp"
      @health += 50
    else
      puts"You found 80hp"
      @health += 80
    end
  end
end
