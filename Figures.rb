#requires move files

# inherited by all figures, it's just for interface
class Figure
  attr_accessor :x, :y, :table_of_range, :player

  def initialize(x, y)
    @x = x
    @y = y
    @table_of_range = Table.new
  end

  def move(x, y, table)
    @x = x
    @y = y
    table[x][y] = self
  end
end

# obviously rook
class Rook < Figure
  include StraightMoves

  def set_moves(table)
    @table_of_range = Table.new
    straight_moves(self, table)
  end
end

class Bishop < Figure
  include DiagonalMoves

  def set_moves(table)
    @table_of_range = Table.new
    diagonal_moves(self, table)
  end
end

class Queen < Figure
  include StraightMoves
  include DiagonalMoves
  
  def set_moves(table)
    @table_of_range = Table.new
    straight_moves(self, table)
    diagonal_moves(self, table)
  end
end

class Knight < Figure
  def set_moves(table)
    @table_of_range = Table.new
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

class King < Figure
  def set_moves(table)
    @table_of_range = Table.new
    [-1, 0, 1].each do |modifier1|
      [-1, 0, 1].each do |modifier2|
        if modifier1 != 0 || modifier2 !=0
          if LEGIT_FIGURES[table[@x + modifier1][@y + modifier2].class]
            if table[@x + modifier1][@y + modifier2].player == player
              table_of_range[@x + modifier1][@y + modifier2] = '00'
            else table_of_range[@x + modifier1][@y + modifier2] = 'xx'
            end
          else table_of_range[@x + modifier1][@y + modifier2] = '++' if table[@x + modifier1][@y + modifier2] == '--'
          end
        end
      end
    end
  end
end

class Pawn < Figure
  @direction
  def set_moves(table)
    @table_of_range = Table.new
    if @player == 1 then @direction = 1
    else @direction = -1
    end
    
    if @x != 8 && x!= 1
      if table[@x + @direction][@y] == '--' then table_of_range[@x + @direction][@y] = '++' end
      [-1, 1].each do |modifier|
        if LEGIT_FIGURES[table[@x + @direction][@y + modifier].class]
          if table[@x + @direction][@y + modifier].player == @player
            table_of_range[@x + @direction][@y + modifier] = '00'
          else table_of_range[@x + @direction][@y + modifier] = 'xx'
          end
        end
      end
    end
  end
end

LEGIT_FIGURES = { Rook => 'ro', Bishop => 'bi', Queen => 'qu', Knight => 'kn', King => 'ki', Pawn => 'pa' }
