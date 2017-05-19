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



def knight_moves position, destination
  board = GameBoard.new
  # make sure position and destination are valid (i.e., within gameboard)
  if board.valid_move? position and board.valid_move? destination
    p "YUP"
  else
    p "Invalid position and/or destination"
  end

  # initialize knight with position
  root_knight = Knight.new position

  # we then come up with all the different moves that are possible from that position
  # There are 8 cases:
    # add 1 to x, 2 to y
    # add 1 to x, -2 to y
    # add -1 to x, 2 to y
    # add -1 to x, -2 to y
    # add 2 to x, 1 to y
    # add 2 to x, -1 to y
    # add -2 to x, 1 to y
    # add -2 to x, -1 to y
  # How to implement:
    # put the cases in an array. For each item, apply it to the current position
  cases = [ [1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1] ]

    # What would map do? 
      # A: Collect the results of the block into an array.
    # So how should we use map?
      # A: by using conditionals in the block. I suppose if we have a move
      # that isn't valid, we could use next to skip it?
  valid_moves = cases.map do 




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