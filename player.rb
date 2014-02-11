class Player
  def play_turn(warrior)

    @surrounding_spaces = [:forward, :backward, :right, :left]
    @warrior = warrior
    @health = warrior.health
    @nearby_enemies = detect_enemies
    @nearby_captives = detect_captives

    if enemy_close?
      if multiple_enemies?
          warrior.bind! closest_enemy
      else
          warrior.attack! closest_enemy
      end
    elsif injured?
      warrior.rest!
    elsif captive_close?
      warrior.rescue! closest_captive
    elsif more_encounters?
      warrior.walk! direction_of_encounter
    else
      warrior.walk! warrior.direction_of_stairs
    end
  end

  def injured?
    @health < 20
  end

  def enemy_close?
    @nearby_enemies.count > 0
  end

  def multiple_enemies?
    @nearby_enemies.count > 1
  end
  
  def captive_close?
    @nearby_captives.count > 0
  end

  def detect_enemies
    @surrounding_spaces.find_all {|direction| @warrior.feel(direction).enemy? }
  end

  def detect_captives
    @surrounding_spaces.find_all {|direction| @warrior.feel(direction).captive? }
  end

  def closest_enemy
    @nearby_enemies.first
  end

  def closest_captive
    @nearby_captives.first
  end

  def more_encounters?
    @warrior.listen.count > 0
  end

  def direction_of_encounter
    @warrior.direction_of(@warrior.listen.first)
  end

end