require_relative "primitives.rb"
require_relative "arithmetic.rb"
require_relative "runtime.rb"

class Evaluator

  attr :runtime

  def initialize(runtime)
    @runtime = runtime
  end
  
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
    

    if value.is_a?(Primitives::Integer)
      Primitives::Integer.new(value.raw_value * -1)

    elsif value.is_a?(Primitives::Float)
    Primitives::Float.new(value.raw_value * -1)
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

  def visit_equals(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if  (left_node.is_a?(Primitives::Integer) or left_node.is_a?(Primitives::Float))  and
       (right_node.is_a?(Primitives::Integer) or right_node.is_a?(Primitives::Float))
      Primitives::Boolean.new left_node.raw_value == right_node.raw_value
    else
      raise "Equals Expects Numbers"
    end
  end

  def visit_not_equals(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if  (left_node.is_a?(Primitives::Integer) or left_node.is_a?(Primitives::Float))  and
      (right_node.is_a?(Primitives::Integer) or right_node.is_a?(Primitives::Float))
      Primitives::Boolean.new left_node.raw_value != right_node.raw_value
    else
      raise "Not Equals Expects Numbers"
    end
  end

  def visit_less_than(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if  (left_node.is_a?(Primitives::Integer) or left_node.is_a?(Primitives::Float))  and
      (right_node.is_a?(Primitives::Integer) or right_node.is_a?(Primitives::Float))     
       Primitives::Boolean.new left_node.raw_value < right_node.raw_value
    else
      raise "Less Than Expects Numbers"
    end
  end

  def visit_less_than_equal_to(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if  (left_node.is_a?(Primitives::Integer) or left_node.is_a?(Primitives::Float))  and
      (right_node.is_a?(Primitives::Integer) or right_node.is_a?(Primitives::Float))     
       Primitives::Boolean.new(left_node.raw_value <= right_node.raw_value)
    else
      raise "Less Than Equal to Expects Numbers"
    end
  end

  def visit_greater_then(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if  (left_node.is_a?(Primitives::Integer) or left_node.is_a?(Primitives::Float))  and
      (right_node.is_a?(Primitives::Integer) or right_node.is_a?(Primitives::Float))     
       Primitives::Boolean.new(left_node.raw_value > right_node.raw_value)
    else
      raise "Greater than Expects Numbers"
    end
  end


  def visit_greater_than_equal_to(node)
    left_node = node.left_node.visit(self) 
    right_node = node.right_node.visit(self)
    if  (left_node.is_a?(Primitives::Integer) or left_node.is_a?(Primitives::Float))  and
      (right_node.is_a?(Primitives::Integer) or right_node.is_a?(Primitives::Float))     
       Primitives::Boolean.new(left_node.raw_value >= right_node.raw_value)
    else
      raise "Greater than Equal to to Expects Numbers"
    end
  end

  def visit_float_to_int(node)
    node = node.visit(self)
    
    if node.is_a?(Primitives::Float)
      Primitives::Integer.new(node.raw_value.to_i)
    else
      raise "Casting Operation Expects Float"
    end
  end

  def visit_int_to_float(node)
    node = node.visit(self)
    if node.is_a?(Primitives::Integer)
      Primitives::Float.new(node.raw_value.to_f)
    else
      raise "Casting Operation Expects Integer"
    end
  end

  def visit_cell_l_value(node)
    left_node = node.row.visit(self)
    right_node = node.col.visit(self)
    val = Primitives::CellAddress.new(left_node.raw_value, right_node.raw_value)
    val
   
  end 

  def visit_cell_r_value(node)
    left_node = node.row
    right_node = node.col
    left_node = left_node.visit(self)
    right_node = right_node.visit(self)
    if left_node.is_a?(Primitives::Integer) and right_node.is_a?(Primitives::Integer)
      address = Primitives::CellAddress.new(left_node.raw_value, right_node.raw_value)

      value = runtime.get_cell(address)
      if value == nil
        raise "Undefined Cell"
      end
      value
    end
  end

  def visit_max(node)
    top_left = node.top_left.visit(self)
    bottom_right = node.bottom_right.visit(self)
    if not (top_left.is_a?(Primitives::CellAddress) and bottom_right.is_a?(Primitives::CellAddress))
      raise "Invalid Cell Address: top_left is a #{top_left.class} and bottom_right is a #{bottom_right.class}. Both should be instances of Primitives::CellAddress."
    end

    values = []
    for row in top_left.row .. bottom_right.row
      for col in top_left.col .. bottom_right.col
        values.append(runtime.get_cell(Primitives::CellAddress.new(row, col)))
      end
    end
    max = 0
    max_node = Primitives::Integer.new(0)
    for value in values
      if value == nil
        raise "Undefined Cell"
      end
      if value.raw_value > max
        max = value.raw_value
        max_node = value
      end
    end
    max_node
  end

  def visit_min(node)
    top_left = node.top_left.visit(self)
    bottom_right = node.bottom_right.visit(self)
    if not (top_left.is_a?(Primitives::CellAddress) and bottom_right.is_a?(Primitives::CellAddress))
      raise "Invalid Cell Address: top_left is a #{top_left.class} and bottom_right is a #{bottom_right.class}. Both should be instances of Primitives::CellAddress."
    end

    values = []
    for row in top_left.row .. bottom_right.row
      for col in top_left.col .. bottom_right.col
        values.append(runtime.get_cell(Primitives::CellAddress.new(row, col)))
      end
    end
    min = Float::INFINITY
    min_node = Primitives::Integer.new(0)
    for value in values
      if value == nil
        raise "Undefined Cell"
      end
      if value.raw_value < min
        min = value.raw_value
        min_node = value
      end
    end
    min_node
  end
  
  def visit_mean(node)
    top_left = node.top_left.visit(self)
    bottom_right = node.bottom_right.visit(self)
    if not (top_left.is_a?(Primitives::CellAddress) and bottom_right.is_a?(Primitives::CellAddress))
      raise "Invalid Cell Address: top_left is a #{top_left.class} and bottom_right is a #{bottom_right.class}. Both should be instances of Primitives::CellAddress."
    end

    values = []
    for row in top_left.row .. bottom_right.row
      for col in top_left.col .. bottom_right.col
        values.append(runtime.get_cell(Primitives::CellAddress.new(row, col)))
      end
    end
    total = 0
    for value in values
      if value == nil
        raise "Undefined Cell"
      end
      total += value.raw_value
       
    end
    Primitives::Float.new(total / values.length)
  end

  def visit_sum(node)
    top_left = node.top_left.visit(self)
    bottom_right = node.bottom_right.visit(self)
    if not (top_left.is_a?(Primitives::CellAddress) and bottom_right.is_a?(Primitives::CellAddress))
      raise "Invalid Cell Address: top_left is a #{top_left.class} and bottom_right is a #{bottom_right.class}. Both should be instances of Primitives::CellAddress."
    end

    values = []
    for row in top_left.row .. bottom_right.row
      for col in top_left.col .. bottom_right.col
        values.append(runtime.get_cell(Primitives::CellAddress.new(row, col)))
      end
    end
    total = 0
    for value in values
      if value == nil
        raise "Undefined Cell"
      end
      total += value.raw_value
       
    end
    Primitives::Integer.new(total)
  end

  def visit_for_each(node)
    top_left = node.start.visit(self)
    bottom_right = node.end.visit(self)
    if not (top_left.is_a?(Primitives::CellAddress) and bottom_right.is_a?(Primitives::CellAddress))
      raise "Invalid Cell Address: top_left is a #{top_left.class} and bottom_right is a #{bottom_right.class}. Both should be instances of Primitives::CellAddress."
    end
    for row in top_left.row .. bottom_right.row
      for col in top_left.col .. bottom_right.col
        @runtime.set_variable(node.var_name, @runtime.get_cell(Primitives::CellAddress.new(row, col)))
        val = node.block.visit(self)
      end
    end
    node.last = val
    return val
  end

  def visit_block(node)
    statements = node.statements
    val = 0
    statements.each do |statement|
      val = statement.visit(self)
    end
    val
  end

  def visit_assignment(node)
    value = node.r_val.visit(self)
    node.runtime.set_variable(node.var_name, value)
    value
  end

  def visit_reference(node)
    val = node.runtime.get_variable(node.var_name)
    if val == nil
      raise "Undefined Reference Error"
    end
    val
  end

  def visit_conditional(node)
    val = node.condition.visit(self)
    if val.raw_value == true
      c = node.then_block.visit(self)
    else
      c = node.else_block.visit(self)
    end
    node.last = c
    c

  end
end