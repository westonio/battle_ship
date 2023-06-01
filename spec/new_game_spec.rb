require 'spec_helper'

RSpec.describe NewGame do
  before(:each) do
    @game = NewGame.new
  end

  it 'exists' do
    expect(@game).to be_a(NewGame)
  end

  it 'has a player interface' do
    expect(@game.player_interface).to be_a(PlayerInterface)
  end
end