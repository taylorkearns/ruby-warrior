require 'forwardable'
['feeler', 'walker', 'attacker', 'retreater'].each do |klass|
  require_relative klass
end

class Player
  extend Forwardable

  delegate [:attack!, :walk!, :feel] => :warrior

  attr_accessor :warrior, :health

  PRIORITIES = [::Retreater, ::Attacker, ::Walker]
  MAX_HEALTH = 20

  def initialize
    @warrior = {}
    @health = health
  end

  def play_turn(warrior)
    @warrior = warrior

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action

    health = warrior.health
  end

  def low_health?
    health <= low_health_threshold
  end

  def next_to_enemy?
    Feeler.new(self).next_to_enemy?
  end

  def space_available?
    Feeler.new(self).space_available?
  end

  def low_health_threshold
    #return last_hit * 2 if last_hit
    6
  end

  def health
    @_health ||= MAX_HEALTH
  end
end
