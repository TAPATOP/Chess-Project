require './StraightMoves.rb' # it's a module
require './DiagonalMoves.rb' # it's a module
require './Figures.rb'
require './Table.rb'
require './Player.rb'

include StraightMoves
include DiagonalMoves

def move(table, attacker, defender, x, y, dx, dy, newFig = 0) # Table, Player, Player, FixNum, FixNum, FixNum, FixNum
  if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id

    if table[x][y].move(dx, dy, defender, table) == 1 then return 1 end

    if table[dx][dy].class == Pawn && (table[dx][dy].x + table[dx][dy].direction > 8 || table[dx][dy].x + table[dx][dy].direction < 1)
      puts 'Pawn has reached the end! What do you want to replace it with? The options are:'
      attacker.figures.delete(table[dx][dy])
      while(true)
        puts "Rook => 'ro', Bishop => 'bi', Queen => 'qu', Knight => 'kn'" # reason for doublequotes is that i'm too lazy to escape all the singlequotes

        if newFig == 0 then newFig = gets.chomp end

        if LEGIT_RESTORATION_FIGURES.key(newFig) != nil # I have serious questions about this entire shit
          nuFig = LEGIT_RESTORATION_FIGURES.key(newFig).new(dx, dy)
          attacker.add_figure(nuFig)
          table[dx][dy] = nuFig
          break # aka breack;
        else
          puts 'Wrong input, try again, buddy'
        end
      end
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
    # autosave(gameName, attacker, defender)
    return 0
  else
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

def queenCastling(table, attacker, defender)
  kingX = attacker.king.x
  if table[kingX][8].class == Rook &&
    attacker.king.has_moved == 0 &&
    table[kingX][8].has_moved == 0 &&
    defender.table_of_range[kingX][4] == '--' &&
    defender.table_of_range[kingX][5] == '--' &&
    defender.table_of_range[kingX][6] == '--' &&
    table[kingX][5] == '--' &&
    table[kingX][6] == '--' &&
    table[kingX][7] == '--' &&
    (table[kingX + attacker.direction][8].class != Pawn || table[kingX + attacker.direction][8].direction == attacker.direction) &&
    (table[kingX + attacker.direction][4].class != Pawn || table[kingX + attacker.direction][4].direction == attacker.direction)


    move(table, attacker, defender, kingX, 8, kingX, 5)

    attacker.king.table_of_range[kingX][6] = '++'
    move(table, attacker, defender, kingX, 4, kingX, 6)

  else
    puts 'You can\'t castle queen- side'
    return 1
  end
end

def kingCastling(table, attacker, defender)
  kingX = attacker.king.x
  if table[kingX][1].class == Rook &&
    attacker.king.has_moved == 0 &&
    table[kingX][1].has_moved == 0 &&
    defender.table_of_range[kingX][4] == '--' &&
    defender.table_of_range[kingX][3] == '--' &&
    defender.table_of_range[kingX][2] == '--' &&
    table[kingX][3] == '--' &&
    table[kingX][2] == '--' &&
    (table[kingX + attacker.direction][1].class != Pawn || table[kingX + attacker.direction][1].direction == attacker.direction) &&
    (table[kingX + attacker.direction][4].class != Pawn || table[kingX + attacker.direction][4].direction == attacker.direction)

    move(table, attacker, defender, kingX, 1, kingX, 3)

    attacker.king.table_of_range[kingX][2] = '++'
    move(table, attacker, defender, kingX, 4, kingX, 2)
  else
    puts 'You can\'t castle king- side'
    return 1
  end
end

def customGame (table, player1, player2)
  player1.king.x = 1
  player1.king.y = 4
  player2.king.x = 8
  player2.king.y = 4

  player1.add_figure(pawn1 = Pawn.new(7, 1))
  pawn1.has_moved = 1
  player1.add_figure(pawn2 = Pawn.new(2, 2))
  player1.add_figure(pawn3 = Pawn.new(2, 3))
  player1.add_figure(bishop1 = Bishop.new(2, 4))
  player1.add_figure(pawn6 = Pawn.new(2, 6))
  player1.add_figure(pawn7 = Pawn.new(2, 7))
  player1.add_figure(pawn8 = Pawn.new(2, 8))
  player1.add_figure(rook1 = Rook.new(1, 1))
  player1.add_figure(rook2 = Rook.new(1, 8))
  #player1.add_figure(queen1 = Queen.new(1, 5))

  player2.add_figure(pawn21 = Pawn.new(4, 1))
  player2.add_figure(pawn22 = Pawn.new(7, 2))
  player2.add_figure(pawn23 = Pawn.new(7, 3))
  player2.add_figure(pawn24 = Pawn.new(7, 4))
  player2.add_figure(pawn25 = Pawn.new(2, 5))
  player2.add_figure(pawn26 = Pawn.new(3, 6))
  player2.add_figure(pawn27 = Pawn.new(7, 7))
  player2.add_figure(pawn28 = Pawn.new(3, 8))
  player2.add_figure(rook21 = Rook.new(4, 6))
  player2.add_figure(knight21 = Knight.new(5, 4))
  player2.add_figure(rook1 = Rook.new(8, 2))
  player2.add_figure(rook2 = Rook.new(8, 8))

  table.put_figures(player1.figures)
  table.put_figures(player2.figures)

  player1.generate_table_of_range(table)
  player2.generate_table_of_range(table)
end

def standardGame (table, player1, player2)
  player1.king.x = 1
  player1.king.y = 4
  player2.king.x = 8
  player2.king.y = 4

  player1.add_figure(Pawn.new(2, 1))
  player1.add_figure(Pawn.new(2, 2))
  player1.add_figure(Pawn.new(2, 3))
  player1.add_figure(Pawn.new(2, 4))
  player1.add_figure(Pawn.new(2, 5))
  player1.add_figure(Pawn.new(2, 6))
  player1.add_figure(Pawn.new(2, 7))
  player1.add_figure(Pawn.new(2, 8))
  player1.add_figure(Rook.new(1, 1))
  player1.add_figure(Rook.new(1, 8))
  player1.add_figure(Knight.new(1, 2))
  player1.add_figure(Knight.new(1, 7))
  player1.add_figure(Bishop.new(1, 3))
  player1.add_figure(Bishop.new(1, 6))
  player1.add_figure(Queen.new(1, 5))

  player2.add_figure(Pawn.new(7, 1))
  player2.add_figure(Pawn.new(7, 2))
  player2.add_figure(Pawn.new(7, 3))
  player2.add_figure(Pawn.new(7, 4))
  player2.add_figure(Pawn.new(7, 5))
  player2.add_figure(Pawn.new(7, 6))
  player2.add_figure(Pawn.new(7, 7))
  player2.add_figure(Pawn.new(7, 8))
  player2.add_figure(Rook.new(8, 1))
  player2.add_figure(Rook.new(8, 8))
  player2.add_figure(Knight.new(8, 2))
  player2.add_figure(Knight.new(8, 7))
  player2.add_figure(Bishop.new(8, 3))
  player2.add_figure(Bishop.new(8, 6))
  player2.add_figure(Queen.new(8, 5))

  table.put_figures(player1.figures)
  table.put_figures(player2.figures)

  player1.generate_table_of_range(table)
  player2.generate_table_of_range(table)
end

def manualSave(saveDir, saveName, attacker, defender)
  directory_name = "Games"

  Dir.mkdir(directory_name) unless File.exists?(directory_name)
  directory_name += '/' + saveDir.to_s
  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  final_destination = directory_name + '/' + saveName + '.txt'

  dataToBeSaved = String.new("")

  dataToBeSaved = savingFunct(dataToBeSaved, attacker)
  dataToBeSaved += "next \n"
  dataToBeSaved = savingFunct(dataToBeSaved, defender)
  dataToBeSaved += "end \n"

  File.open(final_destination, 'w') { |f| f.write(dataToBeSaved) }

  #IO.write(final_destination, 'hi')
  # File.open("out.txt", '<OPTION>') {|f| f.write("write your stuff here") }
end

def savingFunct(dataToBeSaved, player)
  dataToBeSaved += "Player #{player.id} \n"

  player.figures.each do |fig|
    dataToBeSaved += "#{fig.class} #{fig.x} #{fig.y} #{fig.has_moved} \n" if fig.class != NilClass
  end

  holderX = 0
  holderY = 0

  player.table_of_range.squares.each_index do |i|
    player.table_of_range.squares[i].each_index do |j|
      if player.table_of_range[i][j].class != NilClass && player.table_of_range[i][j] == '!!'
        holderY = j
        holderX = i
        break
      end
    end
  end

  if holderX != 0 then dataToBeSaved += "enpas #{holderX} #{holderY} \n" end

  dataToBeSaved
end

def autosave(gameName, attacker, defender, autosaveID)
  manualSave(gameName, autosaveID.to_s, attacker, defender)
  autosaveID += 1
end

def loadGame(gameName, saveName, table, player1, player2) # keep in mind this function returns the next player turn
  something = String.new
  input = File.new("./Games/#{gameName}/#{saveName}.txt")
  currPlayer = 0

  player1.figures = Array.new
  player1.add_figure(player1.king)

  player2.figures = Array.new
  player2.add_figure(player2.king)

  table.squares.each_index do |i|
    table.squares[i].each_index do |j|
      table.squares[i] = Array.new(9,'--')
    end
  end

  while something = input.gets do
    if something.include?('Player')
      if something[7].to_i == 1
        readingPart(player1, input)
      else
        readingPart(player2, input)
      end
      currPlayer  = something[7].to_i if currPlayer  == 0
    end
  end
  table.put_figures(player1.figures)
  table.put_figures(player2.figures)

  player1.generate_table_of_range(table)
  player2.generate_table_of_range(table)

  currPlayer
end

def readingPart(player, input)
  while something = input.gets do
    clas, x, y, has_moved = something.split(' ')

    if LEGIT_STRING_FIGURES[clas] != nil
      if LEGIT_STRING_FIGURES[clas] == King
        player.king.x = x.to_i
        player.king.y = y.to_i
        player.king.has_moved = has_moved
      else
        newFig = LEGIT_STRING_FIGURES[clas].new(x.to_i, y.to_i)
        newFig.has_moved = has_moved.to_i
        player.add_figure(newFig)
      end
    else
      if clas == 'end' || clas == 'next'
        puts "enough is enough"
        break
      else
        if clas == 'enpas'
          player.table_of_range[x.to_i][y.to_i] = '!!'
        end
      end
    end
  end
end
