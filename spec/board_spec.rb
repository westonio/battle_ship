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

  it 'checks if coordinate is valid' do
    expect(@board.valid_coordinate?("A1")).to be(true)
    expect(@board.valid_coordinate?("D4")).to be(true)

    expect(@board.valid_coordinate?("A5")).to be(false)
    expect(@board.valid_coordinate?("E1")).to be(false) 
    expect(@board.valid_coordinate?("A22")).to be(false)
  end

  describe 'valid placement' do
    it 'can only place cells equal to length of ship' do
      cruiser = Ship.new("Cruiser", 3)

      expect(@board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(cruiser, ["A1", "A2", "A3", "A4"])).to be(false)
      expect(@board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to be(true)
    end

    it 'can be placed verticaly or horizonatally only' do
      cruiser = Ship.new("Cruiser", 3)

      expect(@board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(@board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be(true)
      expect(@board.valid_placement?(cruiser, ["B2", "C2", "D2"])).to be(true)
    end

    it 'can only be placed in consecutive order' do
      cruiser = Ship.new("Cruiser", 3)

      expect(@board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@board.valid_placement?(cruiser, ["B2", "C2", "D2"])).to be(true)
      expect(@board.valid_placement?(cruiser, ["C1", "C2", "C3"])).to be(true)
    end
  end

  it 'can place ship on board' do
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    @board.place(cruiser, ["A1", "A2", "A3"])

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cell_2.ship)
  end

  it 'cannot overlap other ships' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    
    @board.place(cruiser, ["A1", "A2", "A3"])
    expect(@board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
  end

  it 'renders board with object instence' do
    cuiser = Ship.new("Cruiser", 3)
    @board.place(cuiser, ["A1", "A2", "A3"])

    expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

end