require 'debugger'
require 'forwardable'

['walker', 'attacker', 'rescuer', 'retreater', 'rester'].each do |klass|
  require_relative klass
end

class Player
  extend Forwardable

  delegate [:attack!, :walk!, :rest!, :rescue!, :feel] => :warrior

  attr_accessor :warrior, :direction

  PRIORITIES = [::Retreater, ::Rester, ::Attacker, ::Rescuer, ::Walker]
  MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @previous_health = MAX_HEALTH
    @direction = :forward
  end

  def play_turn(warrior)
    @warrior = warrior

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action

    @previous_health = warrior.health
  end

  def low_health?
    warrior.health <= low_health_threshold
  end

  def next_to_enemy?
    space.enemy?
  end

  def next_to_captive?
    space.captive?
  end

  def space_available?
    space.empty?
  end

  def taking_damage?
    warrior.health < @previous_health
  end

  def low_health_threshold
    return last_hit * 3 if taking_damage?

    MAX_HEALTH - 1
  end

  def last_hit
    @previous_health - warrior.health
  end

  def space
    feel(direction)
  end
end
