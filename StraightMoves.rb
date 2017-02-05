# moves for queen and rook
module StraightMoves
  def south_moves(figure, playing_table)
    (figure.x + 1).upto(8).each do |index|
      if LEGIT_FIGURES[playing_table[index][figure.y].class]
        if figure.player == playing_table[index][figure.y].player then figure.table_of_range[index][figure.y] = '00'
        else figure.table_of_range[index][figure.y] = 'xx'
        end
        break
      end
      # if table_of_range[index][figure.y] != '--' then break end
      figure.table_of_range.squares[index][figure.y] = '++'
    end
  end

  def north_moves(figure, playing_table)
    (figure.x - 1).downto(1).each do |index|
      if LEGIT_FIGURES[playing_table[index][figure.y].class]
        if figure.player == playing_table[index][figure.y].player then figure.table_of_range[index][figure.y] = '00'
        else figure.table_of_range[index][figure.y] = 'xx'
        end
        break
      end
      # if table_of_range[index][figure.y] != '--' then break end
      figure.table_of_range.squares[index][figure.y] = '++'
    end
  end

  def west_moves(figure, playing_table)
    (figure.y - 1).downto(1).each do |index|
      if LEGIT_FIGURES[playing_table[figure.x][index].class]
        if figure.player == playing_table[figure.x][index].player then figure.table_of_range[figure.x][index] = '00'
        else figure.table_of_range[figure.x][index] = 'xx'
        end
        break
      end
      # if table_of_range[figure.x][index] != '--' then break end
      figure.table_of_range.squares[figure.x][index] = '++'
    end
  end

  def east_moves(figure, playing_table)
    (figure.y + 1).upto(8).each do |index|
      if LEGIT_FIGURES[playing_table[figure.x][index].class]
        if figure.player == playing_table[figure.x][index].player then figure.table_of_range[figure.x][index] = '00'
        else figure.table_of_range[figure.x][index] = 'xx'
        end
        break
      end
      # if table_of_range[figure.x][index] != '--' then break end
      figure.table_of_range.squares[figure.x][index] = '++'
    end
  end

  #
  # works on the presumtion this is a straight move
  #
  def straight_moves(figure, playing_table)
    east_moves(figure, playing_table)
    west_moves(figure, playing_table)
    south_moves(figure, playing_table)
    north_moves(figure, playing_table)
  end
end
