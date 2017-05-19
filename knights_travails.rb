class Knight
	attr_accessor :position, :moves

  def initialize position, *moves
    @position = position
    # use the splat operator to pack in an arbitrary number of arguments
    @moves = *moves # I think the moves should be instances of Knights at other positions
  end


end

class GameBoard

  def valid_move? position
    if valid_x_coord? position and valid_y_coord? position
      true
    else
      false
    end
  end

  def valid_x_coord? position
    if position[0] >= 0 and position[0] <= 7
      true
    else  
      false
    end
  end


  def valid_y_coord? position
    if position[1] >= 0 and position[1] <= 7
      true
    else
      false
    end
  end


end

$board = GameBoard.new

def knight_moves position, destination
  # make sure position and destination are valid (i.e., within gameboard)
  if $board.valid_move? position and $board.valid_move? destination
    "YUP"
  else
    "Invalid position and/or destination"
  end

  # initialize knight with position
  root_knight = Knight.new position

  # we then come up with all the different moves that are possible from that position

  # then we initialize a bunch of knights with those positions, and pass them as children to 
  # the initial knight.

  # THEN, we have a problem.
    # How do we then add children to those childreN?
    # ANSWER (i think):
      # the children will be in an array whose size we can find.
        # we can simply loop through each item (knight) in the array.
        # and for each knight we'll just do again what we did to the first knight.

    # How do we stop this from going on forever?
      # A: we could just arbitrarily limit how many times we do this whole process
end

p knight_moves [5, 2], [2, 6]