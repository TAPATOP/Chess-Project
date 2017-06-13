# used for interface, as well as figure possible moves/ attacks
class Table
  attr_accessor :squares

  def initialize
    @squares = Array.new(9) { Array.new(9, '--') }
    format_table
  end

  def [](index)
    @squares[index]
  end

  def []=(index, something)
    @squares[index] = something
  end

  def display
    @squares.each do |line|
      line.each do |square|
        if LEGIT_FIGURES[square.class]
          if square.player == 1 then print LEGIT_FIGURES[square.class].upcase.blue
          else print LEGIT_FIGURES[square.class].red
          end
        else print square
        end
        print ' '
      end
      puts
    end
  end

  def put_figure(figure)
    if @squares[figure.x][figure.y] == '--'
      if LEGIT_FIGURES[figure.class]
        @squares[figure.x][figure.y] = figure
      else puts 'BEEP BOOP! No such figure, hun'
      end
    else puts 'BEEP BOOP! Coords are taken'
    end
  end

  def put_figures(figures)
    figures.each { |figure| put_figure(figure) if figure != nil }
  end

  def peek
    @squares.each { |line| puts line.object_id }
  end

  def format_table
    @squares[0].each_index { |index| squares[0][index] = '0' + index.to_s }
    @squares.each_index { |index| squares[index][0] = '0' + index.to_s }
    @squares[0][0] = '/0'
  end
end
