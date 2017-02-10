#require './StraightMoves.rb' # it's a module
#require './DiagonalMoves.rb' # it's a module
#require './Figures.rb'
#require './Table.rb'
#require './Player.rb'
require './FunctionFile.rb'
require 'colorize'

include StraightMoves
include DiagonalMoves

def turn(gameName, table, attacker, defender)
  while(true) do
    puts "Player #{attacker.id} turn. Choose command: move, inspect, display, castle, save, undo, surrender"
    command = gets.chomp

    case command
    when 'move'
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
        # validation of coordinates for 'move' above
      end
      result = move(table, attacker, defender, x, y, dx, dy)
      puts result
      if result == 2
        # puts "I'M TRYING TO LOAD FILE №#{@autosaveID}"
        loadGame(@gameName, (@autosaveID - 1).to_s, table, defender, attacker)
        table.display
        next
      else
        if result == 1
          puts 'You don\'t have a figure there, try again'
          next
        else
          puts
          attacker.table_of_range.display
          puts
          defender.table_of_range.display
          puts

          puts
          @autosaveID = autosave(gameName, attacker, defender, @autosaveID)

          puts 'Watch out, you\'re under chess!' if result == -1

          if canMoveWithoutEndingInCheck(@gameName, table, defender, attacker) == 0

            if result == -1
              puts 'CHECKMATE'
              return 1
            else
              return 0
            end
          end

          table = Table.new()

          table.put_figures(attacker.figures)
          table.put_figures(defender.figures)

          table.display
        end
      end
      break
    when 'inspect'
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
    when 'display'
      displayTable(table)
      next
    when 'castle'
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
    when 'save'
      puts 'Input Game Name'
      saveName = gets.chomp
      manualSave(gameName, saveName, attacker, defender)
      next
    when 'undo'
      puts "loading #{@autosaveID - 2}"
       if loadGame(gameName, (@autosaveID - 2).to_s, table, defender, attacker) != 0
         @autosaveID -= 1
         table.display
         break
       end
    when 'surrender'
      return 2
    else
       puts 'Unrecognized command! Try again.'
    end
  end
end

table = Table.new
player1 = Player.new(1, 1, 4)
player2 = Player.new(2, 8, 4)
currentPlayer = 1

table.display
puts
puts 'Hello to Itso\'s chess'
while(true) do
  @autosaveID = 1
  puts 'Choose your gamemode: Standard game(st) or Load game(load). You can exit by "exit".'
  gameType = gets.chomp
  # gameType = 'load'

  case gameType
  when 'st'
    puts 'please give the game a name, this affects the folder in which it gets saved'
    @gameName = gets.chomp
    standardGame(table, player1, player2)
  when 'load'
    puts 'please input the game(folder) name for loading'
    @gameName = gets.chomp
    # gameName = 'custom game'
    puts 'please input save(file) name for loading( do not include \'.txt\')'
    saveName = gets.chomp
    currentPlayer = loadGame(@gameName, saveName, table, player1, player2)
    next if currentPlayer == 0
  when 'exit'
    puts 'Bye! I already miss you :\'{'
    break
  else
    puts 'Looks like you didnt input a correct type of a game. Try "st" or "load"'
    next
  end
  while(true)
    player1.table_of_range.display
    player2.table_of_range.display
    table.display
    if currentPlayer == 2
      currentPlayer = 1
    else
      result = turn(@gameName, table, player1, player2)
      case result
      when 0
        puts "DRAW!"
        break
      when 1
        puts "PLAYER 1 WINS"
        break
      when 2
        puts "PLAYER 1 SURRENDERS! PLAYER 2 WINS!"
        break
      end

      if isGameOver(table, player1, player2) == 1
        puts "Player 1 Wins!"
        break
      end
    end

    result = turn(@gameName, table, player2, player1)
      case result
      when 0
        puts "DRAW!"
        break
      when 1
        puts "PLAYER 2 WINS"
        break
      when 2
        puts "PLAYER 2 SURRENDERS! PLAYER 1 WINS!"
        break
      end
    if isGameOver(table, player2, player1) == 1
        puts "Player 2 Wins!"
        break
      end
  end
end
