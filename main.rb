require 'colorize'

module StraightMoves
  def moveSouth(figure, player, tableOfRange, playingTable)
    (figure.x + 1).upto(8).each do |index|
      tableOfRange.squares[index][figure.y] = '++'
    end
  end

  def moveNorth(figure, player, tableOfRange, playingTable)
    (figure.x - 1).downto(1).each do |index|
      tableOfRange.squares[index][figure.y] = '++'
    end
  end

  def moveWest(figure, player, tableOfRange, playingTable)
    (figure.y - 1).downto(1).each do |index|
      tableOfRange.squares[figure.x][index] = '++'
    end
  end

  def moveEast(figure, player, tableOfRange, playingTable)
    (figure.y + 1).upto(8).each do |index|
      tableOfRange.squares[figure.x][index] = '++'
    end
  end

  #
  # works on the presumtion this is a straight move
  #
  def moveStraight (figure, playingTable)
    moveEast(figure, figure.player, figure.tableOfRange, playingTable)
    moveWest(figure, figure.player, figure.tableOfRange, playingTable)
    moveSouth(figure, figure.player, figure.tableOfRange, playingTable)
    moveNorth(figure, figure.player, figure.tableOfRange, playingTable)
  end
end

class Figure
  attr_accessor :x, :y, :tableOfRange

  @player # Owner; White/ Black player
  
  def player
    @player
  end

  def initialize(x = 0, y = 0, player = 0)
    @x = x
    @y = y
    @player = player
    @tableOfRange = Table.new
  end
end

class Rook < Figure
  include StraightMoves
end

class Bishop < Figure

end

#
# figures above
#

LEGIT_FIGURES = { ro: Rook, bi: Bishop }

def stringToFigure(element)
  if LEGIT_FIGURES[element.to_sym] || LEGIT_FIGURES[element.downcase.to_sym] then puts 'ok'
  end
end

#
# helping functions
#

class Table

  attr_accessor :squares
  
  def initialize
    @squares = Array.new(9) { Array.new(9, '--') }
  end

  def display
    @squares.each do |line|
      line.each do |square|

        if LEGIT_FIGURES[square.to_sym] then print square.red
        elsif LEGIT_FIGURES[square.downcase.to_sym] then print square.blue
        else print square
        end

        print ' '
      end
      puts
    end
  end

  def putFigure(figure)
    if @squares[figure.x][figure.y] == '--'
      if LEGIT_FIGURES.key(figure.class)
        if figure.player == 2 then @squares[figure.x][figure.y] = LEGIT_FIGURES.key(figure.class).to_s
        else @squares[figure.x][figure.y] = LEGIT_FIGURES.key(figure.class).to_s.upcase  
        end
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

rook = Rook.new(2, 2, 2)
bishop = Bishop.new(3, 3, 1)

table.putFigure(rook)
table.putFigure(bishop)
# table.putFigure()

table.format_table

include StraightMoves

moveStraight(rook, table)

puts
rook.tableOfRange.display
puts
table.display

/ test TO DO

legit figure name
legit coord
/
