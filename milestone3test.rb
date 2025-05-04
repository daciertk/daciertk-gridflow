require_relative "lexer.rb"
require_relative "parse.rb"
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
    runtime.set_cell(address, Primitives::Integer.new(row + col))
  end
end


text = ":count = 0; for :val in [0,0]..[3,2] :count = :count + :val; end;"
text2 = "if #[1,1] == 32 then 9 end;"
lexer = Lexer::Lex.new(text)
lexer.lex
tokens = lexer.tokens


parser = Parser::Parser.new(tokens, runtime)
block = parser.parse
value = block.visit(Evaluator.new(runtime))
puts value.visit(Serializer.new)



exit
evaluator = Evaluator.new(runtime)
set_var = Variable::Assignment.new("accum", Primitives::Integer.new(0), runtime)
set_var.visit(evaluator)
reference = Variable::Reference.new("accum", runtime)
value = Variable::Reference.new("value", runtime)
top_left = Cell::CellLValue.new(Primitives::Integer.new(0), Primitives::Integer.new(0))
bottom_right = Cell::CellLValue.new(Primitives::Integer.new(5), Primitives::Integer.new(5))

start = top_left.visit(evaluator)
end_ = bottom_right.visit(evaluator)
statement = [Variable::Assignment.new("accum", Arithmetic::Addition.new(reference, value), runtime)]
#statement = [Arithmetic::Addition.new(reference, value)]
block = Block::Block.new(statement)

for_each = For::ForEach.new("value", start, end_, block)

assignment = Variable::Assignment.new("accum", Primitives::Integer.new(4), runtime)
assignment.visit(evaluator)
val = for_each.visit(evaluator)
puts "val"
