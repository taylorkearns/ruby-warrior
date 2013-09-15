require 'debugger'

class Player
  attr_accessor :health

  WARRIOR_MAX_HEALTH = 20

  def initialize
    @starting_health = WARRIOR_MAX_HEALTH
    @ending_health = @starting_health
  end

  def play_turn(warrior)
    @starting_health = warrior.health
    if taking_damage?
      defense(warrior)
    elsif warrior.feel(:forward).empty?
      if warrior.health < WARRIOR_MAX_HEALTH
        warrior.rest!
      else
        warrior.walk!
      end
    else
      offense(warrior)
    end

    @ending_health = warrior.health
  end

  def defense(warrior)
    if warrior.feel(:forward).empty?
      warrior.walk!
    else
      warrior.attack!
    end
  end

  def offense(warrior)
    if warrior.feel(:forward).captive?
      warrior.rescue!
    else
      warrior.attack!
    end
  end

  def taking_damage?
    @starting_health < @ending_health
  end
end
