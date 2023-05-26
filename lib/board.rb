class Board

  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells = {}
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        cell_key = "#{letter}#{number}"
        cells[cell_key] = Cell.new
      end
    end
    cells
  end
end