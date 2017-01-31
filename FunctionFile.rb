require './StraightMoves.rb' # it's a module
require './DiagonalMoves.rb' # it's a module
require './Figures.rb'
require './Table.rb'
require './Player.rb'
require './FunctionFile.rb'

include StraightMoves
include DiagonalMoves

def move(table, attacker, defender, x, y, dx, dy) # Table, Player, Player, FixNum, FixNum, FixNum, FixNum
  if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id

    if table[x][y].move(dx, dy, defender, table) == 1 then return 1 end

    table = Table.new

    table.put_figures(attacker.figures)
    table.put_figures(defender.figures)

    attacker.generate_table_of_range(table)


    holderX, holderY = 0, 0

    defender.table_of_range.squares.each_index do |i|
      defender.table_of_range.squares[i].each_index do |j|
        if defender.table_of_range[i][j] == '!'
          holderX = i
          holderY = j
          break
        end
      end
    end

    defender.generate_table_of_range(table)

    defender.table_of_range[holderX][holderY] = '!!' if holderX != 0

    defender.figures.each do |figure|
      if figure.class == Pawn && figure.x + figure.direction == holderX && ((figure.y - holderY).abs == 1)
        figure.table_of_range[holderX][holderY] = '!!'
      end
    end

    puts

    attacker.table_of_range.display
    puts

    defender.table_of_range.display
    puts

    table.display

  else
    puts 'You don\'t have a figure there, try again'
    return 1
  end
end

def inspectFigure(table, attacker, x, y)
  if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id
    table[x][y].table_of_range.display
  else
    puts "This isn\'t player #{ attacker.id }\'s figure! Try again"
  end
end

def displayTable(table)
  table.display
end
