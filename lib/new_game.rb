class NewGame

  def main_menu
    puts "Welcome to BATTLESHIP \n" +
         "Enter p to play. Enter q to quit."
    @response = gets.chomp.strip.downcase
    if @response == 'p'
      play
    elsif @response == 'q'
      "Thank you for playing BATTLESHIP!"
    else 
      puts 'Invalid Input Please use either p or q.'
      main_menu
    end
  end

  def play
    @computer_board = Board.new
    @player_board = Board.new

    puts "Enter the number of ships you want to create:"
    ship_count = gets.chomp.to_i
    if ship_count < 1
    puts 'Invalid Input. Must create at least one ship.'
      play
    end

    @player_ships, @computer_ships = create_ships(ship_count)
    build_board
    player_place_ships
    computer_place_ships

    until @player_ships.all?(&:sunk?) || @computer_ships.all?(&:sunk?)
      take_turns
    end
    end_of_game
  end

  def create_ships(count)
    player_ships = []
    computer_ships = []
    count.times do |i|
      puts "Enter the name for Ship #{i + 1}:"
      name = gets.chomp.strip
      while name.nil? || name.empty?
        puts "Name cannot be empty."
        puts "Enter the name for Ship #{i + 1}:"
        name = gets.chomp.strip
      end

      puts "Enter the length for the #{name}:"
      length = gets.chomp.to_i
      while length <= 1
        puts "Please enter a length greater than 1."
        puts "Enter the length for the #{name}:"
        length = gets.chomp.to_i
      end
      
      player_ships << Ship.new(name, length)
      computer_ships << Ship.new(name, length)
    end
    [player_ships, computer_ships]
  end
  
  def build_board
    puts  "Let's build your game board! \n" +
          "The game board can be 4x4 squares up to 10x10 squares"
    size = get_board_size
    @computer_board = Board.new(size)
    @player_board = Board.new(size)
  end

  def get_board_size
    puts "Please enter the number of rows and colums you want (min of 4 & max of 10):"
    size = gets.chomp.strip.to_i
    if size < 4 || size > 10
      puts "Please enter a valid number between 4 and 10:"
      get_board_size
    end
    size
  end

  def player_place_ships
    @player_ships.each { |ship| place_ship(ship) }
  end

  def computer_place_ships
    @computer_ships.each { |ship| @computer_board.randomly_place(ship) }
  end

  def place_ship(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    puts @player_board.render(true)
    ship_placement = gets.chomp.strip.upcase.split.to_a
    if @player_board.valid_placement?(ship, ship_placement)
      @player_board.place(ship, ship_placement)
      puts @player_board.render(true)
    else 
      puts "Those are invalid coordinates. Please try again."
      place_ship(ship)
    end
  end

  def take_turns
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    player_shot
    computer_shot unless @computer_ships.all?(&:sunk?)
  end

  def player_shot
    puts "Choose a coordinate to fire at:"
    shot_at = gets.chomp.strip.upcase
    cell = @computer_board.cells[shot_at]
    if !@computer_board.valid_coordinate?(shot_at)
      puts "Please enter a valid coordinate."
      player_shot
    elsif cell.fired_upon?
      puts "Oops! You already fired at #{shot_at}."
      player_shot
    else
      cell.fire_upon
      puts "Your shot on #{shot_at} was a #{hit_miss_sink(cell)}."
    end
  end

  def computer_shot
    random_cell = @player_board.cells.keys.sample
    until !@player_board.cells[random_cell].fired_upon?
      random_cell = @player_board.cells.keys.sample
    end
    cell = @player_board.cells[random_cell]
    cell.fire_upon
    puts "My shot on #{cell.coordinate} was a #{hit_miss_sink(cell)}."
  end

  #This is a helper method for describing the shots
  def hit_miss_sink(cell)
    if cell.render == "M"
      "miss"
    elsif cell.render == "H"
      "hit"
    elsif cell.render == "X"
      "hit and sunk the #{cell.ship.name} \u{1F62D}"
    end
  end

  def end_of_game
    if @player_ships.all?(&:sunk?)
      puts "I won! Better luck next time \u{1F61C}"
    elsif @computer_ships.all?(&:sunk?)
      puts "\u{1F389} Congrats! You won!! \u{1F3C6}"
    end
    puts "Hit ENTER to return to the Main Menu"
    gets.chomp
    main_menu
  end

  # end of class
end