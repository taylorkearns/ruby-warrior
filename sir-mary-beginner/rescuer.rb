class Rescuer
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    player.next_to_captive?
  end

  def perform_action
    player.rescue!
  end
end
