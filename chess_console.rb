require './StraightMoves.rb' # it's a module
require './DiagonalMoves.rb' # it's a module
require './Figures.rb'
require './Table.rb'
require './Player.rb'
require './FunctionFile.rb'
require 'colorize'

include StraightMoves
include DiagonalMoves

def turn(table, attacker, defender)
  while(true) do
    puts "Player #{attacker.id} turn. Choose command: move, inspect, display, castle"
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

        table = Table.new()

        table.put_figures(attacker.figures)
        table.put_figures(defender.figures)

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
          if command == 'castle'
            puts "Queenside castle or Kingside castle? 'qu' => Queenside, 'ki' => Kingside"
            castleCommand = gets.chomp
            if castleCommand == 'qu'
              if queenCastling(table, attacker, defender) == 1 then next
              else
                break
              end
            else
              if castleCommand == 'ki'
                if kingCastling(table, attacker, defender) == 1 then next
                else
                  break
                end
              else
                puts 'Error, try again.'
                next
              end
            end
          else
            puts 'Unrecognized command! Try again.'
            next
          end
        end
      end
    end
  end
end

table = Table.new
player1 = Player.new(1, 1, 4)
player2 = Player.new(2, 8, 4)

standardGame(table, player1, player2)

table.display

while(true) do
  turn(table, player1, player2)
  turn(table, player2, player1)
end
