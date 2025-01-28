require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"

int_node = Primitives::Integer.new(2)
int2_node = Primitives::Integer.new(4)
int3_node = Primitives::Integer.new(7)

float_node = Primitives::Float.new(3.5)
boolean_node = Primitives::Boolean.new(true)
string_node = Primitives::String.new("String Node")
cell_node = Primitives::CellAddress.new(3, 6)

add = Arithmetic::Addition.new(int_node, float_node)
add2 = Arithmetic::Addition.new(int2_node, int3_node)
add2_nodes = Arithmetic::Addition.new(add, add2)
puts add2_nodes.visit(Serializer.new())
nodes = [int_node, float_node, boolean_node, string_node, cell_node]
nodes.each do |node|
  puts(node.visit(Serializer.new()))
end
=begin
  
rescue 
end

text = node.visit(Serializer.new())
puts text
=end