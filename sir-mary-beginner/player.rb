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

  delegate [:walk!, :rescue!, :rest!, :pivot!, :shoot!, :look] => :warrior

  attr_accessor :warrior, :previous_health, :direction, :traveled_all_directions

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
    @traveled_all_directions = false
  end

  def play_turn(warrior)
    @warrior = warrior

    self.traveled_all_directions = true if space.wall? || space_behind.wall?

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action

    self.previous_health = warrior.health
  end

  def space
    warrior.feel(direction)
  end

  def space_behind
    warrior.feel(opposite_direction)
  end

  def visible_spaces
    (0..2)
  end

  def next_to_wall?
    space.wall?
  end

  def taking_damage?
    warrior.health < previous_health
  end

  def low_health?
    warrior.health <= low_health_threshold
  end

  def low_health_threshold
    return (last_hit * 2.5).to_i if taking_damage?

    MAX_HEALTH - 1
  end

  def opposite_direction
    if direction == :forward
      :backward
    else
      :forward
    end
  end

  private

  def last_hit
    previous_health - warrior.health
  end
end
