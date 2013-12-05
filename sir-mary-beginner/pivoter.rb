class Pivoter
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.facing_wall? || player.shot_from_behind?
  end

  def perform_action
    player.pivot!
  end
end
