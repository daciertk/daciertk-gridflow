require 'curses'
require_relative "lexer.rb"
require_relative "parse.rb"
require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"
require_relative "runtime.rb"

module Interface 
  # A class is a reasonable organizational structure for this code, even though
  # you only expect to make a single instance of the interface. It provides a
  # conventional place for initialization, isolates the globals into a narrower
  # scope, and gives you the opportunity to break operations into methods with
  # meaningful names. And you don't need to pass many parameters around since
  # they're available in the receiver object.
  class Interface
    # Do these really need public getters and setters?
    attr_accessor :active_row
    attr_accessor :active_col
    attr_accessor :rows
    attr_accessor :cols
    def initialize(rows, cols)

      Curses::init_screen
      Curses::start_color
      Curses::init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
      Curses::init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
      Curses.cbreak
      Curses.noecho
      Curses.stdscr.keypad(true)
      width = Curses::cols
      height = Curses::lines
      @rows = rows
      @cols = cols
      @active_row = 0
      @active_col = 0
      @last_row = @active_row
      @last_col = @active_col
      i = 0
      # Each evaluation of a formula should be independent of all others, so
      # having a single, shared runtime and visitors is a bit dangerous. They
      # don't take up much space and they're cheap to create. I'd make
      # temporary instances just in time, when you need to evaluate a tree.
      # There's no need to persist them in long-lived instance variables.
      @runtime = Runtime::Runtime.new(@rows, @cols)
      @message_window = Curses::Window.new(1, width, height-1, 0)
      @debug_window = Curses::Window.new(1, width, height-2, 0)
      @title_window = Curses::Window.new(1, width, 0, 0)
      @title_window.clear
      @title_window.setpos(0,0)
      @title_window.addstr("Welcome To GridFlow")
      @title_window.refresh
      for row in 0..@rows-1
        for col in 0..@cols-1
          address = Primitives::CellAddress.new(row, col)
          int1 = Primitives::Integer.new(0)
          int2 = Primitives::Integer.new(col)
          node = Arithmetic::Addition.new(int1, int2)
          # Yes, why do you fill the sheet with 0s? A blank cell is perfectly
          # legitimate and not difficult to detect.
          #p address
          @runtime.set_cell(address, int1)
          i += 1
        end
      end
      
      @cell_height = 2
      @cell_width =  10
      @grid_window = Curses::Window.new(@cell_height * @rows + 1, @cell_width * @cols + 1, 2, 0)

      message"test"
      puts "init end"
     
      @grid_window.keypad(true)

    end

    def print_cell(row, col)
      address = Primitives::CellAddress.new(row, col)
      node = @runtime.get_cell(address)
      node.visit(Serializer.new)
    end

    def message(text)
      @message_window.clear
      @message_window.setpos(0,0)
      @message_window.addstr(text)
      @message_window.refresh
    end

    def debug(text)
      @debug_window.clear
      @debug_window.setpos(0,0)
      @debug_window.addstr(text)
      @debug_window.refresh
    end

    def render_grid
      # Draw -----
      (0..@grid_window.maxy).step(@cell_height) do |row|
        (0..@grid_window.maxx).each do|col|
          @grid_window.setpos(row, col)
          @grid_window.addstr("\u2501")
       
        end
      end
      
      # Draw col markers | 
      (0..@grid_window.maxy).each do |row|
        (0..@grid_window.maxx ).step(@cell_width) do|col|
          @grid_window.setpos(row, col)
          @grid_window.addstr("\u2503")

        end
      end

      # Draw Cell Values
      (0..@rows-1).each do |row|
        (0..@cols-1).each do |col|
          x_start = col * @cell_width + 1
          y_start = (row * @cell_height) + 1
          @grid_window.setpos(y_start, x_start)
          @grid_window.attron(Curses.color_pair(1)) do
            @grid_window.addstr(print_cell(row, col))
          end
        end
      end

      
      shade_cell(@active_row, @active_col)
    
    end

    def shade_cell(row, col)
      clear_cell(@last_row, @last_col)
      x_start = col * @cell_width + 1
      x_end = x_start + @cell_width - 2
      y_start = (row * @cell_height) + 1
      y_end = y_start + @cell_height - 2
      (y_start..y_end).each do |y|
        (x_start..x_end).each do |x|
          @grid_window.setpos(y, x)
          @grid_window.attron(Curses.color_pair(1)) do 
            @grid_window.addstr("\u2588")
          end
          #message("shading #{x} #{y}")
        end
      end
      @grid_window.setpos(y_start, x_start)
      @grid_window.attron(Curses.color_pair(2)) do
        @grid_window.addstr(print_cell(@active_row, @active_col))
      end
      code = @runtime.get_code(Primitives::CellAddress.new(@active_row, @active_col))
      debug("#{code}")
      message("#{print_cell(@active_row, @active_col)}")
      #("shading #{@active_row} #{@active_col}")

      
      @last_col = col
      @last_row = row
      @grid_window.setpos(0,@grid_window.maxx - 1)
      @grid_window.refresh
    end

    def clear_cell(row, col)
      x_start = col * @cell_width + 1
      x_end = x_start + @cell_width - 2
      y_start = (row * @cell_height) + 1
      y_end = y_start + @cell_height - 2
      (y_start..y_end).each do |y|
        (x_start..x_end).each do |x|
          @grid_window.setpos(y, x)
          @grid_window.attron(Curses.color_pair(2)) do 
            @grid_window.addstr("\u2588")
            
          end
          @grid_window.setpos(y_start, x_start)
          @grid_window.attron(Curses.color_pair(1)) do
            @grid_window.addstr(print_cell(row, col))
          end
         # message("shading #{row} #{col}")
        end
      end

    end

    def get_input
      @message_window.bkgd(Curses.color_pair(2) | ' '.ord)
      @message_window.attron(Curses.color_pair(2)) 
      Curses.echo
      @message_window.clear
      @message_window.setpos(0, 0)
      @message_window.refresh
      input = @message_window.getstr()
      
      if input[0] == "="
        begin
          node = lex_n_parse(input[1..])
        rescue StandardError=> e
          address = Primitives::CellAddress.new(@active_row, @active_col)
          # Good, making a string is reasonable. I made an error node in my AST
          # hierarchy so that I couldn't perform a string operation on an error
          # message.
          error = Primitives::String.new(e.message + " " + input[1..])
          @runtime.set_error(address, error)
          # @message_window.bkgd(Curses.color_pair(1) | ' '.ord)
         ##message(e.message)
          return
        end
      else 
        begin 
          node = lex_n_parse(input)

        rescue => e
          address = Primitives::CellAddress.new(@active_row, @active_col)
          str_node = Primitives::String.new(input)
          @runtime.set_cell(address, str_node)
          
        end
      end

      
      input
      @message_window.bkgd(Curses.color_pair(1) | ' '.ord)
      @message_window.attron(Curses.color_pair(1)) 
      Curses.noecho
    end



    def render 
      @grid_window.clear
      render_grid
      
      #@grid_window.getch
    end
    def lex_n_parse(code)
      
      begin
        # So much is happening in these few lines. Abstractions are amazing.
        lexer = Lexer::Lex.new(code)
        lexer.lex

        tokens = lexer.tokens
        parser = Parser::Parser.new(tokens)
        
        ast = parser.parse
        address = Primitives::CellAddress.new(@active_row, @active_col)
        @runtime.set_cell(address, ast)
      rescue => e
        address = Primitives::CellAddress.new(@active_row, @active_col)
       # @runtime.set_cell(address, Primitives::String.new(e.message))
        
        error = Primitives::String.new(e.message + " in expression { " + code + "}")
        p error
        @runtime.set_error(address, error)
        
        return
      end
    end
  end


end
