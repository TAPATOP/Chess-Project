RSpec.describe 'um' do

  describe'hmm' do
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
    player2.add_figure(pawn26 = Pawn.new(7, 6))
    player2.add_figure(pawn27 = Pawn.new(7, 7))
    player2.add_figure(pawn28 = Pawn.new(7, 8))

    table.put_figures(player1.figures)
    table.put_figures(player2.figures)

    player1.generate_table_of_range(table)
    player2.generate_table_of_range(table)
    it 'something' do
      expect(move(table, player1, player2, 2, 2, 4, 2)) .to eq(1)
    end
    it 'something' do
      move(table, player2, player1, 4, 1, 3, 2)
      expect(table[3][2].player) .to eq(2)
    end
  end
end
