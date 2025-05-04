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

  def visit_subtraction(node)
    "(#{node.left_node.visit(self)} - #{node.right_node.visit(self)})"
  end

  def visit_negation(node)
    "-(#{node.visit(self)})"
  end

  def visit_and(node)
    "#{node.left_node.visit(self)} && #{node.right_node.visit(self)}"
  end

  def visit_or(node)
    puts "or"
    p node
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

  def visit_float_to_int(node)
    "#{node.visit(self)}"
  end
  def visit_int_to_float(node)
    "#{node.visit(self)}"
  end

  def visit_cell_r_value(node)
    "#[#{node.row.visit(self)}, #{node.col.visit(self)}]"
  end

  def visit_equals(node)
    "#{node.left_node.visit(self)} == #{node.right_node.visit(self)}"
  end

  def visit_not_equals(node)
    "#{node.left_node.visit(self)} != #{node.right_node.visit(self)}"
  end

  def visit_less_than(node)
    "#{node.left_node.visit(self)} < #{node.right_node.visit(self)}"
  end

  def visit_less_than_equal_to(node)
    "#{node.left_node.visit(self)} <= #{node.right_node.visit(self)}"
  end

  def visit_greater_then(node)
    "#{node.left_node.visit(self)} > #{node.right_node.visit(self)}"
  end

  def visit_greater_than_equal_to(node)
    "#{node.left_node.visit(self)} >= #{node.right_node.visit(self)}"
  end

  def visit_sum(node)
    "sum(#{node.top_left.visit(self)}, #{node.bottom_right.visit(self)})"
  end

  def visit_mean(node)
    "mean(#{node.top_left.visit(self)}, #{node.bottom_right.visit(self)})"
  end

  def visit_max(node)
    "max(#{node.top_left.visit(self)}, #{node.bottom_right.visit(self)})"
  end

  def visit_min(node)
    "min(#{node.top_left.visit(self)}, #{node.bottom_right.visit(self)})"
  end

  def visit_cell_l_value(node)
    "[#{node.row.visit(self)}, #{node.col.visit(self)}]"
  end

  def visit_block(node)
    node.statements[-1].visit(self)
  end

  def visit_reference(node)
    val = node.runtime.get_variable(node.var_name)
    val.visit(self)
  end

  def visit_conditional(node)
    "#{node.last.visit(self)}"  end

  def visit_assignment(node)
    "#{node.var_name} = #{node.r_val.visit(self)}"
  end

  def visit_for_each(node)
    "#{node.last.visit(self)}"
  end

  def visit_reference(node)
    node.runtime.get_variable(node.var_name).visit(self)
  end
end