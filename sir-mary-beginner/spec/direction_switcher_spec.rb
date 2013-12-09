require 'spec_helper'
require_relative '../direction_switcher'
require_relative '../player'

describe DirectionSwitcher do
  before do
    @player = Player.new
    @direction_switcher = DirectionSwitcher.new(@player)
  end

  describe '#relevant?' do
    it 'is true if player is up against a wall' do
      @player.stub(:next_to_wall?) { true }
      @direction_switcher.stub(:unexplored_spaces?) { false }

      expect(@direction_switcher.relevant?).to be_true
    end

    it 'is true if there are more spaces to explore' do
      @player.stub(:next_to_wall?) { false }
      @direction_switcher.stub(:unexplored_spaces?) { true }

      expect(@direction_switcher.relevant?).to be_true
    end

    it 'is false if player is not up against a wall
        and there are no more spaces to explore' do
      @player.stub(:next_to_wall?) { false }
      @direction_switcher.stub(:unexplored_spaces?) { false }

      expect(@direction_switcher.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'tells the player to go forward if going backward' do
      @direction_switcher.stub(:direction) { :backward }

      @direction_switcher.perform_action

      expect(@player.direction).to eq :forward
    end

    it 'tells the player to go backward if going forward' do
      @direction_switcher.stub(:direction) { :forward }

      @direction_switcher.perform_action

      expect(@player.direction).to eq :backward
    end
  end
end
