require 'spec_helper'
require_relative '../player'
require_relative '../pivoter'

describe Pivoter do
  before do
    @player = Player.new
    @pivoter = Pivoter.new(@player)
  end

  describe '#relevant?' do
    it 'returns true if a shooter is behind the player' do
      @player.stub(:facing_wall?) { false }
      @player.stub(:shot_from_behind?) { true }

      expect(@pivoter.relevant?).to be_true
    end

    context 'if a shooter is not behind the player' do
      before do
        @player.stub(:shot_from_behind?) { false }
      end

      it 'returns false if player is not next to a wall' do
        @player.stub(:next_to_wall?) { false }

        expect(@pivoter.relevant?).to be_false
      end

      it 'returns false if player is backed into a wall' do
        @player.stub(:next_to_wall?) { true }
        @player.stub(:direction) { :backward }

        expect(@pivoter.relevant?).to be_false
      end

      it 'returns true if player is facing a wall' do
        @player.stub(:next_to_wall?) { true }
        @player.stub(:direction) { :forward }

        expect(@pivoter.relevant?).to be_true
      end
    end
  end

  describe '#perform_action' do
    it 'tells the player to pivot' do
      expect(@player).to receive(:pivot!)

      @pivoter.perform_action
    end
  end
end

