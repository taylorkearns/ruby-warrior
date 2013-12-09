require 'spec_helper'
require_relative '../player'
require_relative '../walker'

describe Walker do
  before do
    @player = Player.new
    @walker = Walker.new(@player)
  end

  describe '#relevant?' do
    it 'is true if the space is empty' do
      space = @player.stub(:space) { '' }
      space.stub(:empty?) { true }

      expect(@walker.relevant?).to be_true
    end
  end

  describe '#perform_action' do
    it 'directs the player to walk' do
      @walker.stub(:direction) { :forward }

      expect(@player).to receive(:walk!).with(:forward)

      @walker.perform_action
    end
  end
end
