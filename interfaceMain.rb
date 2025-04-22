require_relative "lexer.rb"
require_relative "parse.rb"
require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"
require_relative "runtime.rb"
require_relative "interface.rb"
require 'curses'
puts "test"
grid = Interface::Interface.new(7, 7)

grid.render

# Why not put this logic in the interface abstraction too? It's part of the
# interface and must access the same variables.
Curses.cbreak
Curses.noecho
Curses.stdscr.keypad(true)
loop do
  key = Curses.stdscr.getch
  #grid.debug("Key#{key.inspect}")
  case key
  when Curses::Key::LEFT
    if grid.active_col > 0
      grid.active_col -= 1
    end
  when Curses::Key::RIGHT 
    # Good clamping. You could also use % to wrap the coordinates around like
    # Pacman.
    if grid.active_col < grid.cols - 1
      grid.active_col += 1
      grid.message("Right")
    end
  when Curses::Key::UP
    if grid.active_row > 0
      grid.active_row -= 1
    end
  when Curses::Key::DOWN
    if grid.active_row < grid.rows - 1
      grid.active_row += 1
    end
  
  when 9
    grid.get_input
  end
  grid.message("#{grid.active_row} #{grid.active_col}")
  grid.render
  


end
message("end")
