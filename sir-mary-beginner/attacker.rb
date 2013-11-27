class Attacker
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.next_to_enemy?
  end

  def perform_action
    player.attack!
  end
end
