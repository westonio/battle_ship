require 'spec_helper'

Rspec.describe Cell do
  
  before(:each) do
    @cell = Cell.new('B4')
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'exists' do
    expect(cell).to be_an_instance_of(Cell)
  end

  it 'checks if cell has object instances' do
    expect(cell.coordinate).to eq('B4') 
    expect(cell.ship).to eq(nil)
    expect(cell.empty?).to eq(true)
  end

  it 'can place a ship on the cell' do
    @cell.place_ship(@cruiser)
    expect(@cell.ship).to eq(@cruiser)
    expect(@cell.empty?).to eq(false)
  end

  it 'is not initially fired upon' do
    @cell.place_ship(@cruiser)
    expect(@cell.fired_upon?).to eq(false)
  end

  it 'knows when it has been fired upon' do
    @cell.place_ship(@cruiser)
    
    @cell.fire_upon
    
    expect(@cell.ship.health).to eq(2)
    expect(@cell.fired_upon?).to eq(true)
  end

  describe 'renterings' do
    it 'renders ”.” if the cell has not been fired upon' do
      expect(@cell.render).to eq(".")
    end
  
    it 'renders “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss)' do
      @cell.fire_upon
  
      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.render).to eq("M")
    end
  
    it 'renders “H” if the cell has been fired upon and it contains a ship (the shot was a hit)' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon

      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.render).to eq("H")
    end
  
    it 'renders “X” if the cell has been fired upon and its ship has been sunk.' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      @cruiser.hit
      @cruiser.hit
      
      expect(@cell.ship.sunk?).to eq(true)
      expect(@cell.render).to eq("X")
    end
  
    it 'can optionally render ship not found yet' do
      @cell.place_ship(@cruiser)
      
      expect(@cell.render(true)).to eq("S")
      expect(@cell.render(false)).to eq(".") # conceal cell - not fired upon
    end
  end
end