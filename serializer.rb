class Serializer
  def visit_integer(node)
    node.raw_value.to_s
  end

  def visit_float(node)
    node.raw_value.to_s
  end

  def visit_boolean(node)
    node.raw_value.to_s
  end

  def visit_string(node)
    node.raw_value.to_s
  end

  def visit_cell_address(node)
    "[f#{node.row}, f#{node.col}]"
  end
end