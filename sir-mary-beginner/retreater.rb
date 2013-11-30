class Retreater
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.low_health? && player.taking_damage?
  end

  def perform_action
    player.walk!(:backward)
  end
end
