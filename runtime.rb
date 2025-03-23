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

    def set_cell(address, tree)
    
      row = address.row 
      col = address.col 

      if check_cell(row, col)
        value = tree.visit(Evaluator.new(self))
        @grid[row][col] = CellAddress.new(tree.visit(Serializer.new), tree, value)
      end
    end

    def get_cell(address)
      row = address.row 
      col = address.col
      if check_cell(row, col)
        value = grid[row][col].ast.visit(Evaluator.new(self))
      end
    end
  end

  class Runtime
    attr :grid

    def initialize(row, col)
      @grid = Grid.new(row, col)
    end 

    def get_cell(address)
      @grid.get_cell(address)
    end

    def set_cell(address, tree)
      @grid.set_cell(address, tree)
    end
  end
end
