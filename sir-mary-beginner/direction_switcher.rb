class DirectionSwitcher
  extend Forwardable

  delegate [:next_to_wall?, :at_stairs?, :unvisited_spaces?] => :player

  attr_reader :player, :direction

  def initialize(player)
    @player = player
    @direction = player.direction
  end

  def relevant?
    next_to_wall? || more_achievements_available?
  end

  def perform_action
    player.switch_direction(new_direction)
  end

  private

  def more_achievements_available?
    at_stairs? && unvisited_spaces?
  end

  def new_direction
    directions.delete_if { |d| d == direction }.first
  end

  def directions
    [:forward, :backward]
  end
end
