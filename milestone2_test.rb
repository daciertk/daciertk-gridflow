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


tests = [
  ["Arithmetic:", "3 + ~7"],
  ["Rvalue lookup and shift:", "#[0, 0] + 3"],
  ["Rvalue lookup and comparison:", "#[1 - 1, 0] < #[1 * 1, 1]"],
  ["Logic and comparison:", "(5 > 3) and not (2 > 8)"],
  ["Sum:", "1 + sum([0, 0], [2, 1])"],
  ["Casting:", "flt(10) / 4.0"],
  ["Exponentiation:", "2 ** 3 ** 2"],
  ["Negation and bitwise and:", "45 & ---(1 + 3)"],
  ["Lexing error - Invalid character:", ": - 5"],
  ["Parsing error - Unexpected Token:", "3 + 45 + "]
  
]

puts "Example Tokens"
lexer = Lexer::Lex.new(tests[0][1])
lexer.lex
tokens = lexer.tokens
tokens.each do |t|
  p t 
end
tests.each do |test|
  lexer = Lexer::Lex.new(test[1])
  begin 
    lexer.lex
    tokens = lexer.tokens
    parser = Parser::Parser.new(tokens)
    
    ast = parser.parse
    puts "#{test[0].ljust(30)} #{ast.visit(Serializer.new).ljust(30)} = #{ast.visit(Evaluator.new(runtime)).visit(Serializer.new).ljust(30)}"
  
  rescue => e
    puts e.message
    
  end

end

exit

tests.each do |test|
  lexer = Lexer::Lex.new(test[1])
  begin 
    lexer.lex
  rescue => e
    puts e.message
    
  end
  tokens = lexer.tokens
  parser = Parser::Parser.new(tokens)
  
  begin 
    ast = parser.parse
    puts "#{test[0].ljust(30)} #{ast.visit(Serializer.new).ljust(30)} = #{ast.visit(Evaluator.new(runtime)).visit(Serializer.new).ljust(30)}"
  rescue => e
    puts e.message
  end
end