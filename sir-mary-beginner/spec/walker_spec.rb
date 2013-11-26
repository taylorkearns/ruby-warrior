require 'spec_helper'
require_relative '../player'
require_relative '../walker'

describe Walker do
  before do
    @player = Player.new
    @walker = Walker.new(@player)
  end

  describe '#relevant?' do
    it 'checks for space in front of the player' do
      expect(@player).to receive(:space_available?)

      @walker.relevant?
    end
  end

  describe '#perform_action' do
    it 'makes the player walk' do
      expect(@player).to receive(:walk!)

      @walker.perform_action
    end
  end
end
