class Walker
  attr_reader :player, :direction

  def initialize(player)
    @player = player
    @direction = player.direction
  end

  def relevant?
    player.space_available?
  end

  def perform_action
    player.walk!(direction)
  end
end
