class NewGame

  def main_menu
    puts "Welcome to BATTLESHIP \n" +
         "Enter p to play. Enter q to quit."
    @response = gets.chomp
  end


  def start
    if @response = 'p'
      computer_board = Board.new
      player_board = Board.new
    elsif @response = 'q'
      puts "Thank you for playing BATTLESHIP!"
    else 
      puts 'Invalid Input Please use either p or q.'
      main_menu
    end
  end

end