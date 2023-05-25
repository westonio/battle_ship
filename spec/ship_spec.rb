require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'exists' do
    expect(@cruiser).to be_a(Ship)
  end

  it 'has a name' do
    expect(@cruiser.name).to eq('Cruiser')
  end

  it 'has a length' do
    expect(@cruiser.length).to eq(3)
  end

  it 'has health equal to length' do
    expect(@cruiser.health).to eq(3)
  end

  it 'starts out not sunk' do
    expect(@cruiser.sunk?).to eq(false)
  end

  it 'checks health after being hit' do
    @cruiser.hit
    expect(@cruiser.health).to eq(2)

    @cruiser.hit
    expect(@cruiser.health).to eq(1)
  end

  it 'sinks when health is zero' do
    @cruiser.hit
    @cruiser.hit
    expect(@cruiser.sunk?).to eq(false)

    @cruiser.hit

    expect(@cruiser.health).to eq(0)
    expect(@cruiser.sunk?).to eq(true)
  end
end