class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    @ship&.hit if @ship
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal_ship = false)
    if fired_upon?
      if !empty? && ship.sunk?
        "X"
      elsif empty?
        "M"
      else
        "H"
      end
    else
      reveal_ship && !empty? ? "S" : "."
    end
  end

  # end class
end