require 'colorize'
load 'StraightMoves.rb' # it's a module
load 'DiagonalMoves.rb' # it's a module
load 'Figures.rb'
load 'Table.rb'
load 'Player.rb'

include StraightMoves
include DiagonalMoves

def move(table, attacker, defender, x, y, dx, dy) # Table, Player, Player, FixNum, FixNum, FixNum, FixNum
  if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id

    if table[x][y].table_of_range[dx][dy] == '++'
      to_be_changed = attacker.figures.find { |figure| !figure.nil? && figure.x == x && figure.y == y }
      
      to_be_changed.move(dx, dy, table)

      table[x][y] = '--'

    elsif table[x][y].table_of_range[dx][dy] == '00'
      puts 'Can\'t move there, friendly in the way!'
      return 1
    elsif table[x][y].table_of_range[dx][dy] == 'xx'
      puts 'Enemy killed!'
      defender.figures.delete(table[dx][dy])
      
      table[x][y].move(dx, dy, table)

      table[x][y] = '--'

    else 
      puts 'You can\'t move there with that'
      return 1
    end

  table = Table.new

  table.put_figures(attacker.figures)
  table.put_figures(defender.figures)
  
  attacker.generate_table_of_range(table)
  defender.generate_table_of_range(table)

  else 
  	puts 'You don\'t have a figure there, try again'
  	return 1
  end
end
def turn(table, attacker, defender)
  while(true) do
    puts "Player #{attacker.id} turn. Choose command: move, inspect, display"
    command = gets.chomp

    if command == 'move'
      while(true) do
        puts 'X:'
        x = gets.chomp.to_i
        if x < 1 || x > 8
          puts 'invalid coordinates, try again'
          next
        end
        puts 'Y:'
        y = gets.chomp.to_i
        if y < 1 || y > 8
          puts 'invalid coordinates, try again'
          next
        end
      
        puts 'DX:'
        dx = gets.chomp.to_i
        if dx < 1 || dx > 8
          puts 'invalid coordinates, try again'
          next
        end
      
        puts 'DY:'
        dy = gets.chomp.to_i
        if dy < 1 || dy > 8
          puts 'invalid coordinates, try again'
          next
        end
        break
      end
      # validation above

      if move(table, attacker, defender, x, y, dx, dy) == 1 then next end
      puts
    
      attacker.table_of_range.display
      puts
      
      defender.table_of_range.display
      puts
      
      table.display
      break

    elsif command == 'inspect'
      puts 'X:'
        x = gets.chomp.to_i
        if x < 1 || x > 8
          puts 'Invalid coordinates, try again'
          next
        end
        puts 'Y:'
        y = gets.chomp.to_i
        if y < 1 || y > 8
          puts 'Invalid coordinates, try again'
          next
        end

        if LEGIT_FIGURES[table[x][y].class] && table[x][y].player == attacker.id
          table[x][y].table_of_range.display
        else
          puts "This isn\'t player #{ attacker.id }\'s figure! Try again"
        end
        next
    elsif command == 'display'
      table.display
      next
    else 
      puts 'Unrecognized command! Try again.'
      next
    end
    break
    
  end
end
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

player2.add_figure(pawn21 = Pawn.new(7, 1))
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

table.display

x = 1
y = 8

dx = 1
dy = 2

while(true) do
  turn(table, player1, player2)
  turn(table, player2, player1)
end
/ test TO DO

legit figure name
legit coord

/
