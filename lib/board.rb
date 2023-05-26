class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end


  def create_cells
    keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    cells = {}
    keys.map do |key|
      cells[key] = Cell.new(key)
    end
    cells
  end
end