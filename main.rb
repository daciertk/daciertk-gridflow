require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"

int_node = Primitives::Integer.new(5)
int2_node = Primitives::Integer.new(2)
int3_node = Primitives::Integer.new(7)

float_node = Primitives::Float.new(7.5)
float2_node = Primitives::Float.new(3.3)

boolean_node = Primitives::Boolean.new(true)
string_node = Primitives::String.new("String Node")
cell_node = Primitives::CellAddress.new(3, 6)

add_node = Arithmetic::Addition.new(int_node, int2_node)
add_nodes = Arithmetic::Addition.new(add_node, int_node)

sub_node = Arithmetic::Subtraction.new(int_node, int2_node)
sub_nodes = Arithmetic::Subtraction.new(sub_node, int_node)

mult_node = Arithmetic::Multiplication.new(int_node, int2_node)
mult_nodes = Arithmetic::Multiplication.new(mult_node, int_node)


div_node = Arithmetic::Division.new(int_node, int2_node)
div_nodes = Arithmetic::Division.new(div_node, int_node)


negation = Arithmetic::Negation.new(int_node)


exp_node = Arithmetic::Exponentiation.new(int_node, int2_node)
mod_node = Arithmetic::Modulo.new(int2_node, int_node)


bool_node = Primitives::Boolean.new(true)
bool2_node = Primitives::Boolean.new(false)

and_node = Logical::And.new(bool2_node, bool_node)
or_node = Logical::Or.new(bool_node, bool2_node)
not_node = Logical::Not.new(and_node)


bitwise_and = Bitwise::BitwiseAnd.new(int_node, int2_node)
bitwise_or = Bitwise::BitwiseOr.new(int_node, int2_node)
bitwise_not = Bitwise::BitwiseNot.new(int_node)
bitwise_l = Bitwise::BitwiseLShift.new(int_node, int2_node)
bitwise_r = Bitwise::BitwiseRShift.new(int2_node, int_node)
bitwise_x = Bitwise::BitwiseXor.new(int_node, int2_node)

bit =  [bitwise_and, bitwise_or, bitwise_not, bitwise_l, bitwise_r, bitwise_x]
bool = [and_node, or_node, not_node]
#puts negation.visit(Serializer.new())

#puts mult_node.visit(Evaluator.new)
mult = [div_node, div_nodes]
nodes = [exp_node, mod_node]
bit.each do |node|
  #puts node
  
  #puts eval
  puts node.visit(Serializer.new())
  val = node.visit(Evaluator.new)
  puts val.visit(Serializer.new)


end


'''
add = Arithmetic::Modulo.new(int_node, float_node)
add2 = Arithmetic::Division.new(int2_node, int3_node)
add2_nodes = Arithmetic::Addition.new(int_node, string_node)
added = Evaluator.new(add2_nodes)
puts "added #{add2_nodes.visit(Serializer.new())}"
puts add2_nodes.visit(Serializer.new())
nodes = [int_node, float_node, boolean_node, string_node, cell_node]
nodes.each do |node|
  puts(node.visit(Serializer.new()))
end
puts(Serializer.new(add2_nodes.visit(Evaluator.new())))
added = add_nodes.visit(Evaluator.new())
puts added.visit(Serializer.new())

'''