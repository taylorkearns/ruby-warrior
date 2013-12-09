require 'debugger'
require 'spec_helper'
require_relative '../player'

describe Player do
  before do
    @player = Player.new
  end

  describe '#low_health_threshold' do
    it 'is 2.5 times the last hit if player is taking damage' do
      @player.stub(:taking_damage?) { true }
      @player.stub(:last_hit) { 4 }

      expect(@player.low_health_threshold).to eq 10
    end

    it 'is 1 less than max health if player is not taking damage' do
      @player.stub(:taking_damage?) { false }
      @player.stub(:last_hit) { 0 }

      expect(@player.low_health_threshold).to eq 19
    end
  end
end
