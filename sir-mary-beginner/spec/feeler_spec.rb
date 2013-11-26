require 'spec_helper'
require_relative '../player'
require_relative '../feeler'

describe Feeler do
  before do
    @player = Player.new
    @feeler = Feeler.new(@player)
  end

  describe '#space_available?' do
    it 'checks if the space is empty' do
      expect(@player).to receive(:feel)

      @feeler.space_available?
    end
  end
end
