@require_relative "primitives.rb"
@require_relative "evaluator.rb"
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
      @grid = Array.new[size1][size2]
      @row_s = size1
      @col_s = size2

    end
    
    def check_cell(row, col)
      if row > row_s or col > col_s
        raise "Invalid Address"
      end
      return True

    def set_cell(address, tree)
    
      row = address.row 
      col = address.col 

      if check_cell(row, col)
        value = tree.visit(Evaluator.new)
        grid[row][col] = CellAddress.new(tree.visit(Serializer.new), tree, value)
      end
    end

    def get_cell(address)
      row = address.row 
      col = address.col
      if check_cell(row, col)
        value = grid[row][col].ast.visit(Evaluator.new)
      end
  end


  class Runtime
    attr :grid

    def initialize(row, col)
      @grid = Grid.new(row, col)
    end 

    def get_cell(address)
      grid.get_cell(address)
    end

    def set_cell(address)
      grid.set_cell(address)
    end



end
