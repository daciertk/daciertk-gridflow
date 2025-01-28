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
      visitor.visit_negation(self)
    end
  end


end
