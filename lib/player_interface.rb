class PlayerInterface
# Main Menu
  def welcome
    puts "Welcome to BATTLESHIP \n" +
        "Enter p to play. Enter q to quit."
    gets.chomp.strip.downcase
  end

  def quit
    puts "Thank you for playing BATTLESHIP!"
  end

  def invalid_start
    puts 'Invalid Input Please use either p or q.'
  end

# Build Board
  def game_board_intro
    puts  "Let's build your game board! \n" +
          "The game board can be 4x4 squares up to 10x10 squares"
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

# Ship Count
  def get_ship_count
    puts "Enter the number of ships to create:"
    gets.chomp.to_i
  end

  def invalid_ship_count
    puts 'Invalid Input. Must create at least one ship.'
  end

# Create Ships
  def get_ship_name(i)
    puts "Enter the name for Ship #{i + 1}:"
    name = gets.chomp.strip
    while name.nil? || name.empty?
      puts "Name cannot be empty."
      puts "Enter the name for Ship #{i + 1}:"
      name = gets.chomp.strip
    end
    name
  end

  def get_ship_length(name, size)
    puts "Enter the length for the #{name}:"
      length = gets.chomp.to_i
      while (length <= 1) || (length > size)
        puts "Please enter a length greater than 1 and less than the board size."
        puts "Enter the length for the #{name}:"
        length = gets.chomp.to_i
      end
      length
  end

  # Place Ships
  def get_ship_placement(ship, player_board)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    puts player_board.render(true)
    gets.chomp.strip.upcase.split.to_a
  end

  def invalid_placement
    puts "Those are invalid coordinates. Please try again."
  end

# Take Turns
  def render_board(computer_board, player_board)
    puts "=============COMPUTER BOARD============="
    puts computer_board.render
    puts "==============PLAYER BOARD=============="
    puts player_board.render(true)
  end


end