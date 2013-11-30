require 'spec_helper'
require_relative '../player'
require_relative '../rescuer'

describe Rescuer do
  before do
    @player = Player.new
    @rescuer = Rescuer.new(@player)
  end

  describe '#relevant?' do
    it 'returns true when player is next to a captive' do
      @player.stub(:next_to_captive?) { true }

      expect(@rescuer.relevant?).to be_true
    end

    it 'returns false when player is next to a captive' do
      @player.stub(:next_to_captive?) { false }

      expect(@rescuer.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'tells the player to rescue the captive' do
      expect(@player).to receive(:rescue!)

      @rescuer.perform_action
    end
  end
end
