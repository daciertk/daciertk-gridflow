require_relative "primitives.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"

module Arithmetic

  class Addition
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_addition(self)
    end
  end

  class Subtraction
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_subtraction(self)
    end
  end

  class Multiplication
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_multiplication(self)
    end
  end

  class Division
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_division(self)
    end
  end

  class Modulo
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_modulo(self)
    end
  end

  class Exponentiation
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_exponentiation(self)
    end
  end

  class Negation
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def visit(visitor)

      visitor.visit_negation(self.node)
    end
  end


end

module Logical
  class And 
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_and(self)
    end
  end

  class Or
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end

    def visit(visitor)
      visitor.visit_or(self)
    end
  end

  class Not 
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def visit(visitor)
      visitor.visit_not(self.node)
    end
  end

end

module Bitwise

  class BitwiseAnd
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end
    def visit(visitor)
      visitor.visit_bitwise_and(self)
    end

  end

  class BitwiseOr
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node
    end
    def visit(visitor)
      visitor.visit_bitwise_or(self)
    end
  end

  class BitwiseNot
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def visit(visitor)
      visitor.visit_bitwise_not(self.node)
    end
  end

  class BitwiseXor
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @node
    end

    def visit(visitor)
      visitor.visit_bitwise_xor(self)
    end
  end

  class BitwiseLShift
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_bitwise_l_shift(self)
    end
  end

  class BitwiseRShift
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_bitwise_r_shift(self)
    end
  end
end

module Relational

  class Equals
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_equals(self)
    end
  end

  class NotEquals
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_not_equals(self)
    end
  end

  class LessThan
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_less_than(self)
    end
  end

  class LessThanEqualTo
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_less_than_equal_to(self)
    end
  end

  class GreaterThan
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_greater_then(self)
    end
  end

  class GreaterThanEqualTo
    attr_reader :left_node
    attr_reader :right_node

    def initialize(left_node, right_node)
      @left_node = left_node
      @right_node = right_node 
    end

    def visit(visitor)
      visitor.visit_greater_than_equal_to(self)
    end
  end
end 
module Cast

  class FloatToInt
    attr_reader :float_val

    def initialize(value)
      @float_val = value
    end

    def visit(visitor)
      visitor.visit_float_to_int(self.float_val)
    end
  end

  class IntToFloat
    attr_reader :int_val

    def initialize(value)
      @int_val = value 
    end

    def visit(visitor)
      visitor.visit_int_to_float(self.int_val)
    end
  end
end 

module Cell
  class CellLValue
    attr_reader :row
    attr_reader :col

    def initialize(row, col)
      @row = row
      @col = col
    end
    def visit(visitor)
      visitor.visit_cell_l_value(self)
    end
  end

  class CellRValue
    attr_reader :row
    attr_reader :col

    def initialize(row, col)
      @row = row
      @col = col
    end
    def visit(visitor)
      visitor.visit_cell_r_value(self)
    end
  end

end

  module Statistical 
    class Max
      attr_reader :top_left
      attr_reader :bottom_right

      def initialize(top, bottom)
        @top_left = top
        @bottom_right = bottom
      end

      def visit(visitor)
        visitor.visit_max(self)
      end
    end

    class Min
      attr_reader :top_left
      attr_reader :bottom_right

      def initialize(top, bottom)
        @top_left = top
        @bottom_right = bottom
      end

      def visit(visitor)
        visitor.visit_min(self)
      end
    end

    class Mean
      attr_reader :top_left
      attr_reader :bottom_right

      def initialize(top, bottom)
        @top_left = top
        @bottom_right = bottom
      end

      def visit(visitor)
        visitor.visit_mean(self)
      end
    end


    class Sum
      attr_reader :top_left
      attr_reader :bottom_right

      def initialize(top, bottom)
        @top_left = top
        @bottom_right = bottom
      end

      def visit(visitor)
        visitor.visit_sum(self)
      end
    end
  end
 
# Do you really need a new module for each class?
module Block

    # Building a language is hard, but I'm amazed at how much simpler it is to
    # extend one: just add some keywords or operators to the lexer, some new
    # parsing methods, and some model classes.
    class Block
      attr_reader :statements

      def initialize(statements)
        @statements = statements
      end

      def visit(visitor)
        visitor.visit_block(self)
      end
    end
end

module Variable
  class Assignment
    attr_reader :var_name
    attr_reader :r_val 
    attr_reader :runtime

    def initialize(var_name, r_val, runtime)
      @var_name = var_name
      @r_val = r_val
      @runtime = runtime
    end
    
    def visit(visitor)
      visitor.visit_assignment(self)
    end
  end

  class Reference 
    attr_reader :var_name
    attr_reader :runtime

    def initialize(var_name, runtime)
      @var_name = var_name
      @runtime = runtime
    end

    def visit(visitor)
      visitor.visit_reference(self)
    end
  end
end

module Conditional
  class Conditional
    attr_reader :condition 
    attr_reader :then_block
    attr_reader :else_block
    attr_accessor :last

    def initialize(condition, then_block, else_block)
      @condition = condition
      @then_block = then_block
      @else_block = else_block
    end

    def visit(visitor)
      visitor.visit_conditional(self)
    end
    

  end
end

module For 
  class ForEach
    attr_reader :var_name 
    attr_reader :start 
    attr_reader :end
    attr_reader :block 
    attr_accessor :last

    def initialize(var_name, start, end_cell, block)
      @var_name = var_name
      @start = start
      @end = end_cell
      @block = block 
    end

    def visit(visitor)
      visitor.visit_for_each(self)
    end
  end
end








