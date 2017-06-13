class Player
  attr_accessor :figures
  attr_accessor :table_of_range, :king, :direction
  attr_reader :id

  def initialize(id, x, y)
    @figures = Array.new(18)
    @table_of_range = Table.new
    @id = id
    if @id == 1
      @direction = 1
    else
      @direction = -1
    end
    @king = King.new(x, y)
    add_figure(@king)
  end

  def add_figure(figure)
    if figure.x > 0 && figure.y > 0 && figure.x < 9 && figure.y < 9
      @figures.push(figure)
      figure.player = @id

      stringHelper = String.new('./Images/')
      if @id == 1
        stringHelper = stringHelper + 'White'
      else
        stringHelper = stringHelper + 'Black'
      end
      stringHelper += figure.class.to_s + '.png'
      figure.image = stringHelper
    else puts 'figure you\'re trying to add to player is out of base boundaries'
    end
    if figure.class == Pawn then figure.direction = @direction end
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
end
