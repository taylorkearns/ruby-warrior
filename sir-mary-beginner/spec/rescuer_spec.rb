require 'spec_helper'
require_relative '../player'
require_relative '../rescuer'

describe Rescuer do
  before do
    @player = Player.new
    @rescuer = Rescuer.new(@player)
  end

  describe '#relevant?' do
    it 'is true when player is next to a captive' do
      # Why does this stubbing work on Walker spec but not Rescuer spec?
      space = stub(captive?: true)
      @player.stub(space: space)

      expect(@rescuer.relevant?).to be_true
    end

    it 'is false when player is not next to a captive' do
      space = stub(captive?: false)
      @player.stub(space: space)

      expect(@rescuer.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'directs the player to rescue the captive' do
      expect(@player).to receive(:rescue!)

      @rescuer.perform_action
    end
  end
end
