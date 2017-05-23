class Knight
	attr_accessor :position, :moves

  def initialize position, parent='root', *moves
    @position = position
    # use the splat operator to pack in an arbitrary number of arguments
    @moves = *moves # I think the moves should be instances of Knights at other positions
    @parent = parent
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
    new_knight = Knight.new position, root_knight

    root_knight.moves.push new_knight

    queue.unshift new_knight
  end

  current_knight = root_knight

  counter = 0


  until counter == 7
    current_knight.moves.each do |move|
      # need to create an array of valid moves for that knight
      valid_moves = validated_moves move.position
      # THEN push instances of knights with those positions (from the arrays) to the knight
      valid_moves.each do |position|
        new_knight = Knight.new position, move
        move.moves.push new_knight
        queue.unshift new_knight
      end
      
    end


    current_knight = queue.pop

    counter += 1


  end
  root_knight

  
end

root = knight_moves [7, 7], [2, 6]


# this works, but doesn't find the shortest path. It simply finds all the knights
# whose position equals the target. But since our knights don't have parents,
# it is difficult to go backward.
def dfs_rec knight, target, collector=[]

  if knight
    puts "#{knight.position} and #{target}"

    

    if knight.position == target
      collector.push knight
    end
    moves = knight.moves.size - 1
    moves.times do |num|
      dfs_rec knight.moves[num], target, collector
    end
  end

  return collector
end

puts "cheese"

x = dfs_rec root, [6,0]

p x.size.inspect