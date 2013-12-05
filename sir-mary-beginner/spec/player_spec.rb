require 'debugger'
require 'spec_helper'
require_relative '../player'

describe Player do
  before do
    @player = Player.new
  end

  describe '#shot_from_behind?' do
    it 'is true if taking damage and a shooter is visible in the other direction' do
      @player.stub(:taking_damage?) { true }
      @player.stub(:shooter_behind?) { true }

      expect(@player.shot_from_behind?).to be_true
    end

    it 'is false if not taking damage' do
      @player.stub(:taking_damage?) { false }
      @player.stub(:shooter_behind?) { true }

      expect(@player.shot_from_behind?).to be_false
    end

    it 'is false if a shooter is not behind the player' do
      @player.stub(:taking_damage?) { true }
      @player.stub(:shooter_behind?) { false }

      expect(@player.shot_from_behind?).to be_false
    end
  end

  describe '#closest_shooter_behind?' do
    it 'is true if the closest shooter is behind the player' do
      @player.stub(:enemy_at?).with(2) { true }
      @player.stub(:shooter_behind_at?).with(1) { true }

      expect(@player.closest_shooter_behind?).to be_true
    end

    it 'is false if the closest shooter is in front of the player'
  end
end
