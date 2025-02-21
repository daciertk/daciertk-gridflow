require_relative "primitives.rb"
require_relative "arithmetic.rb"

class Evaluator

  def visit_integer(node)
    node
  end

  def visit_float(node)
    node
  end

  def visit_boolean(node)
    node
  end

  def visit_string(node)
    node
  end

  def visit_cell_address(node)
    node
  end

  def visit_addition(node)
    #puts node
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value + right_node.raw_value)

    elsif left_node.is_a?(Primitives::Float)  && right_node.is_a?(Primitives::Float)
      Primitives::Float.new(left_node.raw_value + right_node.raw_value)
    else 
      raise "+ expects numbers"
    end
  end

  def visit_subtraction(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value - right_node.raw_value)

    elsif left_node.is_a?(Primitives::Float)  && right_node.is_a?(Primitives::Float)
      Primitives::Float.new(left_node.raw_value - right_node.raw_value)
    else 
      raise "- expects compatitible numbers"
    end
  end

  def visit_multiplication(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value * right_node.raw_value)

    elsif left_node.is_a?(Primitives::Float)  && right_node.is_a?(Primitives::Float)
      Primitives::Float.new(left_node.raw_value * right_node.raw_value)
    else 
      raise "* expects compatitible numbers"
    end
  end

  def visit_division(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value / right_node.raw_value)

    elsif left_node.is_a?(Primitives::Float)  && right_node.is_a?(Primitives::Float)
      Primitives::Float.new(left_node.raw_value / right_node.raw_value)
    else 
      raise "/ expects compatitible numbers"
    end
  end

  def visit_modulo(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value % right_node.raw_value)

    elsif left_node.is_a?(Primitives::Float)  && right_node.is_a?(Primitives::Float)
      Primitives::Float.new(left_node.raw_value % right_node.raw_value)
    else 
      raise "% expects compatitible numbers"
    end
  end

  def visit_exponentiation(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value ** right_node.raw_value)

    elsif left_node.is_a?(Primitives::Float)  && right_node.is_a?(Primitives::Float)
      Primitives::Float.new(left_node.raw_value ** right_node.raw_value)
    else 
      raise "** expects compatitible numbers"
    end
  end
  
  def visit_negation(node)
    value = node.visit(self)

    

    if node.is_a?(Primitives::Integer)
      Primitives::Integer.new(node.raw_value * -1)

    elsif node.is_a?(Primitives::Float)
    Primitives::Float.new(node.raw_value * -1)
    else 
      raise "negation expects number"
    end
  end

  def visit_and(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Boolean)  && right_node.is_a?(Primitives::Boolean)
      Primitives::Boolean.new(left_node.raw_value && right_node.raw_value)
    else
      raise "And expects Booleans"
    end
  end

  def visit_or(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Boolean)  && right_node.is_a?(Primitives::Boolean)
      Primitives::Boolean.new(left_node.raw_value || right_node.raw_value)
    else
      raise "Or expects Booleans"
    end
  end

  def visit_not(node)
    node = node.visit(self)
    if node.is_a?(Primitives::Boolean)
      Primitives::Boolean.new(!node.raw_value)
    else
      raise "Not expects boolean"
    end
  end

  def visit_bitwise_and(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value & right_node.raw_value)
    else
      raise "Bitwise expects Integers"
    end
  end
  
  def visit_bitwise_or(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value | right_node.raw_value)
    else
      raise "Bitwise expects Integers"
    end
  end
  def visit_bitwise_xor(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value ^ right_node.raw_value)
    else
      raise "Bitwise expects Integers"
    end
  end

  def visit_bitwise_l_shift(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value << right_node.raw_value)
    else
      raise "Bitwise expects Integers"
    end
  end

  def visit_bitwise_r_shift(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_node.is_a?(Primitives::Integer)  && right_node.is_a?(Primitives::Integer)
      Primitives::Integer.new(left_node.raw_value >> right_node.raw_value)
    else
      raise "Bitwise expects Integers"
    end
  end

  def visit_bitwise_not(node)
    node = node.visit(self)
    if node.is_a?(Primitives::Integer)
      Primitives::Integer.new(~node.raw_value)
    else
      raise "Bitwise expects Integers"
    end
  end



end