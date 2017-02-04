require './FunctionFile.rb'

def drawBoard
  @arrayofImages.each { |elem| if elem.left then elem.remove end}
  @arrayofImages = Array.new
  @table.squares.each_index do |i|
    @table.squares[i + 1].each_index do |j|
      if LEGIT_FIGURES[@table[i + 1][j + 1].class] != nil
        someFigure = image("#{@table[i + 1][j + 1].image}")
        someFigure.left = @board[i][j].left
        someFigure.top = @board[i][j].top
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

Shoes.app(width: 800, height: 800) do
  HASH_OF_COLORS = { 0 => white, 1 => black }
  HASH_OF_COLORS2 = { 0 => black, 1 => white }
  @board = Array.new(8) { Array.new(8) }

  @table = Table.new
  @player1 = Player.new(1, 4, 1)
  @player2 = Player.new(2, 4, 8)
  @currentPlayer = 0

  @leftPadding = 200
  @topPadding = 100
  @widthVal = 50

  leftVal = @leftPadding
  topVal = @topPadding

  @standardGameButton = button "Standard Game plz"
  @customGameButton = button "Custom shet"
  @drawGameButton = button "Draw me plox"
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
    puts @currentPlayer
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
    @table = Table.new
    @player1 = Player.new(1, 4, 1)
    @player2 = Player.new(2, 4, 8)
    standardGame(@table, @player1, @player2)
  end

  @customGameButton.click do
    @table = Table.new
    @player1 = Player.new(1, 4, 1)
    @player2 = Player.new(2, 4, 8)
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

  @shape = star(points: 5, outer: 20, inner: 10)

    motion do |left, top|
    @shape.move left, top
    @shape.fill = HASH_OF_COLORS[@currentPlayer]
    @shape.stroke = HASH_OF_COLORS2[@currentPlayer]
  end

  firstPosLeft, firstPosTop = 0, 0
  secondPosLeft, secondPosLeftndPosTop = 0, 0

  @drawGameButton.click do
    @currentPlayer = 0
    drawBoard
  end

  click do |button, left, top|
    i, j = getBoardSquareCoordsByCoords(left, top)
    @box.replace "#{i + 1}, #{j + 1}"
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
        attacker = @player1
        defender = @player2
      else
        attacker = @player2
        defender = @player1
      end

      result = 0
      result = move(@table, attacker, defender, firstPosLeft, firstPosTop, secondPosLeft, secondPosTop, 'qu')
      puts @currentPlayer

      if (firstPosLeft + firstPosTop) % 2 == 1
        @board[firstPosLeft - 1][firstPosTop - 1].fill = white
      else
        @board[firstPosLeft - 1][firstPosTop - 1].fill = black
      end
      firstPosLeft = 0
      firstPosTop = 0

      if result == 0 then @currentPlayer = (@currentPlayer + 1) % 2 end

      result = 0

      defender.figures.each do |fig|
        if fig == defender.king
          result = 1
          break
        end
      end

      if result == 0
        @box.replace "PLAYER #{attacker.id} WINS!"
        @box2.replace "PLAYER #{attacker.id} WINS!"
        @box3.replace "PLAYER #{attacker.id} WINS!"
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
