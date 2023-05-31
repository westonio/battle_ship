class NewGame

  def initialize
    @player_interface = PlayerInterface.new
  end

  def main_menu
    response = @player_interface.welcome
    if response == 'p'
      play
    elsif response == 'q'
      @player_interface.quit
    else 
      @player_interface.invalid_start
      main_menu
    end
  end

  def play
    build_board
    @player_ships, @computer_ships = create_ships(num_ships)
    player_place_ships
    computer_place_ships
    until @player_ships.all?(&:sunk?) || @computer_ships.all?(&:sunk?)
      take_turns
    end
    end_of_game
  end

  def build_board
    @player_interface.game_board_intro
    @size = @player_interface.get_board_size
    @computer_board = Board.new(@size)
    @player_board = Board.new(@size)
  end

  def num_ships
    ship_count = @player_interface.get_ship_count
    if ship_count < 1 || ship_count.nil?
      @player_interface.invalid_ship_count #puts invalid statement
      num_ships
    end
    ship_count
  end

  def create_ships(count)
    @player_ships = []
    @computer_ships = []
    count.times do |i|
      name = @player_interface.get_ship_name(i)
      length = @player_interface.get_ship_length(name, @size)
      @player_ships << Ship.new(name, length)
      @computer_ships << Ship.new(name, length)
    end
    [@player_ships, @computer_ships]
  end

  def player_place_ships
    @player_ships.each { |ship| place_ship(ship) }
  end

  def computer_place_ships
    @computer_ships.each { |ship| @computer_board.randomly_place(ship) }
  end

  def place_ship(ship)
    ship_placement = @player_interface.get_ship_placement(ship, @player_board)
    if @player_board.valid_placement?(ship, ship_placement)
      @player_board.place(ship, ship_placement)
    else 
      @player_interface.invalid_placement
      place_ship(ship)
    end
  end

  def take_turns
    @player_interface.render_board(@computer_board, @player_board)
    player_shot
    computer_shot unless @computer_ships.all?(&:sunk?)
  end

  def player_shot
    shoot_at = @player_interface.choose_coordinate
    cell = @computer_board.cells[shoot_at]
    if !@computer_board.valid_coordinate?(shoot_at)
      @player_interface.invalid_shot # puts invalid statement
      player_shot
    elsif cell.fired_upon?
      @player_interface.already_shot_at(shoot_at)
      player_shot
    else
      cell.fire_upon
      @player_interface.player_render_shot(cell)
    end
  end

  def computer_shot
    random_cell = @player_board.cells.keys.sample
    until !@player_board.cells[random_cell].fired_upon?
      random_cell = @player_board.cells.keys.sample
    end
    cell = @player_board.cells[random_cell]
    cell.fire_upon
    @player_interface.computer_render_shot(cell)
  end

  def end_of_game
    if @player_ships.all?(&:sunk?)
      @player_interface.computer_won
    elsif @computer_ships.all?(&:sunk?)
      @player_interface.player_won
    end
    @player_interface.return_to_menu
    main_menu
  end

  # end of class
end