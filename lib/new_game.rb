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
    computer_board = Board.new
    player_board = Board.new

    # computer random placement goes here
    player_place_ships(player_board)
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

    place_ship("Cruiser")
  end

  def place_ship(ship, for_cells)
    puts "Enter the squares for the #{ship})"
    placement = gets.chomp.split


  end

end