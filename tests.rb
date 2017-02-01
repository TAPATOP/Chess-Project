RSpec.describe 'Table' do

  describe'movement checks' do
    table = Table.new
    player1 = Player.new(1)
    player2 = Player.new(2)

    player1.add_figure(pawn1 = Pawn.new(7, 1))
    player1.add_figure(pawn2 = Pawn.new(2, 2))
    player1.add_figure(pawn3 = Pawn.new(2, 3))
    player1.add_figure(bishop1 = Bishop.new(2, 4))
    player1.add_figure(pawn5 = Pawn.new(2, 5))
    player1.add_figure(pawn6 = Pawn.new(2, 6))
    player1.add_figure(pawn7 = Pawn.new(2, 7))
    player1.add_figure(pawn8 = Pawn.new(2, 8))
    player1.add_figure(rook1 = Rook.new(1, 1))
    player1.add_figure(rook2 = Rook.new(1, 8))
    player1.add_figure(knight1 = Knight.new(5, 3))
    player1.add_figure(queen1 = Queen.new(1, 4))

    player2.add_figure(pawn21 = Pawn.new(4, 1))
    player2.add_figure(pawn22 = Pawn.new(7, 2))
    player2.add_figure(pawn23 = Pawn.new(7, 3))
    player2.add_figure(pawn24 = Pawn.new(7, 4))
    player2.add_figure(pawn25 = Pawn.new(7, 5))
    player2.add_figure(pawn26 = Pawn.new(3, 6))
    player2.add_figure(pawn27 = Pawn.new(7, 7))
    player2.add_figure(pawn28 = Pawn.new(3, 8))
    player2.add_figure(rook21 = Rook.new(4, 6))
    player2.add_figure(knight21 = Knight.new(5, 4))

    table.put_figures(player1.figures)
    table.put_figures(player2.figures)

    player1.generate_table_of_range(table)
    player2.generate_table_of_range(table)

    it 'knows initial pawn moves case 1' do
      counter = 0
      pawn5.table_of_range.squares.each {|line| line.each{ |square| counter += 1 if square == '++' } }
      expect(counter).to eq (2)
      expect(pawn5.table_of_range[3][5]).to eq('++')
      expect(pawn5.table_of_range[4][5]).to eq('++')
    end

    it 'knows initial pawn moves case 2' do
      counter = 0
      pawn8.table_of_range.squares.each {|line| line.each{ |square| counter += 1 if square == '++' } }
      expect(counter).to eq (0)
      expect(pawn8.table_of_range[3][8]).to eq('--')
      expect(pawn8.table_of_range[4][8]).to eq('--')
    end

    it 'knows initial pawn moves case 3' do
      counter = 0
      pawn23.table_of_range.squares.each {|line| line.each{ |square| counter += 1 if square == '++' } }
      expect(counter).to eq (1)
      expect(pawn23.table_of_range[6][3]).to eq('++')
      expect(pawn23.table_of_range[5][3]).to eq('--')
    end

    it 'has moved the pawn' do
      move(table, player1, player2, 2, 2, 4, 2)
      expect(table[2][2]).to eq('--')
    end

    it 'has moved the pawn to the correct destination' do
      expect(table[4][2]).to eq(pawn2)
    end

    it 'detects en- passante possibility' do
      expect(player2.table_of_range[3][2]).to eq('!!')
    end

    it 'moves the pawn' do
      move(table, player2, player1, 4, 1, 3, 2)
      expect(table[4][1]).to eq('--')
    end

    it 'moves the pawn to the end' do
      expect(table[3][2]).to eq(pawn21)
    end

    it 'removes the p1 pawn' do
      expect(player1.figures.include? pawn2).to eq(false)
    end

    it 'moves the p1 queen' do
      move(table, player1, player2, 1, 4, 1, 6)
      expect(table[1][4]).to eq('--')
      expect(table[1][6]).to eq(queen1)
    end

    it 'lets p2 pawn take p1 pawn' do
      move(table, player2, player1, 3, 6, 2, 7)
      expect(table[3][6]).to eq('--')
      expect(table[2][7]).to eq(pawn26)
      expect(player1.figures.include? pawn7).to eq(false)
    end

    it 'lets p1 queen take p2 pawn' do
      move(table, player1, player2, 1, 6, 2, 7)
      expect(table[1][6]).to eq('--')
      expect(table[2][7]).to eq(queen1)
      expect(player2.figures.include? pawn26).to eq(false)
    end

    it 'lets p2 pawn take p1 queen' do
      move(table, player2, player1, 3, 8, 2, 7)
      expect(table[3][8]).to eq('--')
      expect(table[2][7]).to eq(pawn28)
      expect(player1.figures.include? queen1).to eq(false)
    end

    it 'doesn\'t let pawn make an illegal en- passant' do
      move(table, player1, player2, 2, 3, 4, 3)
      move(table, player2, player1, 3, 2, 2, 3)
      move(table, player2, player1, 3, 2, 3, 3)
      expect(pawn21.x).to eq(3)
      expect(pawn21.y).to eq(2)
      expect(player2.table_of_range[3][3]). to eq('!!')
    end

    it 'eliminates en- passante the following turn' do
      move(table, player2, player1, 7, 2, 6, 2)
      expect(player2.table_of_range[3][3]). to_not eq('!!')
    end

    it 'kills p2 rook with p1 bishop' do
      move(table, player1, player2, 2, 4, 4, 6)
      expect(table[2][4]).to eq('--')
      expect(table[4][6]).to eq(bishop1)
      expect(player2.figures.include? rook21).to eq(false)
    end

    it 'knows p2 knight moves' do
      expect(knight21.table_of_range[3][3]).to eq('++')
      expect(knight21.table_of_range[4][2]).to eq('++')
      expect(knight21.table_of_range[6][2]).to eq('00')
      expect(knight21.table_of_range[7][3]).to eq('00')
      expect(knight21.table_of_range[7][5]).to eq('00')
      expect(knight21.table_of_range[6][6]).to eq('++')
      expect(knight21.table_of_range[4][6]).to eq('xx')
      expect(knight21.table_of_range[3][5]).to eq('++')
    end

    it 'kills p1 bishop with p2 knight' do
      move(table, player2, player1, 5, 4, 4, 6)
      expect(table[5][4]).to eq('--')
      expect(table[4][6]).to eq(knight21)
      expect(player1.figures.include? bishop1).to eq(false)
      table.display
    end
  end
end
