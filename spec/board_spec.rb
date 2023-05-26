require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end

  it 'exists' do
    expect(@board).to be_a(Board)
  end

  it 'starts with a board of 4 X 4' do
    keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    
    expect(@board.cells.keys). to eq(keys)
    expect(@board.cells.values.first).to be_a(Cell)
    expect(@board.cells).to be_a(Hash)
    expect(@board.cells.length).to eq(16)
  end
end