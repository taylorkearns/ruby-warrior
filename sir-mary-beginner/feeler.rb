class Feeler
  attr_reader :direction, :player

  def initialize(player, direction = :forward)
    @player = player
    @direction = direction
  end

  def space_available?
    space.empty?
  end

  private

  def space
    player.feel(direction)
  end
end
