require 'debugger'

class Player
  attr_accessor :warrior

  WARRIOR_MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @previous_health = WARRIOR_MAX_HEALTH
    @direction = :backward
  end

  def play_turn(warrior)
    @warrior = warrior

    if taking_damage? || hits_left <= 2
      defend
    elsif need_rest?
      rest
    else
      explore
    end

    @previous_health = warrior.health
  end

  def explore
    @direction = :forward if warrior.feel(:backward).wall?

    engage(@direction)
  end

  def engage(dir)
    if warrior.feel(dir).enemy?
      warrior.attack!(dir)
    elsif warrior.feel(dir).captive?
      warrior.rescue!(dir)
    else
      warrior.walk!(dir)
    end
  end

  def defend
    if taking_damage? && hits_left <= 2
      retreat
    elsif hits_left <= 2
      rest
    else
      engage(@direction)
    end
  end

  def hits_left
    if last_hit == 0
      warrior.health / 3 # This is just an estimate
    else
      warrior.health / last_hit
    end
  end

  def last_hit
    @previous_health - warrior.health
  end

  def retreat
    warrior.walk!(:backward) if warrior.feel(:backward).empty?
  end

  def rest
    warrior.rest!
  end

  def need_rest?
    warrior.health < WARRIOR_MAX_HEALTH
  end

  def taking_damage?
    warrior.health < @previous_health
  end
end
