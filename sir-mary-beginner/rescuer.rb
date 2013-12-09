class Rescuer
  extend Forwardable

  delegate [:direction, :space] => :player

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    space.captive?
  end

  def perform_action
    player.rescue!(direction)
  end
end
