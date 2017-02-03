Shoes.app(width: 800, height: 800) do
  HASH_OF_COLORS = { 0 => black, 1 => white}
  @board = Array.new(8) { Array.new(8) }

  leftPadding = 100
  topPadding = 100
  widthVal = 50

  leftVal = leftPadding
  topVal = topPadding

  color = 1
  stack do
    @box = para "watch here, fag"
    @box2 = para "watch here too, fag"
    @box3 = para "ye here too"
  end

  @board.each_index do |i|
    @board[i].each_index do |j|
      @board[i][j] = rect(left: leftVal, top: topVal, width: widthVal)
      leftVal += widthVal
      @board[i][j].fill = HASH_OF_COLORS[(color += 1) % 2]
    end
    color = (color + 1) % 2
    topVal += widthVal
    leftVal = leftPadding
  end

  click do |button, left, top|
    @board.each_index do |i|
      @board[i].each_index do |j|
        if @board[i][j].left  - left <= 0 && @board[i][j].top - top <= 0 &&
          top <= 8 * widthVal + topPadding && left <= 8 * widthVal + leftPadding &&
          left - @board[i][j].left <= widthVal && top - @board[i][j].top <= widthVal

          @board[i][j].fill = red
          @box.replace "#{i + 1}, #{j + 1}"
          @box2.replace "#{@board[i][j].left} #{@board[i][j].top}"
          @box3.replace "#{left} #{top}"
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
