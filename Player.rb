class Player
  attr_accessor :figures
  attr_accessor :table_of_range
  attr_reader :id

  def initialize(id)
    @figures = Array.new(18)
    @table_of_range = Table.new
    @id = id
  end

  def add_figure(figure)
    if figure.x > 0 && figure.y > 0 && figure.x < 9 && figure.y < 9
    @figures.push(figure)
    figure.player = @id
    else puts 'figure you\'re trying to add to player is out of base boundaries'
    end
  end

  def add_figures(figures)
    figures.each { |figure| add_figure(figure) }
  end

  def generate_table_of_range(table)
    @table_of_range = Table.new
    @figures.each do |figure|

      figure.set_moves(table) if figure != nil
      # if figure.x == 0 || figure.y == 0 then @figures.delete(figure) end
      
      figure.table_of_range.squares.each_index do |i|
        figure.table_of_range[i].each_index do |j|

          if (@table_of_range[i][j] == '--' && figure.table_of_range[i][j] != '--')
            @table_of_range[i][j] = figure.table_of_range[i][j]
          end

        end
      end if figure != nil
    end
  end

  def move_figure(table, x, y)
    
  end
end