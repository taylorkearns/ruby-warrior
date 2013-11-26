class Walker
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.space_available?
  end

  def perform_action
    player.walk!
  end
end
