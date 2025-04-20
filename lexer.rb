require_relative "token.rb"
module Lexer
  class Lex 
    attr_reader :expression
    attr_reader :tokens
    attr_accessor :cur_start
    attr_reader   :cur_end
    attr_reader   :cur_text
    


  
    def initialize(expression)
      @expression = expression.gsub(/\s+/, "")
      @tokens = []
      @cur_start, @cur_end = 0, 0
      @cur_text = ""
    end


    def emitToken(type)
      token = Token::Token.new(type, cur_text, cur_start, cur_end)
      @tokens.append(token)
      @cur_text = ""
      @cur_start = @cur_end
      @cur_end = @cur_end

    end

    def capture()

      @cur_text = @cur_text + @expression[@cur_end]
      @cur_end = @cur_end  + 1
    end

    def has(char)
      char == @expression[@cur_end]
    end

    def has_digit()
      char = expression[@cur_end]
      (char =~ /\d/) == 0
    end

    def has_next()
      @cur_end < (@expression.length)

    end

    def lex()

      while has_next
        # Arithmetic Opearations
        if has('+')
          capture
          emitToken(:plus)
        
        elsif has('-')
          capture
          emitToken(:minus)
        
        elsif has('*')
          capture
          if has('*')
            capture
            emitToken(:exponent)
          else
            emitToken(:multiply)
          end
        
        elsif has('/')
          capture
          emitToken(:divide)
        
        elsif has('%')
          capture
          emitToken(:modulo)
        
        
        #Numbers
        elsif has_digit()
          while has_digit
            capture
          end
          if has('.')
            capture
            while has_digit
              capture
            end
            emitToken(:float)
          else
            emitToken(:integer)
          end
        

        #Relational Operators
        elsif has('<')
          capture
          if has('=')
            capture
            emitToken(:less_than_equal)
          elsif has('<')
            capture
            emitToken(:bitwise_l_shift)
          else
            emitToken(:less_than)
          end
        

        elsif has('>')
          capture
          if has('=')
            capture
            emitToken(:greater_than_equal)
          elsif has('>')
            capture
            emitToken(:bitwise_r_shit)
          else
            emitToken(:greater_than)
          end
        


        elsif has('!')
          capture
          if has('=')
            capture
            emitToken(:not_equals)
          end
        

        elsif has('=')
          capture
          if has('=')
            capture
            emitToken(:equal_to)
          end
        

        # Logical Operators
        elsif has('a')
          capture
          if has('n')
            capture
            if has('d')
              capture
              emitToken(:and)
            end
          end
        
  
        elsif has('n')
          capture
          if has('o')
            capture
            if has('t')
              capture
              emitToken(:not)
            end
          end
  
        elsif has('o')
          capture
          if has('r')
            capture
            emitToken(:or)
          end
        

        # Bitwise Operators
        elsif has('&')
          capture
            
          emitToken(:bitwise_and)
          
        

        elsif has ('|')
          capture
      
          emitToken(:bitwise_or)
          
        

        elsif has("~")
          capture
          emitToken(:bitwise_not)
        

        elsif has("^")
          capture
          emitToken(:bitwise_xor)
        
        # Parenthesis and Cell Value
        elsif has('(')
          capture
          emitToken(:open_parenthesis)
        

        elsif has('#')
          capture
          if has('[')
            capture
            emitToken(:r_value_open)
          end
        

        elsif has('[')
          capture
          emitToken(:l_value_open)
        

        elsif has(')')
          capture
          emitToken(:close_parenthesis)
        

        elsif has(']')
          capture
          emitToken(:cell_close)
        

        elsif has('f')
          capture
          if has('l')
            capture
            if has('t')
              capture
              emitToken(:int_to_float)
            end
          end
        
        elsif has('i')
          capture
          if has('n')
            capture
            if has('t')
              capture
              emitToken(:float_to_int)
            end
          end
        

        elsif has('s')
          capture
          if has('u')
            capture
            if has('m')
              capture
              emitToken(:stat_sum)
            end
          end
        

        elsif has('m')
          capture
          if has('a')
            capture
            if has('x')
              capture
              emitToken(:stat_max)
            end
          
          elsif has('e')
            capture
            if has('a')
              capture
              if has('n')
                capture
                emitToken(:stat_mean)
                
              end
            end
          elsif has('i')
            capture
            if has('n')
              capture
              emitToken(:stat_min)
            end
          end
        

        elsif has('m')
          capture
          if has('e')
            capture
            if has('a')
              capture
              if has('n')
                capture
                emitToken(:stat_mean)
              end
            end
          end
        

        elsif has('T')
          capture
          if has('r')
            capture
            if has('u')
              capture
              if has('e')
                capture
                emitToken(:boolean_true)
              end
            end
          end
        
        elsif has('F')
          capture
          if has('a')
            capture
            if has('l')
              capture
              if has('s')
                capture
                if has('e')
                  capture
                  emitToken(:boolean_false)
                end
              end
            end
          end

        elsif has(',')
          capture
          emitToken(:comma)
        
        else
          raise "Invalid Input - #{@expression[@cur_end]} from #{@cur_start} to #{@cur_end}"
          
        end
      end
    end
  end
end