require 'colorize'
load 'StraightMoves.rb' # it's a module
load 'DiagonalMoves.rb' # it's a module
load 'Figures.rb'
load 'Table.rb'
load 'Player.rb'

include StraightMoves
include DiagonalMoves

def move(table, attacker, defender, x, y, dx, dy) # Table, Player, Player, FixNum, FixNum, FixNum, FixNum
  if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id
  
    if table[x][y].table_of_range[dx][dy] == '++'
      to_be_changed = attacker.figures.find { |figure| figure != nil && figure.x == x && figure.y == y }
      to_be_changed.x = dx
      to_be_changed.y = dy

      table[dx][dy] = to_be_changed
      table[x][y] = '--'

    elsif table[x][y].table_of_range[dx][dy] == '00'
      puts 'Can\'t move there, friendly in the way!'
    elsif table[x][y].table_of_range[dx][dy] == 'xx'
      puts 'Enemy killed!'
      table[dx][dy].x = 0
    else 
      puts 'You can\'t move there'
    end

  table = Table.new

  table.put_figures(attacker.figures)
  table.put_figures(defender.figures)
  
  attacker.generate_table_of_range(table)
  defender.generate_table_of_range(table)

  else puts 'You don\'t have a figure there, try again'
  end
end

table = Table.new
player1 = Player.new(1)
player2 = Player.new(2)


player1.add_figure(pawn1 = Pawn.new(2, 1))
player1.add_figure(pawn2 = Pawn.new(2, 2))
player1.add_figure(pawn3 = Pawn.new(2, 3))
player1.add_figure(pawn4 = Pawn.new(2, 4))
player1.add_figure(pawn5 = Pawn.new(2, 5))
player1.add_figure(pawn6 = Pawn.new(2, 6))
player1.add_figure(pawn7 = Pawn.new(2, 7))
player1.add_figure(pawn8 = Pawn.new(2, 8))
player1.add_figure(rook1 = Rook.new(1, 1))

player2.add_figure(queen1 = King.new(1, 8))

#player2.add_figure(pawn21 = Pawn.new(3, 1))
#player2.add_figure(pawn22 = Pawn.new(3, 2))
#player2.add_figure(pawn23 = Pawn.new(3, 3))
#player2.add_figure(pawn24 = Pawn.new(3, 4))
#player2.add_figure(pawn25 = Pawn.new(3, 5))
#player2.add_figure(pawn26 = Pawn.new(3, 6))
#player2.add_figure(pawn27 = Pawn.new(3, 7))
#player2.add_figure(pawn28 = Pawn.new(3, 8))

table.put_figures(player1.figures)
table.put_figures(player2.figures)

player1.generate_table_of_range(table)
player2.generate_table_of_range(table)

table.display

x = 1
y = 8

dx = 1
dy = 2

move(table, player2, player1, x, y, dx, dy)
puts
player1.table_of_range.display
puts

player2.table_of_range.display
puts

table.display

/ test TO DO

legit figure name
legit coord

/
