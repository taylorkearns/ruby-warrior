require 'spec_helper'
require_relative '../player'
require_relative '../walker'

describe Walker do
  before do
    @player = Player.new
    @walker = Walker.new(@player)
  end

  describe '#relevant?' do
    it 'checks for space next to the player' do
      expect(@player).to receive(:space_available?)

      @walker.relevant?
    end
  end

  describe '#perform_action' do
    it 'tells the player to walk' do
      @walker.stub(:direction) { :forward }

      expect(@player).to receive(:walk!).with(:forward)

      @walker.perform_action
    end
  end
end
