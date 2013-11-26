class Rotator
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.feel.wall?
  end

  def perform_action
    player.pivot!
  end
end
