require 'forwardable'

class Rescuer
  extend Forwardable

  delegate [:warrior, :direction] => :player

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.space.captive?
  end

  def perform_action
    warrior.rescue!(direction)
  end
end
