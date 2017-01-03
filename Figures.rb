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
#
# figures above
#

LEGIT_FIGURES = { Rook => 'ro', Bishop => 'bi', Queen => 'qu' }
