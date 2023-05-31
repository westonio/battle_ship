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
      "#{line_1} \n" +
      "#{other_lines(reveal_board)}"
    else
      "#{line_1} \n" +
      "#{other_lines(reveal_board)}"
    end
  end

  def line_1
    string = " "
    (1..size).each do |num|
      string += " #{num}"
    end
    string
  end

  def other_lines(reveal_board)
    letters = ("A"..last_letter).to_a
    string = ""
    letters.each do |letter|
      string += "#{letter}"
      letter_keys = create_keys.select do |key|
        key[0] == letter
      end
      letter_keys.map do |key|
        string += " #{cells[key].render(reveal_board)}"
      end 
      string += " \n"
    end
    string
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