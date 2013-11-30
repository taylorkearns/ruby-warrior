require 'spec_helper'
require_relative '../rester'
require_relative '../player'

describe Rester do
  before do
    @player = Player.new
    @rester = Rester.new(@player)
  end

  describe '#relevant?' do
    it 'returns true if player has low health and is not taking damage' do
      @player.stub(:low_health?) { true }
      @player.stub(:taking_damage?) { false }

      expect(@rester.relevant?).to be_true
    end

    it 'returns false if player does not have low health' do
      @player.stub(:low_health?) { false }
      @player.stub(:taking_damage?) { false }

      expect(@rester.relevant?).to be_false
    end

    it 'returns false if player is taking damage' do
      @player.stub(:low_health?) { true }
      @player.stub(:taking_damage?) { true }

      expect(@rester.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'tells player to rest' do
      expect(@player).to receive(:rest!)

      @rester.perform_action
    end
  end
end
