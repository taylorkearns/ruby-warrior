class Retreater
  attr_reader :player, :direction

  def initialize(player)
    @player = player
    @direction = player.direction
  end

  def relevant?
    player.low_health? && player.taking_damage?
  end

  def perform_action
    player.walk!(retreat_direction)
  end

  private

  def retreat_direction
    if direction == :forward
      :backward
    else
      :forward
    end
  end
end
