require 'spec_helper'

Rspec.describe Cell do
  
  before(:each) do
    @cell = Cell.new('B4')
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
    
    @cell.fired_upon
    
    expect(@cell.ship.health).to eq(2)
    expect(@cell.fired_upon?).to eq(true)
  end
end