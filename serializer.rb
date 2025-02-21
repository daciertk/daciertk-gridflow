require_relative "primitives.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"

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
    "[#{node.row}, #{node.col}]"
  end

  def visit_addition(node)
    "(#{node.left_node.visit(self)} + #{node.right_node.visit(self)})"
  end

  def visit_multiplication(node)
    "(#{node.left_node.visit(self)} * #{node.right_node.visit(self)})"
  end

  def visit_division(node)
    "(#{node.left_node.visit(self)} / #{node.right_node.visit(self)})"
  end

  def visit_modulo(node)
    "(#{node.left_node.visit(self)} % #{node.right_node.visit(self)})"
  end

  def visit_exponentiation(node)
    "(#{node.left_node.visit(self)} ^ #{node.right_node.visit(self)})"
  end

  def visit_addition(node)
    "(#{node.left_node.visit(self)} + #{node.right_node.visit(self)})"
  end

  def visit_negation(node)
    "-(#{node.visit(self)})"
  end

  def visit_and(node)
    "#{node.left_node.visit(self)} && #{node.right_node.visit(self)}"
  end

  def visit_or(node)
    "#{node.left_node.visit(self)} || #{node.right_node.visit(self)}"
  end

  def visit_not(node)
    "!(#{node.visit(self)})"
  end

  def visit_bitwise_and(node)
    "#{node.left_node.visit(self)} & #{node.right_node.visit(self)}"
  end

  def visit_bitwise_or(node)
    "#{node.left_node.visit(self)} | #{node.right_node.visit(self)}"
  end

  def visit_bitwise_xor(node)
    "#{node.left_node.visit(self)} ^ #{node.right_node.visit(self)}"
  end

  def visit_bitwise_l_shift(node)
    "#{node.left_node.visit(self)} << #{node.right_node.visit(self)}"
  end
  def visit_bitwise_r_shift(node)
    "#{node.left_node.visit(self)} >> #{node.right_node.visit(self)}"
  end

  def visit_bitwise_not(node)
    "~#{node.visit(self)}"
  end

end