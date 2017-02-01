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

    if table[dx][dy].class == Pawn && table[dx][dy].x == 4 + 4 * table[dx][dy].direction
      puts 'Pawn has reached the end! What do you want to replace it with? The options are:'
      puts "Rook => 'ro', Bishop => 'bi', Queen => 'qu', Knight => 'kn'"
      newFig = gets.chomp
      puts table[dx][dy].class
      attacker.figures.delete(table[dx][dy])
      puts table[dx][dy].class
      nuFig = LEGIT_RESTORATION_FIGURES.key(newFig).new(dx, dy)
      attacker.add_figure(nuFig)
      table[dx][dy] = nuFig
      puts table[dx][dy].class
    end

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

    table[dx][dy].set_moves(table)

    defender.table_of_range[holderX][holderY] = '!!' if holderX != 0

    defender.figures.each do |figure|
      if figure.class == Pawn && figure.x + figure.direction == holderX && ((figure.y - holderY).abs == 1)
        figure.table_of_range[holderX][holderY] = '!!'
      end
    end

    table.display

    return 0

  else
    return 1
  end
end

def inspectFigure(table, attacker, x, y)
  if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id
    puts table[x][y].class
    table[x][y].table_of_range.display
  else
    puts "This isn\'t player #{ attacker.id }\'s figure! Try again"
  end
end

def displayTable(table)
  table.display
end
