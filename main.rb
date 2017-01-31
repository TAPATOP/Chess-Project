require './StraightMoves.rb' # it's a module
require './DiagonalMoves.rb' # it's a module
require './Figures.rb'
require './Table.rb'
require './Player.rb'
require './FunctionFile.rb'

include StraightMoves
include DiagonalMoves

def turn(table, attacker, defender)
  while(true) do
    puts "Player #{attacker.id} turn. Choose command: move, inspect, display"
    command = gets.chomp

    if command == 'move'
      while(true) do
        puts 'X:'
        x = gets.chomp.to_i
        if x < 1 || x > 8
          puts 'invalid coordinates, try again'
          next
        end
        puts 'Y:'
        y = gets.chomp.to_i
        if y < 1 || y > 8
          puts 'invalid coordinates, try again'
          next
        end

        puts 'DX:'
        dx = gets.chomp.to_i
        if dx < 1 || dx > 8
          puts 'invalid coordinates, try again'
          next
        end

        puts 'DY:'
        dy = gets.chomp.to_i
        if dy < 1 || dy > 8
          puts 'invalid coordinates, try again'
          next
        end
        break
      end
      # validation of coordinates for 'move' above

      if move(table, attacker, defender, x, y, dx, dy) == 1
        puts 'You don\'t have a figure there, try again'
        next
      else
        puts
        attacker.table_of_range.display
        puts
        defender.table_of_range.display
        puts
        table.display
      end
      break
    else
      if command == 'inspect'
        puts 'X:'
        x = gets.chomp.to_i
        if x < 1 || x > 8
          puts 'Invalid coordinates, try again'
          next
        end

        puts 'Y:'
        y = gets.chomp.to_i
        if y < 1 || y > 8
          puts 'Invalid coordinates, try again'
          next
        end
        # coords validification

       inspectFigure(table, attacker, x, y)
      next

      else
        if command == 'display'
          displayTable(table)
          next
        else
          puts 'Unrecognized command! Try again.'
          next
        end
      end
    end
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
player1.add_figure(rook2 = Rook.new(1, 8))
player1.add_figure(queen1 = Queen.new(1, 4))

player2.add_figure(pawn21 = Pawn.new(4, 1))
player2.add_figure(pawn22 = Pawn.new(7, 2))
player2.add_figure(pawn23 = Pawn.new(7, 3))
player2.add_figure(pawn24 = Pawn.new(7, 4))
player2.add_figure(pawn25 = Pawn.new(7, 5))
player2.add_figure(pawn26 = Pawn.new(3, 6))
player2.add_figure(pawn27 = Pawn.new(7, 7))
player2.add_figure(pawn28 = Pawn.new(3, 8))

table.put_figures(player1.figures)
table.put_figures(player2.figures)

player1.generate_table_of_range(table)
player2.generate_table_of_range(table)

table.display

while(true) do
  turn(table, player1, player2)
  turn(table, player2, player1)
end
/ test TO DO

legit figure name
legit coord

/
