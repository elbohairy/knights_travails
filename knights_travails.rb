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


def validated_moves position
  board = GameBoard.new

  cases = [ [1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1] ]
  valid_moves = cases.map do |x, y|
    next_move = [ position[0] + x, position[1] + y ]
    if board.valid_move? next_move
      next_move
    else
      next
    end
  end

  valid_moves.compact!
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
#cases = [ [1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1] ]

    # What would map do? 
      # A: Collect the results of the block into an array.
    # So how should we use map?
      # A: by using conditionals in the block. I suppose if we have a move
      # that isn't valid, we could use next to skip it?
# valid_moves = cases.map do |x, y|
#   next_move = [ position[0] + x, position[1] + y ]
#   if board.valid_move? next_move
#     next_move
#   else
#     next
#   end
# end

# valid_moves.compact!
# p valid_moves

  valid_moves = validated_moves position

  # then we initialize a bunch of knights with those positions, and pass them as children to 
  # the initial knight.

  valid_moves.each do |position|
    root_knight.moves.push Knight.new position
  end

  p root_knight.inspect

  # THEN, we have a problem.
    # How do we then add children to those childreN?
    # ANSWER (i think):
      # the children will be in an array whose size we can find.
        # we can simply loop through each item (knight) in the array.
        # and for each knight we'll just do again what we did to the first knight.

  current_knight = root_knight

  counter = 0
  until counter == 3
    current_knight.moves.each do |move|

      # need to create an array of valid moves for that knight

      valid_moves = validated_moves move.position

# valid_moves = cases.map do |x, y|
#   next_move = [ move.position[0] + x, move.position[1] + y ]
#   if board.valid_move? next_move
#     next_move
#   else
#    next
#   end
# end

      # then remove all nil values
# valid_moves.compact!
      # THEN push instances of knights with those positions (from the arrays) to the knight
      valid_moves.each do |position|
        move.moves.push Knight.new position
      end

    end

    counter += 1


    # right here, I need to find some way of changing root_knight to its children, then
    # to the children's children, until some arbitrary point.
    # But I don't see the obvious way to do that.
    # Refactoring may help with that (lots of duplication)

    # POSSIBLE SOLUTION:
      # use a queue. Just keep adding to the queue until some arbitrary point
      # implementation?
        # I have no idea

  end


  p 'SPAGHETTI'
  p root_knight


  # FINISHED basic structure.
    # Now just need to figure out how to loop it properly.
      # e.g., current knight will need to change every iteration





    # How do we stop this from going on forever?
      # A: we could just arbitrarily limit how many times we do this whole process
end

p knight_moves [7, 7], [2, 6]