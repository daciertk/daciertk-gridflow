require_relative "primitives.rb"
require_relative "evaluator.rb"
module Runtime

  class CellAddress
    attr_accessor :cell_code, :ast, :value
   
    
    def initialize(code, ast, value)
      @cell_code = code
      @ast = ast
      @value = value
    end

  end

  class Grid
    attr :grid
    attr :row_s
    attr :col_s

    def initialize(size1, size2)
      
      @row_s = size1
      @col_s = size2
      @grid = Array.new(row_s) {Array.new(col_s)}

    end
    
    def check_cell(row, col)
      if row >= @row_s or col >= @col_s
        raise "Invalid Address: Given row=#{row}, col=#{col}. Grid size is row_s=#{@row_s}, col_s=#{@col_s}."      
      end
    
      return true
    end

    def set_error(address, message)
    
      row = address.row 
      col = address.col 

      if check_cell(row, col)
        puts "Success"
        @grid[row][col] = CellAddress.new(message.visit(Serializer.new), message, Primitives::String.new("ERROR"))
      end
    end


    def set_cell(address, tree, runtime)
    
      row = address.row 
      col = address.col 

      if check_cell(row, col)
        value = tree.visit(Evaluator.new(runtime))
        @grid[row][col] = CellAddress.new(tree.visit(Serializer.new), tree, value)
      end
    end

    def get_cell(address)
      row = address.row 
      col = address.col
      if check_cell(row, col)
        value = grid[row][col].ast.visit(Evaluator.new(self))
        if value.is_a? Primitives::String
          value =grid[row][col].value
        end
      
        #value = grid[row][col].value
      end
      value
    end

    def get_code(address)
      row = address.row
      col = address.col
      if check_cell(row, col)
        code = grid[row][col].cell_code
      end
      code
    end
  end

  class Runtime
    attr :grid
    attr :variables

    def initialize(row, col)
      @grid = Grid.new(row, col)
      # A hash is a fine choice. Plain {} would work to initialize it.
      @variables = Hash.new(nil)
    end 

    def get_variable(var_name)
      @variables[var_name]
    end

    def set_variable(var_name, value)
      @variables[var_name] = value
    end
    def get_cell(address)
      @grid.get_cell(address)
    end

    def set_cell(address, tree)
      @grid.set_cell(address, tree, self)
    end

    def get_code(address)
      @grid.get_code(address)
    end

    def set_error(address, message)
      @grid.set_error(address, message)
    end

    # You already have a getter from attr_reader. But do you even need the whole
    # hash to be public?
    def variables
      @variables
    end      
  end
end
