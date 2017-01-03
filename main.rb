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


#player1.add_figure(pawn1 = Pawn.new(2, 1, 1))
player1.add_figure(pawn2 = Pawn.new(2, 2, 1))
#player1.add_figure(pawn3 = Pawn.new(2, 3, 1))
player2.add_figure(rook1 = Rook.new(3, 2, 1))

table.put_figures(player1.figures)
table.put_figures(player2.figures)

table.display
puts

player1.generate_table_of_range(table)
player1.table_of_range.display
puts
table.display

/ test TO DO

legit figure name
legit coord

/
