class Pivoter
  extend Forwardable

  delegate [:visible_spaces,
            :direction,
            :opposite_direction] => :player

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def relevant?
    running_into_wall? || shot_from_behind?
  end

  def perform_action
    player.pivot!
  end

  private

  def running_into_wall?
    player.next_to_wall? && direction == :forward
  end

  def shot_from_behind?
    player.taking_damage? && closest_shooter_behind?
  end

  def closest_shooter_behind?
    visible_spaces.each do |space|
      if shooter_at?(space, direction)
        return false
      elsif shooter_at?(space, opposite_direction)
        return true
      end
    end

    false
  end

  def shooter_at?(space, direction)
    ['a', 'w'].include?(player.look(direction)[space].character)
  end
end
