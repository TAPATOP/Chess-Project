require 'colorize'

# moves for queen and rook
module StraightMoves
  def move_south(figure, playing_table)
    (figure.x + 1).upto(8).each do |index|
      if LEGIT_FIGURES[playing_table[index][figure.y].class]
        if figure.player == playing_table[index][figure.y].player then figure.table_of_range[index][figure.y] = '00'
        else figure.table_of_range[index][figure.y] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[index][figure.y] = '++'
    end
  end

  def move_north(figure, playing_table)
    (figure.x - 1).downto(1).each do |index|
      if LEGIT_FIGURES[playing_table[index][figure.y].class]
        if figure.player == playing_table[index][figure.y].player then figure.table_of_range[index][figure.y] = '00'
        else figure.table_of_range[index][figure.y] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[index][figure.y] = '++'
    end
  end

  def move_west(figure, playing_table)
    (figure.y - 1).downto(1).each do |index|
      if LEGIT_FIGURES[playing_table[figure.x][index].class]
        if figure.player == playing_table[figure.x][index].player then figure.table_of_range[figure.x][index] = '00'
        else figure.table_of_range[figure.x][index] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[figure.x][index] = '++'
    end
  end

  def move_east(figure, playing_table)
    (figure.y + 1).upto(8).each do |index|
      if LEGIT_FIGURES[playing_table[figure.x][index].class]
        if figure.player == playing_table[figure.x][index].player then figure.table_of_range[figure.x][index] = '00'
        else figure.table_of_range[figure.x][index] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[figure.x][index] = '++'
    end
  end

  #
  # works on the presumtion this is a straight move
  #
  def move_straight(figure, playing_table)
    move_east(figure, playing_table)
    move_west(figure, playing_table)
    move_south(figure, playing_table)
    move_north(figure, playing_table)
  end
end

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

#
# helping functions
#

# used for interface, as well as figure possible moves/ attacks
class Table
  attr_accessor :squares

  def initialize
    @squares = Array.new(9) { Array.new(9, '--') }
  end

  def [](index)
    @squares[index]
  end

  def []=(index, something)
    @squares[index] = something
  end

  def display
    @squares.each do |line|
      line.each do |square|
        if LEGIT_FIGURES[square.class]
          if square.player == 1 then print LEGIT_FIGURES[square.class].upcase.blue
          else print LEGIT_FIGURES[square.class].red
          end
        else print square
        end

        print ' '
      end
      puts
    end
  end

  def put_figure(figure)
    if @squares[figure.x][figure.y] == '--'
      if LEGIT_FIGURES[figure.class]
        @squares[figure.x][figure.y] = figure
      else puts 'BEEP BOOP! No such figure, hun'
      end
    else puts 'BEEP BOOP! Coords are taken'
    end
  end

  def peek
    @squares.each { |line| puts line.object_id }
  end

  def format_table
    @squares[0].each_index { |index| squares[0][index] = '0' + index.to_s }
    @squares.each_index { |index| squares[index][0] = '0' + index.to_s }
  end
end

table = Table.new

rook = Rook.new(5, 5, 1)
rook3 = Rook.new(5, 3, 1)
rook2 = Rook.new(7, 5, 1)
rook4 = Rook.new(3, 5, 1)
bishop = Bishop.new(5, 7, 1)

table.put_figure(rook)
table.put_figure(bishop)
table.put_figure(rook2)
table.put_figure(rook3)
table.put_figure(rook4)

table.format_table

include StraightMoves

move_straight(table.squares[5][5], table)

puts
rook.table_of_range.display
puts
table.display

/ test TO DO

legit figure name
legit coord
/
