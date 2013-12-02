require 'debugger'
require 'forwardable'

['walker',
 'attacker',
 'rescuer',
 'retreater',
 'rester',
 'direction_switcher',
 'pivoter'].each do |klass|
  require_relative klass
end

class Player
  extend Forwardable

  delegate [:walk!, :rest!, :pivot!, :shoot!, :look] => :warrior

  attr_accessor :warrior, :direction

  PRIORITIES = [::Retreater,
                ::Rester,
                ::Attacker,
                ::Rescuer,
                ::DirectionSwitcher,
                ::Pivoter,
                ::Walker]

  MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @previous_health = MAX_HEALTH
    @direction = :backward
  end

  def play_turn(warrior)
    @warrior = warrior

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action

    @previous_health = warrior.health
  end

  def attack!
    warrior.attack!(direction)
  end

  def rescue!
    warrior.rescue!(direction)
  end

  def switch_direction(new_direction)
    self.direction = new_direction
  end

  def low_health_threshold
    return last_hit * 3 if taking_damage?

    MAX_HEALTH - 1
  end

  def last_hit
    @previous_health - warrior.health
  end

  def space
    warrior.feel(direction)
  end

  def facing_wall?
    next_to_wall? && direction == :forward
  end

  def next_to_wall?
    space.wall?
  end

  def next_to_captive?
    space.captive?
  end

  def next_to_enemy?
    space.enemy?
  end

  def space_available?
    space.empty?
  end

  def taking_damage?
    warrior.health < @previous_health
  end

  def low_health?
    warrior.health <= low_health_threshold
  end

  def empty_at?(space)
    look[space].empty?
  end

  def captive_at?(space)
    look[space] && look[space].captive?
  end

  def enemy_at?(space)
    look[space].enemy?
  end

  def visible_spaces
    (0..2)
  end
end
