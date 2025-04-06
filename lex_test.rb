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
lexer = Lexer::Lex.new("#[1 - 1, 0] < #[1 * 1, 1]")
lexer.lex
puts "Tokens"
lexer.tokens.each do |token|
  puts "#{token.type} #{token.source_text}"
end
tokens = lexer.tokens
parser = Parser::Parser.new(tokens)
node = parser.parse
puts "node"
p node
p node.visit(Serializer.new)

p node.visit(Evaluator.new(runtime)).visit(Serializer.new)
