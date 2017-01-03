class Player
  attr_accessor :figures
  attr_reader :table_of_range

  def initialize
    @figures = Array.new(18)
    @table_of_range = Table.new
  end

  def add_figure(figure)
  	@figures.push(figure)
  end

  def generate_table_of_range(table)
    @figures.each do |figure|
      figure.set_moves(table) if figure != nil

      figure.table_of_range.squares.each_index do |i|
        figure.table_of_range[i].each_index do |j|

          if (table_of_range[i][j] == '--' && figure.table_of_range[i][j] != '--')
          	table_of_range[i][j] = figure.table_of_range[i][j]
          end

        end
      end if figure != nil
    end
  end
end