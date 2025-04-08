module Parser
  class Parser
    attr_reader :tokens
    # What does attr do?
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
      # An expression should only be one thing. There shouldn't be a sequence
      # of them at this point.
      while @cur < @tokens.length - 1
        node = exp()
      end
      node
    end

    def not_end
      (@cur < @tokens.length - 1)
    end

    def has_logical
      has(:greater_than) || has(:greater_than_equal) || has(:less_than) || has(:less_than_equal)||
      has(:equal_to) || has(:not_equals)
    end
    def exp()
      # This is an ambigious abbreviation. Exponentiation? Expression?
      logical
    end

    def showError
      token = @tokens[@cur]
      raise "Syntax Error - Invalid Token #{token.source_text} from #{token.start} to #{token.end}"
      
    end

    def logical()
      # This method demonstrates the recursive descent pattern for
      # left-associative operators nicely: grab the left operand from the rung
      # below, and loop through to collect up right operands as needed.
      left = notExp()
      while not_end and (has(:and) or has(:or))
        if has(:and)
          advance
          right = logical()
          return Logical::And.new(left, right)
        elsif has(:or)
          advance
          right = logical()
          return Logical::Or.new(left, right)
        end
      end
      left
    end

    def notExp
      if has(:not)
        # Use recursion to allow these to chain, not an iteration.
        while not_end and has(:not)
          if has(:not)
            advance
            node = comparison()
            return Logical::Not.new(node)
          end
        end
      end
      
      comparison
    end

    
    def comparison()
      left = bitwiseOr
      if left == nil
        showError
      end
      while not_end and has_logical 
        if has(:greater_than)
          advance
          right = bitwiseOr
          if right == nil
            showError 
          end
          return Relational::GreaterThan.new(left, right)
        elsif has(:greater_than_equal)
          advance
          right = bitwiseOr
          if right == nil
            showError 
          end
          return Relational::GreaterThanEqualTo.new(left, right)
        elsif has(:less_than)
          advance
          right = bitwiseOr
          if right == nil
            showError 
          end
          return Relational::LessThan.new(left, right)
        elsif has(:less_than_equal)
          advance
          right = bitwiseOr
          if right == nil
            showError 
          end
          return Relational::LessThanEqualTo.new(left, right)
        elsif has(:equal_to)
          advance
          right = bitwiseOr
          if right == nil
            showError 
          end
          return Relational::Equals.new(left, right)
        elsif has(:not_equals)
          advance
          right = bitwiseOr
          if right == nil
            showError 
          end
          return Relational::NotEquals.new(left, right)
        end
      end
      left
    end


    def bitwiseOr
      left = bitwiseXor
      if left == nil 
        showError
      end
      while not_end and has(:bitwise_or)
        if has(:bitwiseOr)
          advance
          right = 
          if right == nil
            showError
          end
          return Bitwise::BitwiseOr.new(left, right)
        end
      end
      left
    end


    def bitwiseXor
      left = bitwiseAnd
      if left == nil 
        showError
      end
      while not_end and has(:bitwise_xor)
        if has(:bitwise_xor)
          advance
          right = bitwiseXor
          if right == nil
            showError
          end
          return Bitwise::BitwiseXor.new(left, right)
        end
      end
      left
    end

    def bitwiseAnd
      left = bitwiseShift
      if left == nil
        showError
      end 
      while not_end and has(:bitwise_and)
        if has(:bitwise_and)
          advance
          right = bitwiseAnd
          if right == nil
            showError
          end
          return Bitwise::BitwiseAnd.new(left, right)
        end
      end
      left
    end

    def bitwiseShift 
      left = addExp
      if left == nil
        showError
      end
      while not_end and (has(:bitwise_r_shit) or has(:bitwise_l_shift))
        if has(:bitwise_l_shift)
          advance
          right = bitwiseShift
          if right == nil
            showError
          end
          return Bitwise::BitwiseLShift.new(left, right)
        elsif has(:bitwise_r_shit)
          advance
          right = bitwiseShift
          if right == nil
            showError
          end
          return Bitwise::BitwiseRShift.new(left, right)
        end
      end
      left
    end

    def addExp()
      left = mulExp()
      while (@cur < @tokens.length - 1) and (has (:plus) or has (:minus))
        if has(:plus)
          advance
          right = mulExp()
          left = Arithmetic::Addition.new(left, right)
          if left == nil or right == nil
            showError
          end
        elsif has(:minus)
          advance
          right = mulExp()
          left = Arithmetic::Subtraction.new(left, right)
          if left == nil or right == nil
            showError
          end
        end
      
      end
 
      left
    
    end

    def mulExp()
      left = expExp()
      # Build the index check into all the has methods.
      while (@cur < @tokens.length - 1) and (has (:multiply) or has (:divide) or has (:modulo))
        if has(:multiply)
          advance
          right = expExp()
          left = Arithmetic::Multiplication.new(left, right)
          # The recursive call should raise the exception. If you ask a parse
          # method to parse, and it can't do it, it has the responsibility to
          # yell.
          if left == nil or right == nil
            showError
          end
        elsif has(:divide)
          advance
          right = expExp()
          left = Arithmetic::Division.new(left, right)
          if left == nil or right == nil
            showError
          end
        elsif has(:modulo)
          advance
          right = expExp()
          left = Arithmetic::Modulo.new(left, right)
          if left == nil or right == nil
            showError
          end
        end
      end

      left
    end

    def expExp
      left = priExp()
      # Both loops and recursion repeat code. You don't need both. The
      # right-associativity of exponentiation means that recursion is
      # appropriate here. You want to allow further exponents in the operand.
      # However, because the recursion is going to repeatedly scan for nested
      # operations, this loop will never run more than once. You could replace
      # it with a conditional statement.
      while not_end and (has :exponent)
        if has(:exponent)
          advance
          right = expExp
          left = Arithmetic::Exponentiation.new(left, right)
          if left == nil or right == nil
            showError
          end
        end
      end
    
      left
    end

    def priExp()
      if not_end and has(:open_parenthesis)
        advance
        while not has(:close_parenthesis)
          node = exp()
        end
        advance
        return node
      

      elsif not_end and has(:minus)
        advance
        tree = priExp()
        node = Arithmetic::Negation.new(tree)
        if tree == nil
          showError
        end
        return node
      end

      if not_end and (has(:int_to_float) or has(:float_to_int) or has(:integer) or has(:float) or has(:boolean_false) or has(:boolean_true))
        number()
      elsif not_end and (has(:l_value_open) or has(:r_value_open) or 
        has(:stat_max) or has(:stat_min) or has(:stat_sum) or has(:stat_mean))
        gridValues()
      end
    end

    def gridValues()
      if has(:l_value_open)
        cellLValue
      elsif has(:r_value_open)
        cellRValue
      elsif has(:stat_max)
        statMax
      elsif has(:stat_sum)
        statSum
      elsif has(:stat_mean)
        statMean
      elsif has(:stat_min)
        statMin 
      end
    end

    def number()
      if has(:integer)
        advance
        token = Primitives::Integer.new(@tokens[cur].source_text.to_i)
        return token
      elsif has(:float)
        advance
        node = Primitives::Float.new(@tokens[cur].source_text.to_f)
      elsif has(:boolean_true) or has(:boolean_false)
        boolean()
      elsif has(:l_value_open)
        cellLValue
      elsif has(:float_to_int)
        castFloat
      elsif has(:int_to_float)
        castInt
      else
        showError
      end
    end

    def castFloat()
      advance
      node = priExp
      cast = Cast::FloatToInt.new(node)
      if node == nil
        showError
      end
      return cast
    end

    def castInt()
      advance
      node = priExp
      cast = Cast::IntToFloat.new(node)
      if node == nil
        showError
      end
      return cast
    end

    def cellLValue
      advance
      left = addExp
      if has(:comma)
        advance
        right = addExp
        if has(:cell_close)
          advance
          if left == nil or right == nil
            showError
          end
          return Cell::CellLValue.new(left, right)
        end
      end
    end
    
    def cellRValue
      advance
      left = addExp
      if has(:comma)
        advance
        right = addExp
        if has(:cell_close)
          advance
          node = Cell::CellRValue.new(left, right)
          if left == nil or right == nil
            showError
          end
          return node
        end
      end
    end 

    def statMax
      advance
      if has(:open_parenthesis)
        advance
        if has(:l_value_open)
          left = cellLValue
          if has(:comma)
            advance
            if has(:l_value_open)
              right = cellLValue
              node = Statistical::Max.new(left, right)
              if has(:close_parenthesis)
                advance
                if left == nil or right == nil
                  return node
                end
                return node
              end
            end
          end
        end
      end
    end

    def statSum
      advance
      if has(:open_parenthesis)
        advance
        if has(:l_value_open)
          left = cellLValue
          if has(:comma)
            advance
            if has(:l_value_open)
              right = cellLValue
              node = Statistical::Sum.new(left, right)
              if has(:close_parenthesis)
                advance
                if left == nil or right == nil
                  return node
                end
                return node
              end
            end
          end
        end
      end
    end

    def statMean
      advance
      # Thorough syntax checking!
      if has(:open_parenthesis)
        advance
        if has(:l_value_open)
          left = cellLValue
          if has(:comma)
            advance
            if has(:l_value_open)
              right = cellLValue
              node = Statistical::Mean.new(left, right)
              if has(:close_parenthesis)
                advance
                if left == nil or right == nil
                  return node
                end
                return node
              end
            end
          end
        end
      end
    end

    def statMin
      advance
      if has(:open_parenthesis)
        advance
        if has(:l_value_open)
          left = cellLValue
          if has(:comma)
            advance
            if has(:l_value_open)
              right = cellLValue
              node = Statistical::Min.new(left, right)
              if has(:close_parenthesis)
                advance
                if left == nil or right == nil
                  return node
                end
                return node
              end
            end
          end
        end       

      end
    end

    def boolean()
      if has(:boolean_true)
        advance
        node = Primitives::Boolean.new(true)
        return node
      elsif has(:boolean_false)
        advance
        node = Primitives::Boolean.new(false)
        return node
      end
    end
  end

end
