require 'spec_helper'
require_relative '../player'
require_relative '../feeler'

describe Feeler do
  before do
    @player = Player.new
    @feeler = Feeler.new(@player)
    @feeler.stub(:space)
  end

  describe '#next_to_enemy?' do
    it 'checks if space has enemy in it' do
      expect(@feeler.space).to receive(:enemy?)

      @feeler.next_to_enemy?
    end
  end

  describe '#space_available?' do
    it 'checks if space is empty' do
      expect(@feeler.space).to receive(:empty?)

      @feeler.space_available?
    end
  end
end
