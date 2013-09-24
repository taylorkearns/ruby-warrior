require 'debugger'

class Player
  attr_accessor :warrior

  WARRIOR_MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @previous_health = WARRIOR_MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior

    if taking_damage? || hits_left <= 2
      defend
    elsif need_rest?
      rest
    else
      engage
    end

    @previous_health = warrior.health
  end

  def engage
    if warrior.feel.empty?
      warrior.walk!
    elsif warrior.feel.captive?
      warrior.rescue!
    elsif warrior.feel.enemy?
      warrior.attack!
    end
  end

  def defend
    if taking_damage? && hits_left <= 2
      retreat
    elsif hits_left <= 2
      rest
    else
      engage
    end
  end

  def need_rest?
    warrior.health < WARRIOR_MAX_HEALTH
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
    warrior.walk!(:backward)
  end

  def rest
    warrior.rest!
  end

  def taking_damage?
    warrior.health < @previous_health
  end
end
