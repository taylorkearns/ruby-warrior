require 'debugger'
require 'spec_helper'
require_relative '../player'

describe Player do
  before do
    @player = Player.new
  end

  describe '#low_health?' do
    it 'returns true when health is at or below the danger threshold' do
      @player.stub(:starting_health) { 6 }
      @player.stub(:previous_health) { 6 }

      expect(@player.low_health?).to be_true
    end

    it 'returns true when health is at or below the danger threshold when taking damage' do
      @player.stub(:starting_health) { 7 }
      @player.stub(:previous_health) { 11 }

      expect(@player.low_health?).to be_true
    end

    it 'returns false when health is above the danger threshold' do
      @player.stub(:starting_health) { 8 }
      @player.stub(:previous_health) { 8 }

      expect(@player.low_health?).to be_false
    end

    it 'returns true when health is above the danger threshold when taking damage' do
      @player.stub(:starting_health) { 5 }
      @player.stub(:previous_health) { 7 }

      expect(@player.low_health?).to be_false
    end
  end
end
