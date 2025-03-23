require_relative "primitives.rb"
require_relative "serializer.rb"
require_relative "evaluator.rb"
require_relative "arithmetic.rb"
require_relative "runtime.rb"
runtime = Runtime::Runtime.new(6, 6)
# Add a bunch of integer primitives to the grid
for row in 0..5
  for col in 0..5
    address = Primitives::CellAddress.new(row, col)
    node = Primitives::Integer.new(row + col)
    #p address
    runtime.set_cell(address, node)
  end
end

puts "Populated Grid"
for row in 0..4
  for col in 0..4
    address = Primitives::CellAddress.new(row, col)
    value = runtime.get_cell(address)
    print value.visit(Serializer.new) + " " 
  end
  puts
end
puts 
puts "Arithmetic"
int_7 = Primitives::Integer.new(7)
int_4 = Primitives::Integer.new(4)
int_3 = Primitives::Integer.new(3)
int_12 = Primitives::Integer.new(12)
mult_node = Arithmetic::Multiplication.new(int_7, int_4)
add_node = Arithmetic::Addition.new(mult_node, int_3)
mod_node = Arithmetic::Modulo.new(add_node, int_12)
value =  mod_node.visit(Evaluator.new(runtime))

puts "#{mod_node.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts 


puts "Arithmetic negation and cell rvalues"
cell1 = Cell::CellRValue.new(Primitives::Integer.new(3), Primitives::Integer.new(1))
cell2 = Cell::CellRValue.new(Primitives::Integer.new(2), Primitives::Integer.new(1))
negated_cell = Arithmetic::Negation.new(cell2)
mult = Arithmetic::Multiplication.new(cell1, negated_cell)
value = mult.visit(Evaluator.new(runtime))
puts "#{mult.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts 

puts "Rvalue lookup and shift"
int_1 = Primitives::Integer.new(1)
int_2 = Primitives::Integer.new(1)
add_node = Arithmetic::Addition.new(int_1, int_2)
cell = Cell::CellRValue.new(add_node, Primitives::Integer.new(4))
shift = Bitwise::BitwiseLShift.new(cell, Primitives::Integer.new(3))
value = shift.visit(Evaluator.new(runtime))
puts "#{shift.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts

puts "Rvalue lookup and comparison"
cell1 = Cell::CellRValue.new(Primitives::Integer.new(0), Primitives::Integer.new(0))
cell2 = Cell::CellRValue.new(Primitives::Integer.new(0), Primitives::Integer.new(1))
comparison = Relational::LessThan.new(cell1, cell2)
value = comparison.visit(Evaluator.new(runtime))
puts "#{comparison.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts

puts "Logic and Comparison"
greater_than = Relational::GreaterThan.new(Primitives::Float.new(3.3), Primitives::Float.new(3.2))
not_cell = Logical::Not.new(greater_than)
value = not_cell.visit(Evaluator.new(runtime))
puts "#{not_cell.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts 

puts "Double Negation"
int_1 = Primitives::Integer.new(6)
int_2 = Primitives::Integer.new(8)
mult = Arithmetic::Multiplication.new(int_1, int_2)
negated1 = Arithmetic::Negation.new(mult)
negated2 = Arithmetic::Negation.new(negated1)
value = negated2.visit(Evaluator.new(runtime))
puts "#{negated2.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts 

puts "Bitwise Operators"
not_5 = Bitwise::BitwiseNot.new(Primitives::Integer.new(5))
not_8 = Bitwise::BitwiseNot.new(Primitives::Integer.new(8))
or_cell = Bitwise::BitwiseOr.new(not_5, not_8)
value = or_cell.visit(Evaluator.new(runtime))
puts "#{or_cell.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts 

puts "Sum"
top_left = Cell::CellLValue.new(Primitives::Integer.new(1), Primitives::Integer.new(2))
bottom_right = Cell::CellLValue.new(Primitives::Integer.new(5), Primitives::Integer.new(3))
sum = Statistical::Sum.new(top_left, bottom_right)
value = sum.visit(Evaluator.new(runtime))
puts "#{sum.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts

puts "Mean"
top_left = Cell::CellLValue.new(Primitives::Integer.new(1), Primitives::Integer.new(2))
bottom_right = Cell::CellLValue.new(Primitives::Integer.new(5), Primitives::Integer.new(3))
mean = Statistical::Mean.new(top_left, bottom_right)
value = mean.visit(Evaluator.new(runtime))
puts "#{mean.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts

puts "Max"
top_left = Cell::CellLValue.new(Primitives::Integer.new(1), Primitives::Integer.new(2))
bottom_right = Cell::CellLValue.new(Primitives::Integer.new(5), Primitives::Integer.new(3))
max = Statistical::Max.new(top_left, bottom_right)
value = max.visit(Evaluator.new(runtime))
puts "#{max.visit(Serializer.new)} = #{value.visit(Serializer.new)}"
puts

puts "Casting"
float = Cast::IntToFloat.new(Primitives::Integer.new(7))
divided = Arithmetic::Division.new(float, Primitives::Float.new(2))
value = divided.visit(Evaluator.new(runtime))
puts "#{divided.visit(Serializer.new)} = #{value.visit(Serializer.new)}"


puts "Type Error Catching"
puts 
puts "Float / Integer arithmetic"
node_1 = Primitives::Integer.new(7)
node_2 = Primitives::Float.new(5.3)
mult_node = Arithmetic::Multiplication.new(node_1, node_2)
begin
  puts mult_node.visit(Serializer.new)
  mult_node.visit(Evaluator.new(runtime))
  
rescue => e
  puts "Operation Failed: #{e.message}"
end

puts 

puts "Accesssing invalid Cell Value"
cell1 = Cell::CellRValue.new(Primitives::Integer.new(8), Primitives::Integer.new(1))
begin
  puts cell1.visit(Serializer.new)
  cell1.visit(Evaluator.new(runtime))
  
rescue => e
  puts "Operation Failed: #{e.message}"
end

puts "Bitwise among non numbers"
cell1 = Cell::CellRValue.new(Primitives::Integer.new(0), Primitives::Integer.new(1))
cell2 = Bitwise::BitwiseLShift.new(cell1, Primitives::Float.new(4))
begin
  puts cell2.visit(Serializer.new)
  cell2.visit(Evaluator.new(runtime))
  
rescue => e
  puts "Operation Failed: #{e.message}"
end