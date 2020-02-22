require "./node"

#------------------------------------------------
#Operator Node
#------------------------------------------------

class Operator < Node
  def initialize(v, l, r, d)
    @val, @left, @right, @depth = v, l, r, d
  end

  def name()
    case val
    when "+"
      return "add"
    when "-"
      return "minus"
    when "*"
      return "multiply"
    when "/"
      return "divide"
    when "^"
      return "power"
    else
      return nil
    end
  end


  def solve()
    if left.is_a?(Constant) and right.is_a?(Constant)
      case val
      when "*" 
        return left.val * right.val
      when "/" 
        return left.val / right.val
      when "+" 
        return left.val + right.val
      when "-" 
        return left.val - right.val
      when "^" 
        return left.val ** right.val
      else
        return nil
      end
    elsif left.is_a?(Constant) #and !right.is_a?(Operator)
      case val
      when "*" 
        return 0              if left.val == 0
        return right          if left.val == 1
      when "+" 
        return right          if left.val == 0
      # when "-" 
      #   return right   if left.val == 0
      when "^" 
        return 0              if left.val == 0
        return 1              if left.val == 1
      else
        return nil
      end
    elsif right.is_a?(Constant) #and !left.is_a?(Operator)
      case val
      when "*" 
        return 0              if right.val == 0
        return left           if right.val == 1
      when "+" 
        return left           if right.val == 0 
      when "-" 
        return left           if right.val == 0
      when "^" 
        return 1              if right.val == 0
        return left           if right.val == 1
      else
        return nil
      end
    end
  end
end