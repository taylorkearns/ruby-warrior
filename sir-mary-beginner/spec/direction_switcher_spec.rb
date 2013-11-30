require 'spec_helper'
require_relative '../direction_switcher'
require_relative '../player'

describe DirectionSwitcher do
  before do
    @player = Player.new
    @direction_switcher = DirectionSwitcher.new(@player)
  end

  describe '#relevant?' do
    it 'returns true if player is up against a wall' do
      @player.stub(:next_to_wall?) { true }

      expect(@direction_switcher.relevant?).to be_true
    end

    it 'returns false if player is not up against a wall' do
      @player.stub(:next_to_wall?) { false }

      expect(@direction_switcher.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'tells the player to go forward if going backward' do
      @direction_switcher.stub(:direction) { :backward }

      expect(@player).to receive(:switch_direction).with(:forward)

      @direction_switcher.perform_action
    end

    it 'tells the player to go backward if going forward' do
      @direction_switcher.stub(:direction) { :forward }

      expect(@player).to receive(:switch_direction).with(:backward)

      @direction_switcher.perform_action
    end
  end
end
