require 'forwardable'

class Attacker
  extend Forwardable

  delegate [:direction, :visible_spaces, :warrior, :direction] => :player

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    clear_shot_at_enemy?
  end

  def perform_action
    warrior.shoot!(direction)
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

  def captive_at?(space)
    selected_space(space).captive?
  end

  def enemy_at?(space)
    selected_space(space).enemy?
  end

  def selected_space(space)
    player.look(direction)[space]
  end
end
