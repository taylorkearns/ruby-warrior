class Pivoter
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.facing_wall?
  end

  def perform_action
    player.pivot!
  end
end
