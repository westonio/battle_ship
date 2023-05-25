require 'spec_helper'

Rspec.describe Cell do
  
  before(:each) do
    cell = Cell.new('B4')
  end

  it 'exists' do
    expect(cell).to be_an_instance_of(Cell)
  end

  it 'checks if cell has object' do
    expect(cell.coordinate).to eq('B4') 
    expect(cell.ship).to eq(nil)
    expect(cell.empty?).to eq(true)
  end

  # end test
end