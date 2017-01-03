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


player2.add_figure(rook1 = Rook.new(4, 5, 2))
player1.add_figure(knight1 = King.new(5, 5, 1))
player2.add_figure(rook3 = Rook.new(4, 6, 2))
player2.add_figure(bishop1 = Bishop.new(6, 5, 2))

player1.add_figure(queen1 = Bishop.new(5, 4, 1))

table.put_figures(player1.figures)
table.put_figures(player2.figures)

table.display
puts

player1.generate_table_of_range(table)
player1.table_of_range.display
puts
# table.display

/ test TO DO

legit figure name
legit coord

/
