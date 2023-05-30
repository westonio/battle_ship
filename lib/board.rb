class Board
  attr_reader :cells, :size

  def initialize(size)
    @size = size
    @cells = create_cells
  end

  def create_cells
    keys = create_keys
    cells = {}
    keys.map do |key|
      cells[key] = Cell.new(key)
    end
    cells
  end

  # this is a helper for .create_cells
  def create_keys
    letters = ("A"..last_letter).to_a
    keys = []
    letters.each do |letter|
      (1..@size).each do |num|
        keys << "#{letter}#{num}"
      end
    end
    keys
  end

#this is a helper for create_keys and letter_possibilities
  def last_letter
    all_letters = ("A".."J").to_a
    all_letters[@size - 1]
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
     same_length?(ship, coordinates) && 
     not_diagonal?(coordinates) &&
     consecutive?(ship, coordinates) &&
     not_overlapping?(ship, coordinates)
  end

  def same_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def not_diagonal?(coordinates)
    coordinates[0][0] == coordinates[1][0] || coordinates[0][1] == coordinates[1][1]
  end

  def consecutive?(ship, coordinates)
    #separate letters and numbers
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1..2]
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
    letters = []
    ("A"..last_letter).each_cons(ship.length) do |valid_letters|
      letters << valid_letters
    end
    letters
  end

  #This is a helper method for .consecutive?
  def number_possibilities(ship)
    numbers = [] 
    ("1"..@size.to_s).each_cons(ship.length) do |valid_nums|
      numbers << valid_nums
    end
    numbers
  end

  #This is a helper method for .consecutive?
  def not_overlapping?(ship, coordinates)
    coordinates.all? do |cell|
      @cells[cell].ship.nil?
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |cell|
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
    options = cells.keys
    placement = options.sample(ship.length) #sample size equal to ship size
    until valid_placement?(ship, placement) 
      placement = options.sample(ship.length)
    end
    placement
  end
end