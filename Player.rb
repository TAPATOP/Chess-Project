class Player
  attr_accessor :figures
  attr_reader :tableOfRange

  def initialize
    @figures = Array.new(18)
    @tableOfRange = Table.new
  end

  def add_figure(figure)
  	@figures.push
  end

  def generate_table_of_range
    
  end
end