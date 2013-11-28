require 'spec_helper'
require_relative '../player'
require_relative '../retreater'

describe Retreater do
  before do
    @player = Player.new
    @retreater = Retreater.new(@player)
  end

  describe '#relevant?' do
    it 'checks for low health' do
      expect(@player).to receive(:low_health?)

      @retreater.relevant?
    end
  end

  describe '#perform_action' do
    it 'tells the player to retreat' do
      expect(@player).to receive(:walk!).with(:backward)

      @retreater.perform_action
    end
  end
end