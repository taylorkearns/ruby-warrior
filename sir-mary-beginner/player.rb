# prioritize enemies
# change @previous_health to a method
# add tests to Player methods where appropriate
# see where Player methods are being used, if only on other classes move them to that class
# look for places to make methods private

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

  delegate [:walk!, :rest!, :pivot!, :look] => :warrior

  attr_accessor :warrior, :direction, :directions_traveled

  PRIORITIES ||= [::Pivoter,
                  ::Retreater,
                  ::Rester,
                  ::Attacker,
                  ::Rescuer,
                  ::DirectionSwitcher,
                  ::Walker]

  DIRECTIONS ||= [:forward, :backward]

  MAX_HEALTH ||= 20

  def initialize
    @warrior = {}
    @previous_health = MAX_HEALTH
    @direction = :forward
    @directions_traveled = [@direction]
  end

  def play_turn(warrior)
    @warrior = warrior

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action

    @previous_health = warrior.health
  end

  def shoot!
    warrior.shoot!(direction)
  end

  def attack!
    warrior.attack!(direction)
  end

  def rescue!
    warrior.rescue!(direction)
  end

  def switch_direction(new_direction)
    self.direction = new_direction

    directions_traveled << new_direction
  end

  def low_health_threshold
    return (last_hit * 2.5).to_i if taking_damage?

    MAX_HEALTH - 1
  end

  def last_hit
    @previous_health - warrior.health
  end

  def space
    warrior.feel(direction)
  end

  def visible_spaces
    (0..2)
  end

  def opposite_direction
    if direction == :forward
      :backward
    else
      :forward
    end
  end

  def shot_from_behind?
    taking_damage? && closest_shooter_behind?
  end

  def closest_shooter_behind?
    visible_spaces.each do |space|
      if shooter_at?(space)
        return false
      elsif shooter_behind_at?(space)
        return true
      end
    end

    false
  end

  def unvisited_spaces?
    directions_traveled.uniq.count < DIRECTIONS.count
  end

  def at_stairs?
    space.stairs?
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
    look(direction)[space].empty?
  end

  def captive_at?(space)
    look(direction)[space] &&
      look(direction)[space].captive?
  end

  def enemy_at?(space)
    look(direction)[space].enemy?
  end

  def shooter_at?(space)
    look(direction)[space].character == 'a' ||
      look(direction)[space].character == 'w'
  end

  def shooter_behind_at?(space)
    look(opposite_direction)[space].character == 'a' ||
      look(opposite_direction)[space].character == 'w'
  end
end
