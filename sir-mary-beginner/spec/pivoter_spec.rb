require 'spec_helper'
require_relative '../player'
require_relative '../pivoter'

describe Pivoter do
  before do
    @player = Player.new
    @pivoter = Pivoter.new(@player)
    @direction = @player.direction
    @opposite_direction = @player.opposite_direction
  end

  describe '#relevant?' do
    context 'if the player is taking damage' do
      before do
        @pivoter.stub(:running_into_wall?) { false }
        @player.stub(:taking_damage?) { true }
      end

      it 'is true if the closest shooter is behind the player' do
        @pivoter.stub(:shooter_at?).with(0, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(0, @opposite_direction) { false }

        @pivoter.stub(:shooter_at?).with(1, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(1, @opposite_direction) { true }

        expect(@pivoter.relevant?).to be_true
      end

      it 'is false if the closest shooter is in front of the player' do
        @pivoter.stub(:shooter_at?).with(0, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(0, @opposite_direction) { false }

        @pivoter.stub(:shooter_at?).with(1, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(1, @opposite_direction) { false }

        @pivoter.stub(:shooter_at?).with(2, @direction)          { true }
        @pivoter.stub(:shooter_at?).with(2, @opposite_direction) { false }

        expect(@pivoter.relevant?).to be_false
      end

      it 'is false if there are no shooters around the player' do
        @pivoter.stub(:shooter_at?).with(0, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(0, @opposite_direction) { false }

        @pivoter.stub(:shooter_at?).with(1, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(1, @opposite_direction) { false }

        @pivoter.stub(:shooter_at?).with(2, @direction)          { false }
        @pivoter.stub(:shooter_at?).with(2, @opposite_direction) { false }

        expect(@pivoter.relevant?).to be_false
      end
    end

    context 'if a shooter is not behind the player' do
      before do
        @pivoter.stub(:shot_from_behind?) { false }
      end

      it 'is false if player is not next to a wall' do
        @player.stub(:next_to_wall?) { false }

        expect(@pivoter.relevant?).to be_false
      end

      it 'is false if player is backed into a wall' do
        @player.stub(:next_to_wall?) { true }
        @player.stub(:direction) { :backward }

        expect(@pivoter.relevant?).to be_false
      end

      it 'is true if player is facing a wall' do
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
