require 'spec_helper'
require_relative '../player'

describe Player do
  before do
    @player = Player.new
  end

  describe '#low_health?' do
    before do

    end

    it 'returns true when health is at or below the danger threshold' do
      @player.stub(:health) { 6 }

      expect(@player.low_health?).to be_true
    end

    it 'returns false when health is above the danger threshold' do
      @player.stub(:health) { 12 }

      expect(@player.low_health?).to be_false
    end
  end
end
