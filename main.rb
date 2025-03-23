require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"
require_relative "runtime.rb"
puts "test"
runtime = Runtime::Runtime.new(5, 5)
int_node = Primitives::Integer.new(5)
int2_node = Primitives::Integer.new(2)
int3_node = Primitives::Integer.new(7)

float_node = Primitives::Float.new(7.5)
float2_node = Primitives::Float.new(3.3)

boolean_node = Primitives::Boolean.new(true)
string_node = Primitives::String.new("String Node")
cell_node = Primitives::CellAddress.new(3, 6)
sub_node = Arithmetic::Subtraction.new(int_node, int2_node)
add_node = Arithmetic::Addition.new(int_node, int2_node)
add_nodes = Arithmetic::Addition.new(add_node, int_node)
added = add_nodes.visit(Evaluator.new(runtime))

puts "testing float to int"
puts float_node.visit(Serializer.new)
castf = Cast::FloatToInt.new(float_node)
castedi = castf.visit(Evaluator.new(runtime))
puts castedi.visit(Serializer.new)

puts "testing int to float"
puts int_node.visit(Serializer.new)
casti = Cast::IntToFloat.new(int_node)
castedf = casti.visit(Evaluator.new(runtime))
puts castedf.visit(Serializer.new)

'''
puts "added #{add_nodes.visit(Serializer.new())}"
puts added.visit(Serializer.new)


# int_node = Cast::IntToFloat.new(int_node)

grt = Relational::GreaterThanEqualTo.new(add_node, add_nodes)
puts "casting"
casti = Cast::IntToFloat.new(int_node)

castf = Cast::FloatToInt.new(float_node)
puts "evaluating float to int"
castedi = castf.visit(Evaluator.new(runtime))
puts "evaluating int to float"
castedf = casti.visit(Evaluator.new(runtime))
puts "testing casting"
puts castedi.visit(Serializer.new)
puts castedf.visit(Serializer.new)
puts "over"
'''
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
puts "testing grid"
puts mult_node.visit(Serializer.new)
runtime = Runtime::Runtime.new(5, 5)
celladdr = Primitives::CellAddress.new(0, 0)
runtime.set_cell(celladdr, mult_node)

for row in 0..4
  for col in 0..4
    address = Primitives::CellAddress.new(row, col)
    node = Primitives::Integer.new(row + col)
    #p address
    runtime.set_cell(address, node)
  end
end
for row in 0..4
  for col in 0..4
    address = Primitives::CellAddress.new(row, col)
    value = runtime.get_cell(address)
    print value.visit(Serializer.new) + " " 
  end
  puts
end
top_left = Cell::CellLValue.new(Primitives::Integer.new(0), Primitives::Integer.new(0))
bottem_right = Cell::CellLValue.new(Primitives::Integer.new(4), Primitives::Integer.new(4))
p top_left
p bottem_right
min = Statistical::Mean.new(top_left, bottem_right)
max_value = min.visit(Evaluator.new(runtime))
puts max_value.visit(Serializer.new)
cell_value = runtime.get_cell(celladdr)

puts cell_value.visit(Serializer.new)
puts "rval"
rVal = Cell::CellRValue.new(Primitives::Integer.new(0),Primitives::Integer.new(0) )
puts rVal.visit(Evaluator.new(runtime)).visit(Serializer.new)

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