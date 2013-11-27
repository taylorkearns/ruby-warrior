require 'forwardable'
require_relative 'feeler'
require_relative 'walker'

class Player
  extend Forwardable

  delegate [:walk!, :feel] => :warrior
  delegate [:attack!, :walk!, :feel] => :warrior

  attr_accessor :warrior

  PRIORITIES = [::Walker]

  def initialize
    @warrior = {}
  end

  def play_turn(warrior)
    @warrior = warrior

    priority = PRIORITIES.find { |p| p.new(self).relevant? }

    priority.new(self).perform_action
  end

  def space_available?
    Feeler.new(self).space_available?
  end
end
