class Feeler
  attr_reader :direction, :player

  def initialize(player, direction = :forward)
    @player = player
    @direction = direction
  end

  def next_to_enemy?
    space.enemy?
  end

  def space_available?
    space.empty?
  end

  def space
    player.feel(direction)
  end
end
