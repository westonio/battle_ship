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

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
  end

  def valid_placement?(ship, cells)
     same_length?(ship, cells) && 
     not_diagonal?(cells) &&
     consecutive?(ship, cells)
  end

  def same_length?(ship, cells)
    ship.length == cells.length
  end

  def not_diagonal?(cells)
    cells[0][0] == cells[1][0] || cells[0][1] == cells[1][1]
  end

  def consecutive?(ship, cells)
    #separate letters and numbers
    letters = []
    numbers = []
    cells.each do |cell|
      letters << cell[0]
      numbers << cell[1]
    end
    #run through helper methods to determine if sequence valid
    letter_possibilities(ship).any? do |valid_arrays|
      valid_arrays == letters
    end ||
    number_possibilities(ship).any? do |valid_arrays|
      valid_arrays == numbers
    end
  end

  #This is a helper method for .consecutive?
  def letter_possibilities(ship) 
    letter_possibilities = []
    ("A".."D").each_cons(ship.length) do |valid_arrays|
      letter_possibilities << valid_arrays
    end
    letter_possibilities
  end

  #This is a helper method for .consecutive?
  def number_possibilities(ship)
    numbers = [] 
    ("1".."4").each_cons(ship.length) do |valid_arrays|
      numbers << valid_arrays
    end
    numbers
  end
end