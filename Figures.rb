#requires move files

# inherited by all figures, it's just for interface
class Figure
  attr_accessor :x, :y, :table_of_range
  attr_reader :player

  def initialize(x, y, player)
    @x = x
    @y = y
    @player = player
    @table_of_range = Table.new
  end
end

# obviously rook
class Rook < Figure
  include StraightMoves

  def set_moves(table)
  	straight_moves(self, table)
  end
end

class Bishop < Figure
  include DiagonalMoves

  def set_moves(table)
  	diagonal_moves(self, table)
  end
end

class Queen < Figure
  include StraightMoves
  include DiagonalMoves
  
  def set_moves(table)
  	straight_moves(self, table)
  	diagonal_moves(self, table)
  end
end

class Knight < Figure

  def set_moves(table)
    [-1, 1].each do |modifier1|
      [-1, 1].each do |modifier2|
      [0, 1].each do |modifier3|

      	  if @x + modifier1 * (1 + modifier3) > 0 && @x + modifier1 * (1 + modifier3) < 9  && 
      	  	 @y + modifier2 * (2 - modifier3) > 0 && @y + modifier2 * (2 - modifier3) < 9

      	    if LEGIT_FIGURES[table[@x + modifier1 * (1 + modifier3)][@y + modifier2 * (2 - modifier3)].class]
      	      if table[@x + modifier1 * (1 + modifier3)][@y + modifier2 * (2 - modifier3)].player == player
      	        table_of_range[@x + modifier1 * (1 + modifier3)][@y + modifier2 * (2 - modifier3)] = '00'
      	      else table_of_range[@x + modifier1 * (1 + modifier3)][@y + modifier2 * (2 - modifier3)] = 'xx'
      	      end
      	    else table_of_range[@x + modifier1 * (1 + modifier3)][@y + modifier2 * (2 - modifier3)] = '++'
      	    end

      	  end
        end

      end
    end
  end
end
LEGIT_FIGURES = { Rook => 'ro', Bishop => 'bi', Queen => 'qu', Knight => 'kn' }
