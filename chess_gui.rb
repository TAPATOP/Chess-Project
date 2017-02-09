require './FunctionFile.rb'

def drawBoard
  @arrayofImages.each { |elem| if elem.left then elem.remove end}
  @table.squares.each_index do |i|
    @table.squares[i].each_index do |j|
      if LEGIT_FIGURES[@table[i][j].class] != nil
        someFigure = image("#{@table[i][j].image}")
        someFigure.left = @board[i -1 ][j - 1].left
        someFigure.top = @board[i - 1][j - 1].top
        someFigure.height = @widthVal
        someFigure.width = @widthVal
        @arrayofImages.push(someFigure)
      end
    end
  end
end

def getBoardSquareCoordsByCoords(left, top)
  @board.each_index do |i|
    @board[i].each_index do |j|
    if @board[i][j].left  - left <= 0 && @board[i][j].top - top <= 0 &&
      top <= 8 * @widthVal + @topPadding && left <= 8 * @widthVal + @leftPadding &&
      left - @board[i][j].left <= @widthVal && top - @board[i][j].top <= @widthVal

      return [i, j]
      end
    end
  end
end

def colorBoard
  @board.each_index do |i|
    @board[i].each_index do |j|
      if (i + j) % 2 == 1
        @board[i][j].fill = white
      else
        @board[i][j].fill = black
      end
    end
  end
end

@title = 'Itso\'s Almost Working Chess'

Shoes.app(width: 800, height: 800, title: @title) do
  HASH_OF_COLORS = { 0 => white, 1 => black }
  HASH_OF_COLORS2 = { 0 => black, 1 => white }
  @board = Array.new(8) { Array.new(8) }
  @arrayofImages = Array.new

  @table = Table.new
  @player1 = Player.new(1, 4, 1)
  @player2 = Player.new(2, 4, 8)
  @currentPlayer = 0
  @autosaveID = 1

  @attacker
  @defender

  @leftPadding = 200
  @topPadding = 150
  @widthVal = 50

  leftVal = @leftPadding
  topVal = @topPadding

  stack do
    flow do
      @gameNameDefiningField = edit_line
      @gameName = para 'game name goes here'
    end
    flow do
      @saveNameDefiningField = edit_line
      @saveName = para 'save name goes here'
    end

    flow do
      @manualSaveButton = button 'Save'
      @manualSaveButton.click do
        if @saveNameDefiningField.text != "" && @gameNameDefiningField != ""
          @saveName.replace 'SAVED!'
          manualSave(@gameName.text, @saveNameDefiningField.text, @attacker, @defender)
        else
          @saveName.replace 'Fields not properly filled'
          popup = window(width: 200, height: 200) do
            stack do
              style(:margin_left => '50%', :left => '-25%', :align => 'center')
              para 'please insert a game name'
              ok = button 'OK'
              ok.click do
                popup.close
              end
            end
          end
        end
      end
      @loadButton = button 'Load'
      @loadButton.click do
        if @saveNameDefiningField.text != "" && @gameNameDefiningField != ""
          @gameName.replace @gameNameDefiningField.text
          @currentPlayer = loadGame(@gameName.text, @saveNameDefiningField.text, @table, @player1, @player2)
          @saveName.replace 'LOADED!'
          drawBoard
        else
          @saveName.replace 'Fields not properly filled'
          popup = window(width: 200, height: 200) do
            stack do
              style(:margin_left => '50%', :left => '-25%', :align => 'center')
              para 'please insert a game name'
              ok = button 'OK'
              ok.click do
                popup.close
              end
            end
          end
        end
      end
      @undoButton = button 'Undo'
      @undoButton.click do
        puts "reloading turn #{@autosaveID}"
        @currentPlayer = loadGame(@gameName.text, (@autosaveID - 2).to_s, @table, @player1, @player2)
        @autosaveID -= 1
        drawBoard
      end
    end
  end

  flow do
    @standardGameButton = button "Standard Game plz"
    @customGameButton = button "Custom shet"
    @drawGameButton = button "Draw me plox"
  end

  stack do
    @queenCastlingButton = button "Queen- Side Castling"
    @kingCastlingButton = button "King- Side Castling"
  end

  @queenCastlingButton.click do
    if @currentPlayer == 0
      if queenCastling(@table, @player1, @player2) != 1 then @currentPlayer = (@currentPlayer + 1) % 2 end
    else
      if queenCastling(@table, @player2, @player1) != 1 then @currentPlayer = (@currentPlayer + 1) % 2 end
    end
    drawBoard
  end

  @kingCastlingButton.click do
    if @currentPlayer == 0
      if kingCastling(@table, @player1, @player2) != 1 then @currentPlayer = (@currentPlayer + 1) % 2 end
    else
      if kingCastling(@table, @player2, @player1) != 1 then @currentPlayer = (@currentPlayer + 1) % 2 end
    end
    puts @currentPlayer
    drawBoard
  end

  @arrayofImages = Array.new

  @standardGameButton.click do
    standardGame(@table, @player1, @player2)
  end

  @customGameButton.click do
    customGame(@table, @player1, @player2)
  end

  stack() do
    @box = para "i j"
    @box2 = para "i j"
    @box3 = para "i j"
  end

  color = 0
  @board.each_index do |i|
    @board[i].each_index do |j|
      @board[i][j] = rect(left: leftVal, top: topVal, width: @widthVal)
      leftVal += @widthVal
      @board[i][j].fill = HASH_OF_COLORS[(color += 1) % 2]
    end
    color = (color + 1) % 2
    topVal += @widthVal
    leftVal = @leftPadding
  end

  @drawGameButton.click do
    @currentPlayer = 0 # this should be relocated

    if @gameNameDefiningField.text != ""
      @autosaveID = 1
      @gameName.replace @gameNameDefiningField.text
      drawBoard
    else
      popup = window(width: 200, height: 200) do
        stack do
          style(:margin_left => '50%', :left => '-25%', :align => "center")
          para "please insert a game name"
          ok = button "OK"
          ok.click do
            popup.close
          end
        end
      end
      @gameName.replace "please insert a game name"
    end
  end

  @shape = star(points: 5, outer: 20, inner: 10)

    motion do |left, top|
    @shape.move left, top
    @shape.fill = HASH_OF_COLORS[@currentPlayer]
    @shape.stroke = HASH_OF_COLORS2[@currentPlayer]
  end

  firstPosLeft, firstPosTop = 0, 0
  secondPosLeft, secondPosLeftndPosTop = 0, 0

  click do |button, left, top|
    i, j = getBoardSquareCoordsByCoords(left, top)
    @box.replace "#{i + 1}, #{j + 1}"
    if LEGIT_FIGURES[@table[i+1][j+1].class] != nil
      puts @table[i + 1][j + 1].x
      puts @table[i + 1][j + 1].y
      puts @table[i + 1][j + 1].has_moved
      @table[i + 1][j + 1].table_of_range.display
    end
    if firstPosLeft == 0
      firstPosLeft = i + 1
      firstPosTop = j + 1
      @box2.replace "#{firstPosLeft}, #{firstPosTop}"
      @board[i][j].fill = gold
      @table[i + 1][j + 1].table_of_range.squares.each_index do |m|
        @table[i + 1][j + 1].table_of_range.squares[m].each_index do |n|
          case @table[i + 1][j + 1].table_of_range[m][n]
            when '++'
              @board[m - 1][n - 1].fill = green
            when 'xx'
              @board[m - 1][n - 1].fill = red
            when '00'
              @board[m - 1][n - 1].fill = blue
            when '!!'
              @board[m - 1][n - 1].fill = purple
          end
        end
      end
    else
      colorBoard

      secondPosLeft = i + 1
      secondPosTop = j + 1
      @box2.replace "#{firstPosLeft}, #{firstPosTop}"
      @box3.replace "#{secondPosLeft}, #{secondPosTop}"

      if @currentPlayer % 2 == 0
        @attacker = @player1
        @defender = @player2
      else
        @attacker = @player2
        @defender = @player1
      end

      result = 0
      result = move(@table, @attacker, @defender, firstPosLeft, firstPosTop, secondPosLeft, secondPosTop, 'qu')

      if (firstPosLeft + firstPosTop) % 2 == 1
        @board[firstPosLeft - 1][firstPosTop - 1].fill = white
      else
        @board[firstPosLeft - 1][firstPosTop - 1].fill = black
      end
      firstPosLeft = 0
      firstPosTop = 0

      if result == 2
        loadGame(@gameName, (@autosaveID - 1).to_s, @table, @defender, @attacker)

        popup = window(width: 200, height: 200) do
          para "If you do that your king will be in check"
        end
      end

      if result == 0 || result == -1
        @currentPlayer = (@currentPlayer + 1) % 2
        @autosaveID = autosave(@gameName.text, @attacker, @defender, @autosaveID)
      end

      if result == -1
        popup = window(width: 200, height: 200) do
          boxx = para "YOU'RE UNDER CHECK"
        end
      end

      result2 = 0

      @defender.figures.each do |fig|
        if fig == @defender.king
          result2 = 1
          break
        end
      end

      if result2 == 0
        @box.replace "PLAYER #{@attacker.id} WINS!"
        @box2.replace "PLAYER #{@attacker.id} WINS!"
        @box3.replace "PLAYER #{@attacker.id} WINS!"
      end

      drawBoard
    end
  end
end
#@box.replace @board
=begin
  @whiteRook = image("./Images/WhiteRook.png")
  @whiteRook.height = 40
  @whiteRook.width = 40
  @whiteKnight = image("./Images/WhiteKnight.png")
  @whiteKnight.height = 40
  @whiteKnight.width = 40
  @whiteBishop = image("./Images/WhiteBishop.png")
  @whiteBishop.height = 40
  @whiteBishop.width = 40
  @whiteQueen = image("./Images/WhiteQueen.png")
  @whiteQueen.height = 40
  @whiteQueen.width = 40
  @whiteKing= image("./Images/WhiteKing.png")
  @whiteKing.height = 40
  @whiteKing.width = 40
  @whitePawn = image("./Images/WhitePawn.png")
  @whitePawn.height = 40
  @whitePawn.width = 40

  @blackRook = image("./Images/BlackRook.png")
  @blackRook.height = 40
  @blackRook.width = 40
  @blackKnight = image("./Images/BlackKnight.png")
  @blackKnight.height = 40
  @blackKnight.width = 40
  @blackBishop = image("./Images/BlackBishop.png")
  @blackBishop.height = 40
  @blackBishop.width = 40
  @blackQueen = image("./Images/BlackQueen.png")
  @blackQueen.height = 40
  @blackQueen.width = 40
  @blackKing= image("./Images/BlackKing.png")
  @blackKing.height = 40
  @blackKing.width = 40
  @blackPawn = image("./Images/BlackPawn.png")
  @blackPawn.height = 40
  @blackPawn.width = 40
=end
