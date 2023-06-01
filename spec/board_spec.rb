require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @four_board = Board.new(4)
    @five_board = Board.new(5)
  end

  it 'exists' do
    expect(@four_board).to be_a(Board)
  end

  it 'takes size value upon initialization' do
    expect(@four_board.size).to eq(4)
  end

  it 'can create keys based off board size' do
    new_board = Board.new(5)
    keys = new_board.create_keys
    expected = ["A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "B4", "B5", "C1", "C2", "C3", "C4", "C5", "D1", "D2", "D3", "D4", "D5", "E1", "E2", "E3", "E4", "E5"]
    
    expect(keys).to eq(expected)
    expect(new_board.cells.keys). to eq(keys)
    expect(new_board.cells.values.first).to be_a(Cell)
    expect(new_board.cells).to be_a(Hash)
    expect(new_board.cells.length).to eq(25)
  end

  it 'checks if coordinate is valid' do
    expect(@four_board.valid_coordinate?("A1")).to be(true)
    expect(@four_board.valid_coordinate?("D4")).to be(true)

    expect(@four_board.valid_coordinate?("A5")).to be(false)
    expect(@four_board.valid_coordinate?("E1")).to be(false) 
    expect(@four_board.valid_coordinate?("A22")).to be(false)
  end

  describe 'valid placement' do
    it 'can only place cells equal to length of ship' do
      cruiser = Ship.new("Cruiser", 3)

      expect(@four_board.same_length?(cruiser, ["A1", "A2"])).to be(false)
      expect(@four_board.same_length?(cruiser, ["A1", "A2", "A3", "A4"])).to be(false)
      expect(@four_board.same_length?(cruiser, ["A2", "A3", "A4"])).to be(true)
    end

    it 'can be placed verticaly or horizonatally only' do
      expect(@four_board.not_diagonal?(["A1", "B2", "C3"])).to be(false)
      expect(@four_board.not_diagonal?(["A1", "A2", "A3"])).to be(true)
      expect(@four_board.not_diagonal?(["B2", "C2", "D2"])).to be(true)
    end

    it 'can only be placed in consecutive order' do
      cruiser = Ship.new("Cruiser", 3)

      expect(@four_board.consecutive?(cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@four_board.consecutive?(cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@four_board.consecutive?(cruiser, ["B2", "C2", "D2"])).to be(true)
      expect(@four_board.consecutive?(cruiser, ["C1", "C2", "C3"])).to be(true)
    end

    it 'can verify valid placemet' do
      cruiser = Ship.new("Cruiser", 3)

      expect(@four_board.valid_placement?(cruiser, ["A1", "A2"])).to be(false) # incorrect length
      expect(@four_board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false) # diagonal
      expect(@four_board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false) # not consecutive
      
      expect(@four_board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to be(true) 
      expect(@four_board.valid_placement?(cruiser, ["B2", "C2", "D2"])).to be(true) 
      expect(@four_board.valid_placement?(cruiser, ["C1", "C2", "C3"])).to be(true)

    end
  end
  
  it 'can place ship on board' do
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = @four_board.cells["A1"]
    cell_2 = @four_board.cells["A2"]
    cell_3 = @four_board.cells["A3"]

    @four_board.place(cruiser, ["A1", "A2", "A3"])

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cell_2.ship)
  end

  it 'cannot overlap other ships' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    
    @four_board.place(cruiser, ["A1", "A2", "A3"])
    expect(@four_board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
  end

  it 'renders board with object instance' do
    cuiser = Ship.new("Cruiser", 3)
    @four_board.place(cuiser, ["A1", "A2", "A3"])

    expect(@four_board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(@four_board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'renders in different sizes' do
    cuiser = Ship.new("Cruiser", 3)
    @five_board.place(cuiser, ["A1", "A2", "A3"])

    expect(@five_board.render).to eq("  1 2 3 4 5 \nA . . . . . \nB . . . . . \nC . . . . . \nD . . . . . \nE . . . . . \n")
    expect(@five_board.render(true)).to eq("  1 2 3 4 5 \nA S S S . . \nB . . . . . \nC . . . . . \nD . . . . . \nE . . . . . \n")
  end

  it 'hits board with object instance' do
    cuiser = Ship.new("Cruiser", 3)
    @four_board.place(cuiser, ["A1", "A2", "A3"])

    @four_board.cells["A1"].fire_upon
    expect(@four_board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'misses a ship' do
    cuiser = Ship.new("Cruiser", 3)
    @four_board.place(cuiser, ["A1", "A2", "A3"])

    @four_board.cells["A4"].fire_upon
    expect(@four_board.render(true)).to eq("  1 2 3 4 \nA S S S M \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'sinks a ship' do
    cuiser = Ship.new("Cruiser", 3)
    @four_board.place(cuiser, ["A1", "A2", "A3"])

    @four_board.cells["A1"].fire_upon
    @four_board.cells["A2"].fire_upon
    @four_board.cells["A3"].fire_upon
    expect(@four_board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
  end
  
  it 'randomly selects cells for placing ship' do
    cruiser = Ship.new("Cruiser", 3)
    placement = @four_board.random_cells(cruiser)

    expect(@four_board.valid_placement?(cruiser, placement)).to eq(true)
  end

  it 'randomly places ship on the board' do
    cruiser = Ship.new("Cruiser", 3)
    placed = @four_board.randomly_place(cruiser)

    expect(placed.length).to eq(3)
    expect(@four_board.cells[placed[0]].ship).to eq(cruiser)
    expect(@four_board.cells[placed[1]].ship).to eq(cruiser)
    expect(@four_board.cells[placed[2]].ship).to eq(cruiser)
  end
end