class DirectionSwitcher
  attr_reader :player, :direction

  def initialize(player)
    @player = player
    @direction = player.direction
  end

  def relevant?
    player.next_to_wall?
  end

  def perform_action
    player.switch_direction(new_direction)
  end

  private

  def new_direction
    directions.delete_if { |d| d == direction }.first
  end

  def directions
    [:forward, :backward]
  end
end
