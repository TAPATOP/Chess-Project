require 'colorize'
load 'StraightMoves.rb' # it's a module
load 'DiagonalMoves.rb' # it's a module
load 'Figures.rb'
load 'Table.rb'
load 'Player.rb'


include StraightMoves
include DiagonalMoves

table = Table.new

bishop1 = Bishop.new(5, 5, 2)
rook1 = Rook.new(8, 8, 1)
rook2 = Rook.new(8, 5, 2)
rook3 = Rook.new(1, 1, 1)
bishop2 = Bishop.new(2, 8, 1)
rook4 = Rook.new(8, 1, 2)
queen1 = Queen.new(1, 2, 1)

table.put_figure(bishop2)
table.put_figure(bishop1)
table.put_figure(rook2)
table.put_figure(rook3)
table.put_figure(rook1)
table.put_figure(rook4)
table.put_figure(queen1)

table.display

puts

queen1.set_moves(table)
queen1.table_of_range.display

puts
# table.display

/ test TO DO

legit figure name
legit coord

/
