require 'forwardable'

class Attacker
  extend Forwardable

  delegate [:visible_spaces, :captive_at?, :enemy_at?] => :player

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    clear_shot_at_enemy?
  end

  def perform_action
    player.shoot!
  end

  private

  def clear_shot_at_enemy?
    visible_spaces.each do |space|
      if enemy_at?(space)
        return true
      elsif captive_at?(space)
        return false
      end
    end

    false
  end
end
