class NewGame

  def main_menu
    puts "Welcome to BATTLESHIP \n" +
         "Enter p to play. Enter q to quit."
    @response = gets.chomp
  end


  def start
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

    # computer random placement goes here
    player_place_ships
  end

  def player_place_ships
    puts "I have laid out my ships on the grid. \n" +
         "You now need to lay out your two ships. \n" +
         "The Cruiser is three units long and the Submarine is two units long."
    puts "  1 2 3 4\n" +
         "A . . . .\n" +
         "B . . . .\n" +
         "C . . . .\n" +
         "D . . . ."
    
    cruiser_response
    submarine_response
  end

  def cruiser_response
    puts "Enter the squares for the Cruiser (3 spaces)"
    @cruiser_placement = gets.chomp.split.to_a
    place_cruiser
  end

  def place_cruiser
    cruiser = Ship.new("Cruiser", 3)
    if @player_board.validate_placement?(cruiser, cruiser_placement))
      @player_board.place(cruiser, cruiser_placement)
      puts @player_board.render(true)
    else 
      puts "Invalid placement."
      cruiser_response
    end
  end

  def submarine_response
    puts "Enter the squares for the Submarine (2 spaces)"
    @cruiser_placement = gets.chomp.split.to_a
    place_submarine
  end

  def place_submarine
    submarine = Ship.new("Submarine", 3)
    if @player_board.validate_placement?(submarine, submarine_placement))
      @player_board.place(submarine, submarine_placement)
      puts @player_board.render(true)
    else 
      puts "Invalid placement."
      submarine_response
    end
  end


end