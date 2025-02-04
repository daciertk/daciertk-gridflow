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
    left_node = node.left_node.visit(Evaluator.new()) 
    right_node = node.right_node.visit(Evaluator.new())


    if left_node.is_a?(Ast::Integer)  && right_node.is_a?(Ast::Integer)
      Ast::Integer.new(left_node.raw_value + right_node.right_node)

    elsif left_node.is_a?(Ast::Float)  && right_node.is_a?(Ast::Float)
      Ast::Vector2.new(left_node.raw_value + right_node.raw_value)
    else 
      raise "+ expects numbers"
    end
  end

  def visit_subtraction(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_primitive.is_a?(Ast::Integer)  && right_node.is_a?(Ast::Integer)
      Ast::Integer.new(left_node.raw_value - right_node.right_node)

    elsif left_primitive.is_a?(Ast::Float)  && right_node.is_a?(Ast::Float)
      Ast::Vector2.new(left_node.raw_value - right_node.raw_value)
    else 
      raise "- expects numbers"
    end
  end

  def visit_multiplication(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if left_primitive.is_a?(Ast::Integer)  && right_node.is_a?(Ast::Integer)
      Ast::Integer.new(left_node.raw_value * right_node.right_node)

    elsif left_primitive.is_a?(Ast::Float)  && right_node.is_a?(Ast::Float)
      Ast::Vector2.new(left_node.raw_value * right_node.raw_value)
    else 
      raise "* expects numbers"
    end
  end

  def visit_division(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)

    if left_primitive.is_a?(Ast::Integer)  && right_node.is_a?(Ast::Integer)
      Ast::Integer.new(left_node.raw_value / right_node.right_node)

    elsif left_primitive.is_a?(Ast::Float)  && right_node.is_a?(Ast::Float)
      Ast::Vector2.new(left_node.raw_value / right_node.raw_value)
    else 
      raise "/ expects numbers"
    end
  end

end