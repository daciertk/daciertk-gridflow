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
  
  def visit_add(node)
    left_node = left_node.visit(self) 
    right_node = right_node.visit(self)

    if left_primitive.is_a?(Ast::Integer)  && right_node.is_a?(Ast::Integer)
      Ast::Integer.new(left_node.raw_value + right_node.right_node)
    elsif left_primitive.is_a?(Ast::Vector2)  && right_node.is_a?(Ast::Integer)
      Ast::Vector2.new(left_node.raw_x + right_node.raw_value, left_node.raw_y + right_node.raw_value)
    else 
      raise "+ expects integers and vectors"
    end
    # Recurse on subnodes, check types, return new primitive node
  end

end