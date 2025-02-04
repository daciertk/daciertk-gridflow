require_relative "primitives.rb"

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
    @left_node = node.left_node.visit(self) 
    @right_node = node.right_node.visit(self)
    Primitives::Integer.new(left_node.raw_value + right_node.raw_value)
   
    # Recurse on subnodes, check types, return new primitive node
  end

end