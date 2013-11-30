require 'spec_helper'
require_relative '../player'
require_relative '../retreater'

describe Retreater do
  before do
    @player = Player.new
    @retreater = Retreater.new(@player)
  end

  describe '#relevant?' do
    it 'returns true when health is low and player is taking damage' do
      @player.stub(:low_health?) { true }
      @player.stub(:taking_damage?) { true }

      expect(@retreater.relevant?).to be_true
    end

    it 'returns false when health is low but player is not taking damage' do
      @player.stub(:low_health?) { true }
      @player.stub(:taking_damage?) { false }

      expect(@retreater.relevant?).to be_false
    end

    it 'returns false when health is not low but player is taking damage' do
      @player.stub(:low_health?) { false }
      @player.stub(:taking_damage?) { true }

      expect(@retreater.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'tells the player to retreat' do
      expect(@player).to receive(:walk!).with(:backward)

      @retreater.perform_action
    end
  end
end
