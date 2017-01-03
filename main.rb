require 'colorize'
load 'StraightMoves.rb' # it's a module
load 'Figures.rb'
load 'Table.rb'
load 'Player.rb'


table = Table.new
table.format_table

rook = Rook.new(5, 5, 1)
rook3 = Rook.new(5, 3, 1)
rook2 = Rook.new(7, 5, 2)
rook4 = Rook.new(3, 5, 1)
bishop = Bishop.new(5, 7, 1)

table.put_figure(rook)
table.put_figure(bishop)
table.put_figure(rook2)
table.put_figure(rook3)
table.put_figure(rook4)



include StraightMoves

straight_moves(rook, table)

rook.table_of_range.display
puts
straight_moves(rook4, table)
rook4.table_of_range.display
puts
table.display

/ test TO DO

legit figure name
legit coord

/
