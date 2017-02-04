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

Shoes.app(width: 800, height: 800) do
  HASH_OF_COLORS = { 0 => black, 1 => white}
  @board = Array.new(8) { Array.new(8) }

  @table = Table.new
  @player1 = Player.new(1, 4, 1)
  @player2 = Player.new(2, 4, 8)

  @leftPadding = 100
  @topPadding = 100
  @widthVal = 50

  leftVal = @leftPadding
  topVal = @topPadding

  @standardGameButton = button "Standard Game plz"
  @customGameButton = button "Custom shet"
  @drawGameButton = button "Draw me plox"

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
    @box = para "watch here, fag"
    @box2 = para "watch here too, fag"
    @box3 = para "ye here too. fag"
  end


  color = 1
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

  firstPosLeft, firstPosTop = 0, 0
  secondPosLeft, secondPosTop = 0, 0

  @arrayofImages = Array.new

  @drawGameButton.click do
    drawBoard
  end

  @currentPlayer = 0

  click do |button, left, top|
    @board.each_index do |i|
      @board[i].each_index do |j|
        if @board[i][j].left  - left <= 0 && @board[i][j].top - top <= 0 &&
          top <= 8 * @widthVal + @topPadding && left <= 8 * @widthVal + @leftPadding &&
          left - @board[i][j].left <= @widthVal && top - @board[i][j].top <= @widthVal

          @box.replace "#{i + 1}, #{j + 1}"
          if firstPosLeft == 0
            firstPosLeft = i + 1
            firstPosTop = j + 1
            @box2.replace "#{firstPosLeft}, #{firstPosTop}"
            @board[i][j].fill = red
          else
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

            if (firstPosLeft + firstPosTop) % 2 == 1
              @board[firstPosLeft - 1][firstPosTop - 1].fill = white
            else
              @board[firstPosLeft - 1][firstPosTop - 1].fill = black
            end
            firstPosLeft = 0
            firstPosTop = 0

            if result == 0 then @currentPlayer = (@currentPlayer + 1) % 2 end

            drawBoard

          end
        end
      end
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
