class Defender
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    taking_damage? || hits_left <= 2
  end

  def perform_action
    defend
  end

  def taking_damage?
    player.health < player.previous_health
  end
end
