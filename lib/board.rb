class Board
  attr_reader :cells,
              :shots_taken

  def initialize
    @cells = create_cells
    @shots_taken = []
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

  def valid_placement?(ship, for_cells)
     same_length?(ship, for_cells) && 
     not_diagonal?(for_cells) &&
     consecutive?(ship, for_cells) &&
     not_overlapping?(ship, for_cells)
  end

  def same_length?(ship, for_cells)
    ship.length == for_cells.length
  end

  def not_diagonal?(for_cells)
    for_cells[0][0] == for_cells[1][0] || for_cells[0][1] == for_cells[1][1]
  end

  def consecutive?(ship, for_cells)
    #separate letters and numbers
    letters = []
    numbers = []
    for_cells.each do |cell|
      letters << cell[0]
      numbers << cell[1]
    end
    #run through helper methods to determine if sequence valid
    if letters.uniq.length == 1
      number_possibilities(ship).any? do |valid_arrays|
        valid_arrays == numbers
      end
    elsif numbers.uniq.length == 1
      letter_possibilities(ship).any? do |valid_arrays|
        valid_arrays == letters
      end
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

  #This is a helper method for .consecutive?
  def not_overlapping?(ship, for_cells)
    for_cells.all? do |cell|
      @cells[cell].ship.nil?
    end
  end

  def place(ship, for_cells)
    if valid_placement?(ship, for_cells)
      for_cells.each do |cell|
        @cells[cell].place_ship(ship)
      end 
    end
  end

  def render(reveal_board = false)
    if reveal_board 
      "  1 2 3 4 \n" +
      "A #{cells["A1"].render(true)} #{cells["A2"].render(true)} #{cells["A3"].render(true)} #{cells["A4"].render(true)} \n" +
      "B #{cells["B1"].render(true)} #{cells["B2"].render(true)} #{cells["B3"].render(true)} #{cells["B4"].render(true)} \n" +
      "C #{cells["C1"].render(true)} #{cells["C2"].render(true)} #{cells["C3"].render(true)} #{cells["C4"].render(true)} \n" +
      "D #{cells["D1"].render(true)} #{cells["D2"].render(true)} #{cells["D3"].render(true)} #{cells["D4"].render(true)} \n"

    else
      "  1 2 3 4 \n" +
      "A #{cells["A1"].render} #{cells["A2"].render} #{cells["A3"].render} #{cells["A4"].render} \n" +
      "B #{cells["B1"].render} #{cells["B2"].render} #{cells["B3"].render} #{cells["B4"].render} \n" +
      "C #{cells["C1"].render} #{cells["C2"].render} #{cells["C3"].render} #{cells["C4"].render} \n" +
      "D #{cells["D1"].render} #{cells["D2"].render} #{cells["D3"].render} #{cells["D4"].render} \n"
    end
  end

  def randomly_place(ship)
    placement = random_cells(ship)
    place(ship, placement)
  end

  #This is a helper method for .randomly_place
  def random_cells(ship)
    length = ship.length
    cell_options = cells.keys
    placement = cell_options.sample(length)

    until valid_placement?(ship, placement) 
      placement = cell_options.sample(length)
    end
    placement
  end

  def track_shot(cell)
    @shots_taken << cell
  end
end