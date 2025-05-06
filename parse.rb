require_relative "token.rb"
module Parser
  class Parser
    attr_reader :tokens
    attr        :cur
    attr        :runtime

    def initialize(tokens, runtime)
      
      @tokens = tokens
      @cur = -1
      @runtime = runtime


    end

    def has(type)
      @tokens[@cur + 1].type == type
      #@statements[@cur_statement][@cur + 1].type == type
    end

    def advance
      @cur += 1
    end

    def not_end
      (@cur < @tokens.length - 1)
      #(@cur < @statements[@cur_statement].length - 1)
    end

    def has_logical
      has(:greater_than) || has(:greater_than_equal) || has(:less_than) || has(:less_than_equal)||
      has(:equal_to) || has(:not_equals)
    end

    def parse
      # Why not let the method make the block?
      Block::Block.new(parse_statement)
    end
  
    def parse_statement
      # This parses more than a statement. Why not call it block?
      values = []
      while (not_end and not has(:end_block) and not has(:end))
        val = conditional
        values.append(val)
        advance
  
      end
      
      values
    end

    # Our language doesn't really have pure statements. Everything produces a
    # value. You could put loops and conditionals in levelN so that you can
    # embed them in other expressions. All items in that level are
    # non-associative: they don't appear next to each other. Assignments can be
    # expressions too. When they produce a value, you chain them. For example,
    # "a = b = 7". They are generally the lowest precedence.
    def conditional 
      if not_end and has(:if)
        advance
        cond = logical
      
        if not_end and has(:then)
          advance
          then_statement = exp
        end
        else_statement = Primitives::Integer.new(0)
        if not_end and has(:else)
          advance
          else_statement = exp
        end
        if has(:end)
          advance
          return Conditional::Conditional.new(cond, then_statement, else_statement)
        end
      end
      for_each
    end

    def for_each
      if not_end and has(:for)
        advance
        if has(:variable)
          advance
          var_name = @tokens[@cur].source_text
          if has(:in)
            advance
            start = cellLValue
            if has(:rangeID)
              advance
              end_cell = cellLValue
              
          
              block = parse
              if has(:end)
                advance
              
                return For::ForEach.new(var_name, start, end_cell, block)
              end
            end
          else
            puts"fail"
          end
        else
          puts"fail"
        end
      
  
      end
      variable
    end



    def variable 
      if has(:variable)
        advance
        var_name = @tokens[@cur].source_text
        
        if not_end and has(:assignment)
          advance
          value = exp()
          return Variable::Assignment.new(var_name, value, runtime)
        else
          return Variable::Reference.new(var_name, runtime)
        end

      end
      exp
    end
    def exp()
      logical
    end

    def showError
      p @cur_statement
      p @cur
      token = @tokens[@cur]
      raise "Syntax Error - Invalid Token #{token.source_text} from #{token.start} to #{token.end}"
      
    end

    def logical()
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
        while not_end and has(:not)
          if has(:not)
            advance
            node = comparison()
            return Logical::Not.new(node)
          
          elsif has(:bitwise_not)
            advance
            node = comparison
            return Bitwise::BitwiseNot.new(node)
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
      while (not_end) and (has (:plus) or has (:minus))
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
      while (not_end) and (has (:multiply) or has (:divide) or has (:modulo))
        if has(:multiply)
          advance
          right = expExp()
          left = Arithmetic::Multiplication.new(left, right)
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

      if not_end and (has(:int_to_float) or has(:float_to_int) or has(:integer) or has(:float) or has(:boolean_false) or has(:boolean_true) or has(:variable))
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
        token = Primitives::Integer.new(@tokens[@cur].source_text.to_i)
        return token
      elsif has(:float)
        advance
        node = Primitives::Float.new(@tokens[@cur].source_text.to_f)
      elsif has(:boolean_true) or has(:boolean_false)
        boolean()
      elsif has(:l_value_open)
        cellLValue
      elsif has(:float_to_int)
        castFloat
      elsif has(:int_to_float)
        castInt
      elsif has(:variable)
        variable
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
