class DirectionSwitcher
  attr_reader :player, :direction

  def initialize(player)
    @player = player
    @direction = player.direction
  end

  def relevant?
    player.next_to_wall? || unexplored_spaces?
  end

  def perform_action
    player.direction = new_direction

    player.traveled_all_directions = true
  end

  private

  def unexplored_spaces?
    at_stairs? && !player.traveled_all_directions
  end

  def at_stairs?
    player.space.stairs?
  end

  def new_direction
    directions.delete_if { |d| d == direction }.first
  end

  def directions
    [:forward, :backward]
  end
end
