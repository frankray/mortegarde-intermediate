class Player

  attr_reader :surrounding_spaces, :nearby_enemies, :nearby_captives, :warrior
  
  def play_turn(warrior)

    @surrounding_spaces = [:forward, :backward, :right, :left]
    @warrior = warrior
    @nearby_enemies = surrounding_spaces.find_all {|direction| warrior.feel(direction).enemy?}
    @nearby_captives = surrounding_spaces.find_all {|direction| warrior.feel(direction).captive?}

    if nearby_enemies.count > 0
      if nearby_enemies.count > 1
          warrior.bind! closest_enemy
      else
          warrior.attack! nearby_enemies.first
      end
    elsif warrior.health < 20
      warrior.rest!
    elsif nearby_captives.count > 0
      warrior.rescue! nearby_captives.first
    elsif warrior.listen.count > 0
      warrior.walk! warrior.direction_of(warrior.listen.first)
    else
      warrior.walk! warrior.direction_of_stairs
    end
  end

end
