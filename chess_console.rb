require './StraightMoves.rb' # it's a module
require './DiagonalMoves.rb' # it's a module
require './Figures.rb'
require './Table.rb'
require './Player.rb'
require './FunctionFile.rb'
require 'colorize'

include StraightMoves
include DiagonalMoves

def turn(gameName, table, attacker, defender)
  while(true) do
    puts "Player #{attacker.id} turn. Choose command: move, inspect, display, castle, save"
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
        @autosaveID = autosave(gameName, attacker, defender, @autosaveID)
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
            if command == 'save'
              puts 'Input Game Name'
              saveName = gets.chomp
              manualSave(gameName, saveName, attacker, defender)
              next
            else
              puts 'Unrecognized command! Try again.'
            end
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
currentPlayer = 1

table.display
puts
puts 'helo dis is ebin chezz'
while(true) do
  @autosaveID = 0
  puts 'chus: Standard game(st), Custom game(cu) or Load game(load)'
  gameType = gets.chomp
  # gameType = 'load'

  case gameType
  when 'st'
    puts 'pls gib the game a name so u can undo'
    gameName = gets.chomp
    standardGame(table, player1, player2)
  when 'cu'
    puts 'pls gib the game a name so u can undo'
    gameName = gets.chomp
    customGame(table, player1, player2)
  when 'load'
    puts 'pls say game(folder) name for loading'
    gameName = gets.chomp
    # gameName = 'custom game'
    puts 'plas say save(file) name for loading( do not include \'.txt\')'
    saveName = gets.chomp
    saveName += '.txt'
    currentPlayer = loadGame(gameName, saveName, table, player1, player2, currentPlayer)
  else
    puts 'looks like you didnt input a correct type of a game'
    next
  end
  while(true)
    player1.table_of_range.display
    player2.table_of_range.display
    table.display
    if currentPlayer == 2
      currentPlayer = 1
    else
      turn(gameName, table, player1, player2)
    end
    turn(gameName, table, player2, player1)
  end
end
