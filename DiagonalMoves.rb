module DiagonalMoves
  def northwest_moves(figure, playing_table)
    (1).upto(8).each do |index|
      if figure.x - index == 0 || figure.y - index == 0 then break end

      if LEGIT_FIGURES[playing_table[figure.x - index][figure.y - index].class]
        if figure.player == playing_table[figure.x - index][figure.y - index].player
          figure.table_of_range[figure.x - index][figure.y - index] = '00'
        else figure.table_of_range[figure.x - index][figure.y - index] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[figure.x - index][figure.y - index] = '++'
    end  	
  end

  def southwest_moves(figure, playing_table)
    (1).upto(8).each do |index|
      if figure.x + index > 8 || figure.y - index == 0 then break end

      if LEGIT_FIGURES[playing_table[figure.x + index][figure.y - index].class]
        if figure.player == playing_table[figure.x + index][figure.y - index].player
          figure.table_of_range[figure.x + index][figure.y - index] = '00'
        else figure.table_of_range[figure.x + index][figure.y - index] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[figure.x + index][figure.y - index] = '++'
    end  	
  end

  def northeast_moves(figure, playing_table)
    (1).upto(8).each do |index|
      if figure.x - index == 0 || figure.y + index > 8 then break end

      if LEGIT_FIGURES[playing_table[figure.x - index][figure.y + index].class]
        if figure.player == playing_table[figure.x - index][figure.y + index].player
          figure.table_of_range[figure.x - index][figure.y + index] = '00'
        else figure.table_of_range[figure.x - index][figure.y + index] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[figure.x - index][figure.y + index] = '++'
    end 
  end

  def southeast_moves(figure, playing_table)
    (1).upto(8).each do |index|
      if figure.x + index > 8 || figure.y + index > 8 then break end

      if LEGIT_FIGURES[playing_table[figure.x + index][figure.y + index].class]
        if figure.player == playing_table[figure.x + index][figure.y + index].player
          figure.table_of_range[figure.x + index][figure.y + index] = '00'
        else figure.table_of_range[figure.x + index][figure.y + index] = 'xx'
        end
        break
      end
      figure.table_of_range.squares[figure.x + index][figure.y + index] = '++'
    end
  end

  def diagonal_moves(figure, playing_table)
  	northwest_moves(figure, playing_table)
  	southwest_moves(figure, playing_table)
  	northeast_moves(figure, playing_table)
  	southeast_moves(figure, playing_table)
  end
end