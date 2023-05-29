class NewGame

  def main_menu
    puts "Welcome to BATTLESHIP \n" +
         "Enter p to play. Enter q to quit."
    @response = gets.chomp
    if @response == 'p'
      play
    elsif @response == 'q'
      puts "Thank you for playing BATTLESHIP!"
    else 
      puts 'Invalid Input Please use either p or q.'
      main_menu
    end
  end

  def play
    @computer_board = Board.new
    @player_board = Board.new

    computer_place_ships
    player_place_ships
    take_turns
  end

  def computer_place_ships
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_board.randomly_place(@computer_cruiser)
    @computer_board.randomly_place(@computer_submarine)
  end

  def player_place_ships
    puts "I have laid out my ships on the grid. \n" +
         "You now need to lay out your two ships. \n" +
         "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
    place_cruiser
    place_submarine
  end

  def place_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_placement = gets.chomp.split.to_a
    @player_cruiser = Ship.new("Cruiser", 3)
    if @player_board.valid_placement?(@player_cruiser, cruiser_placement)
      @player_board.place(@player_cruiser, cruiser_placement)
      puts @player_board.render(true)
    else 
      puts "Those are invalid coordinates. Please try again."
      place_cruiser
    end
  end

  def place_submarine
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_placement = gets.chomp.split.to_a
    @player_submarine = Ship.new("Submarine", 2)
    if @player_board.valid_placement?(@player_submarine, submarine_placement)
      @player_board.place(@player_submarine, submarine_placement)
      puts @player_board.render(true)
    else 
      puts "Those are invalid coordinates. Please try again."
      place_submarine
    end
  end

  def take_turns
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    player_shot
    until @player_cruiser.sunk? && @player_submarine.sunk? || @computer_cruiser.sunk? && @computer_submarine.sunk?
      take_turns
    end
  end

  def player_shot
    puts "Choose a coordinate to fire at:"
    shot_at = gets.chomp
    if @computer_board.valid_coordinate?(shot_at) && !@computer_board.shots_taken.include?(shot_at)
      cell = @computer_board.cells[shot_at]
      @computer_board.track_shot(cell.coordinate)
      cell.fire_upon
      puts "Your shot on #{shot_at} was a #{hit_miss_sink(cell)}."
    else
      puts "Please enter a valid coordinate:"
      player_shot
    end
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
end