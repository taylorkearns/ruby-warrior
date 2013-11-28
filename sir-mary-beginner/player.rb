require 'forwardable'
['feeler', 'walker', 'attacker', 'retreater'].each do |klass|
  require_relative klass
end

class Player
  extend Forwardable

  delegate [:attack!, :walk!, :feel] => :warrior

  attr_accessor :warrior

  PRIORITIES = [::Retreater, ::Attacker, ::Walker]
  MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @previous_health = MAX_HEALTH
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
    Feeler.new(self).next_to_enemy?
  end

  def space_available?
    Feeler.new(self).space_available?
  end

  def taking_damage?
    warrior.health < @previous_health
  end

  def low_health_threshold
    return last_hit * 2 if taking_damage?
    6
  end

  def last_hit
    @previous_health - warrior.health
  end
end
