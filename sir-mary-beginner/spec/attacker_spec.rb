require 'spec_helper'
require_relative '../attacker'
require_relative '../player'

describe Attacker do
  before do
    @player = Player.new
    @attacker = Attacker.new(@player)
  end

  describe '#relevant?' do
    it 'is true if player has a clear shot at an enemy' do
      @player.stub(:captive_at?).with(0) { false }
      @player.stub(:enemy_at?).with(0) { false }

      @player.stub(:captive_at?).with(1) { false }
      @player.stub(:enemy_at?).with(1) { false }

      @player.stub(:captive_at?).with(2) { false }
      @player.stub(:enemy_at?).with(2) { true }

      expect(@attacker.relevant?).to be_true
    end

    it 'is false if player does not have a clear shot at an enemy' do
      @player.stub(:captive_at?).with(0) { false }
      @player.stub(:enemy_at?).with(0) { false }

      @player.stub(:captive_at?).with(1) { true }
      @player.stub(:enemy_at?).with(1) { false }

      expect(@attacker.relevant?).to be_false
    end

    it 'is false if no enemy is in range' do
      (0..2).each do |i|
        @player.stub(:captive_at?).with(i) { false }
        @player.stub(:enemy_at?).with(i) { false }
      end

      expect(@attacker.relevant?).to be_false
    end
  end

  describe '#perform_action' do
    it 'tells the player to shoot' do
      expect(@player).to receive(:shoot!)

      @attacker.perform_action
    end
  end
end
