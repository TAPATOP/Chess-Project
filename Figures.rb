#requires move files

# inherited by all figures, aka abstract class
class Figure
  attr_accessor :x, :y, :table_of_range, :player, :has_moved, :image

  def initialize(x, y)
    @x = x
    @y = y
    @table_of_range = Table.new
    @has_moved = 0
  end

  def makeMove(x, y, defender, table)
    table[@x][@y] = '--'
    @x = x
    @y = y
    @has_moved = 1
    table[x][y] = self
  end

  def move(x, y, defender, table)

  	if @table_of_range[x][y] == '++' || @table_of_range[x][y] == '!!'
      makeMove(x, y, defender, table)
    elsif @table_of_range[x][y] == '00'
      puts 'Can\'t move there, friendly in the way!'
      return 1
    elsif @table_of_range[x][y] == 'xx'
      puts 'Enemy killed!'
      defender.figures.delete(table[x][y])

      table[@x][@y] = '--'

      makeMove(x, y, defender, table)
    elsif @table_of_range[x][y] == '!!' && self.class == Pawn # move this above

      table[@x][@y] = '--'
      makeMove(x, y, defender, table)
    else
      puts 'You can\'t move there with that'
      return 1
    end
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
          if @x + modifier1 > 0 && @x + modifier1 < 9 && @y + modifier2 > 0 && @y + modifier2 < 9 && LEGIT_FIGURES[table[@x + modifier1][@y + modifier2].class]
            if table[@x + modifier1][@y + modifier2].player == player
              table_of_range[@x + modifier1][@y + modifier2] = '00'
            else table_of_range[@x + modifier1][@y + modifier2] = 'xx'
            end
          else table_of_range[@x + modifier1][@y + modifier2] = '++' if @x + modifier1 > 0 && @x + modifier1 < 9 && @y + modifier2 > 0 && @y + modifier2 < 9 && table[@x + modifier1][@y + modifier2] == '--'
          end
        end
      end
    end
  end
end

class Pawn < Figure
  attr_accessor :direction, :en_passant

  def set_moves(table)
    @table_of_range = Table.new

    if @x != 8 && x!= 1 # checks if pawn can move at all

      if table[@x + @direction][@y] == '--'
        table_of_range[@x + @direction][@y] = '++' # this gets the possible ordinary moves
        if @x - @direction == 1 || @x - @direction == 8 && table[@x + 2 * @direction][@y] == '--'
          @en_passant = 1
          table_of_range[@x + 2 * @direction][@y] = '++' # this adds the second move from the start and enables en passant
        end
      end

      [-1, 1].each do |modifier|

      	# the if below checks for possible normal attacks
        if LEGIT_FIGURES[table[@x + @direction][@y + modifier].class]
          if table[@x + @direction][@y + modifier].player == @player
            table_of_range[@x + @direction][@y + modifier] = '00'
          else table_of_range[@x + @direction][@y + modifier] = 'xx'
          end
        end

      end
    end
  end

  alias_method :move_parent, :move

  def makeMove(x, y, defender, table)
  	originalX = @x
  	if table_of_range[x][y] == '!!'
  	  puts "EN PASSANTE'D"
  	  table[@x][@y] = '--'
  	  @x = x
  	  @y = y
  	  defender.figures.delete(table[@x - @direction][@y])
  	  table[@x - @direction][@y] = '--'
  	end
  	super

  	#creates en passante conditions
  	if (originalX - @x).abs == 2
  	  if @en_passant == 1
  	    defender.table_of_range[x - @direction][y] = '!'
  	  end
  	  @en_passant = 0
  	end
  end
end

LEGIT_FIGURES = { Rook => 'ro', Bishop => 'bi', Queen => 'qu', Knight => 'kn', King => 'ki', Pawn => 'pa' }
LEGIT_RESTORATION_FIGURES = { Rook => 'ro', Bishop => 'bi', Queen => 'qu', Knight => 'kn' }
LEGIT_STRING_FIGURES = { 'Rook' => Rook, 'Bishop' => Bishop, 'Queen' => Queen, 'Knight' => Knight, 'King' => King, 'Pawn' => Pawn }
