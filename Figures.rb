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
end

class Bishop < Figure
end

#
# figures above
#

LEGIT_FIGURES = { Rook => 'ro', Bishop => 'bi' }
