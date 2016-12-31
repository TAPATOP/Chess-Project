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
end

class Figure
  attr_accessor :x, :y

  @player # Owner; White/ Black player

  def initialize(x = 0, y = 0, player = 0)
    @x = x
    @y = y
    @player = player
  end
end

class Rook < Figure
  include StraightMoves
end

# figures above


def stringToFigure(element)
  legitFigures = { ro: Rook.new }
  #if(element == 'ro' || element == 'kn' || element == 'bi' || element == 'ro' || element == 'ro' || element == 'ro')
  if legitFigures[element.to_sym] then puts 'ok'
  end
end

stringToFigure('re')

class Table

	attr_accessor :squares
  def initialize
  	@squares = Array.new(9){ Array.new(9, '--')}
    @legitFigures = { ro: Rook.new }
  end

  def display
    @squares.each do |line|
      line.each do |square|
      	if square != '--' then print square.red
      	else print square
      	end
      	print ' '
      end
      puts
    end
  end

  def putFigure(figureName, x, y, player)
    if (@squares[x][y] == '--' && @legitFigures[figureName.to_sym])
      @squares[x][y] = figureName
    end
  end

  def peek
  	@squares.each { |line| puts line.object_id }
  end
end

hash1 = { ro: Rook }

p hash1['ro'.to_sym]
p hash1.key(Rook)

table = Table.new

rook = Rook.new(5, 5, 1)

table.putFigure('ro', 5, 5, 1)

table.display
include StraightMoves

tableOfRange = Table.new
moveSouth(rook, 3, tableOfRange, table)
moveNorth(rook, 3, tableOfRange, table)
moveEast(rook,  3, tableOfRange, table)
moveWest(rook,  3, tableOfRange, table)
puts 
tableOfRange.display
puts
table.display

/ test TO DO

legit figure
legit coord

/