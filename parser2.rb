module Parser
  class Parser
    attr_reader :tokens
    attr        :cur

    def initialize(tokens)
      @tokens = tokens
      @cur = -1
    end

    def has(type)
      @tokens[@cur + 1].type == type
    end

    def advance
      @cur += 1
    end

    def parse 
      while @cur < @tokens.length - 1
        node = exp()
      end
      node
    end

    def not_end
      (@cur < @tokens.length - 1)
    end

    def exp()
      
      addExp
    end

    def addExp()
      p @tokens[@cur]
      left = mulExp()
      p "left"
      p left
      p @cur
      p @tokens.length
      while (@cur < @tokens.length - 1) and (has (:plus) or has (:minus))
        if has(:plus)
          advance
          puts "left"
          p left
          right = mulExp()
          puts "+"
          left = Arithmetic::Addition.new(left, right)
          p left
        elsif has(:minus)
          advance
          right = mulExp()
          left = Arithmetic::Subtraction.new(left, right)
        end
      
      end
      p left
      left
    
    end

    def mulExp()
      left = expExp()
      while (@cur < @tokens.length - 1) and (has (:multiply) or has (:divide) or has (:modulo))
        if has(:multiply)
          advance
          right = expExp()
          left = Arithmetic::Multiplication.new(left, right)
        elsif has(:divide)
          advance
          right = expExp()
          left = Arithmetic::Division.new(left, right)
        elsif has(:modulo)
          advance
          right = expExp()
          left = Arithmetic::Modulo.new(left, right)
        end
      end
      left
    end

    def expExp
      left = priExp()
      while not_end and (has :exponent)
        if has(:exponent)
          advance
          right = expExp
          left = Arithmetic::Exponentiation.new(left, right)
        end
      end
      left
    end

    def priExp()
      if has(:open_parenthesis)
        advance
        while not has(:close_parenthesis)
          node = exp()
        end
        advance
        return node
      

      elsif has(:minus)
        advance
        tree = priExp()
              node = Arithmetic::Negation.new(tree)
        return node
      end

      if has(:integer) or has(:float)
        number()
      elsif has(:l_value_open) or has(:r_value_open) or 
        has(:stat_max) or has(:stat_min) or has(:stat_sum) or has(:stat_mean)
        gridValues()
      end


    end


    def number()
      if has(:integer)
        advance
        p "num"
        token = Primitives::Integer.new(@tokens[cur].source_text.to_i)
        p token
        p @tokens[@cur]
        return token
      elsif has(:float)
        advance
        node = Primitives::Float.new(@tokens[cur].source_text.to_f)
      end

    end

  end

end
