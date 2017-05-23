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

  return valid_moves
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

  valid_moves = validated_moves position
  # then we initialize a bunch of knights with those positions, and pass them as children to 
  # the initial knight.

  queue = []

  valid_moves.each do |position|
    new_knight = Knight.new position

    root_knight.moves.push new_knight

    queue.unshift new_knight
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

  p "THE QUEUE"
  p queue.inspect

  until counter == 7
    current_knight.moves.each do |move|
      # need to create an array of valid moves for that knight
      valid_moves = validated_moves move.position
      # THEN push instances of knights with those positions (from the arrays) to the knight
      valid_moves.each do |position|
        new_knight = Knight.new position
        move.moves.push new_knight
        queue.unshift new_knight
      end
      
    end

    p counter
    p 'The current knight:'

    p current_knight
    p 'tHE QUEUE:'

    p queue

    current_knight = queue.pop

    p "The current knight, after queue.pop"
    p current_knight
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
  p "Root knight's current array of moves"
  p root_knight.moves
  p "The first child of root_knight"
  p root_knight.moves[0]
  p "The moves of the first child of root_knight"
  p root_knight.moves[0].moves
  p "The movoes of the first child of the first child of the root_knight"
  p root_knight.moves[0].moves[0].moves


  root_knight

  # FINISHED basic structure.
    # Now just need to figure out how to loop it properly.
      # e.g., current knight will need to change every iteration

    # How do we stop this from going on forever?
      # A: we could just arbitrarily limit how many times we do this whole process
end

root = knight_moves [7, 7], [2, 6]


# I THINK we have a working tree. Now we just need to search it!


def dfs_rec knight, target

  if knight
    puts "#{knight.position} and #{target}"
    if knight.position == target
      return knight
    end
    moves = knight.moves.size - 1
    moves.times do |num|
      dfs_rec knight.moves[num], target
    end
  end
end

puts "cheese"

p dfs_rec root, [4,0]