require 'spec_helper'
require_relative '../attacker'
require_relative '../player'

describe Attacker do
  before do
    @player = Player.new
    @attacker = Attacker.new(@player)
  end

  describe '#relevant?' do
    it 'checks if player is next to enemy' do
      expect(@player).to receive(:next_to_enemy?)

      @attacker.relevant?
    end
  end

  describe '#perform_action' do
    it 'tells the player to attack' do
      expect(@player).to receive(:attack!)

      @attacker.perform_action
    end
  end
end
