class Walker
  extend Forwardable

  delegate [:direction, :space] => :player

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    space.empty?
  end

  def perform_action
    player.walk!(direction)
  end
end
