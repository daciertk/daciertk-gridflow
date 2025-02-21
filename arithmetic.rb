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


