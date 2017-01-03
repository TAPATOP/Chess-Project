require 'colorize'
load 'StraightMoves.rb' # it's a module
load 'DiagonalMoves.rb' # it's a module
load 'Figures.rb'
load 'Table.rb'
load 'Player.rb'


include StraightMoves
include DiagonalMoves

table = Table.new
player1 = Player.new
player2 = Player.new


rook1 = Rook.new(4, 5, 2)
rook2 = Rook.new(5, 5, 2)
rook3 = Rook.new(4, 6, 2)
bishop1 = Bishop.new(6, 5, 2)
queen1 = Queen.new(5, 6, 1)

player2.add_figure(rook1)
player2.add_figure(rook2)
player2.add_figure(rook3)
player2.add_figure(bishop1)

player1.add_figure(queen1)

table.put_figure(rook1)
table.put_figure(rook2)
table.put_figure(rook3)
table.put_figure(bishop1)

table.put_figure(queen1)

table.display
puts

player2.generate_table_of_range(table)
player2.table_of_range.display
puts
# table.display

/ test TO DO

legit figure name
legit coord

/
