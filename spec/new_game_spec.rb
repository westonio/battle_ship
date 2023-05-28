require 'spec_helper'

RSpec.describe NewGame do
  before(:each) do
    @game = NewGame.new
  end

  it 'prompts the user to play or quit' do
    allow(@game).to receive(:gets).and_return('p')
    expect { @game.main_menu }.to output(/Enter p to play. Enter q to quit./).to_stdout
    expect(@game.instance_variable_get(:@response)).to eq('p')
  end

  it 'calls the play method' do
      @game.instance_variable_set(:@response, 'p')
      expect(@game).to receive(:play)
      @game.start
  end

  it 'displays a thank you message' do
      @game.instance_variable_set(:@response, 'q')
      expect { @game.start }.to output(/Thank you for playing BATTLESHIP!/).to_stdout
  end

  it 'displays an invalid input message' do
      @game.instance_variable_set(:@response, 'x')
      expect { @game.start }.to output(/Invalid Input Please use either p or q./).to_stdout
  end

end