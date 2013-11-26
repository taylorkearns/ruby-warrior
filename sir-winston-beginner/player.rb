require 'debugger'

class Player
  extend Forwardable

  attr_accessor :warrior

  delegate [:pivot!, :feel, :health] => :warrior

  PRIORITIES = [Rotator, Defender, Rester, Explorer]

  WARRIOR_MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @previous_health = WARRIOR_MAX_HEALTH
    @direction = :forward
  end

  def previous_health
    @previous_health
  end

  def play_turn(warrior)
    @warrior = warrior

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action

    elsif taking_damage? || hits_left <= 2
      defend
    elsif need_rest? && !level_completed?
      rest
    else
      explore
    end

    @previous_health = warrior.health
  end

  def explore
    if warrior_moving_backward?
      warrior.pivot!
      @direction = :forward
    elsif warrior.feel.wall?
      warrior.pivot! 
    else
      engage(@direction)
    end
  end

  def engage(dir)
    if warrior.feel(dir).enemy?
      warrior.attack!(dir)
    elsif warrior.feel(dir).captive?
      warrior.rescue!(dir)
    elsif warrior.feel(dir).wall?
      warrior.pivot!
    elsif clear_shot_at_enemy?
      warrior.shoot!
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

  def warrior_moving_backward?
    @direction == :backward && warrior.feel(:backward).empty?
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

  def clear_shot_at_enemy?
    see_in_distance?('enemy', 1) ||
      (see_in_distance?('enemy', 2) && !see_in_distance?('captive', 1))
  end

  def see_in_distance?(occupant, space)
    @warrior.look[space].send("#{occupant}?")
  end

  def need_rest?
    warrior.health < WARRIOR_MAX_HEALTH
  end

  def taking_damage?
    warrior.health < @previous_health
  end

  def level_completed?
    warrior.feel.stairs?
  end
end
