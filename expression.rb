require "./binary"

#------------------------------------------------
#ExpressionTree
#------------------------------------------------


class ExpressionTree < BinaryTree
  #constructor
  def initialize(line)
    @root = recursive(line, 0)
  end

  #inorder tree traversal
  def printInorder(root)
    traverseInorder(root)
    # self.traverseInorder(root) do |n|
    #     if n.is_a?(Operator)
    #       print "("
    #       print n.left.val.to_s if not n.left.is_a?(Operator)
    #       print n.val
    #       print n.right.val.to_s if not n.right.is_a?(Operator)
    #       print ")"
    #     end
    # end
  end

  #postorder tree traversal
  def printPostorder(root)
    traversePostorder(root)
    # self.traversePostorder(root) do |n|
    #   print("(") if n.is_a(Variable) or n.is_a(Constant)
    #   print(n.val)
    #   print(")") if root.right != nil
    # end
  end

  #postorder tree traversal
  def printPreorder(root)
    traversePreorder(root)
    # self.traversePreorder(root) do |n|
    #   print("(") if n.left != nil
    #   print(n.val)
    #   print(")") if root.right != nil
    # end
  end
  
  #display structure
  def displayStructure(root)
    self.traversePreorder(root) do |n|
      print("| " * n.depth) if n.depth != nil and n.depth > 1
      print("==> ")
      puts(n.val) if n.is_a?(Constant) or n.is_a?(Variable)
      puts(n.name) if n.is_a?(Operator)
    end
  end

  def recursive(line, depth)
    i = getOperator(line)
    if i > 0 and i < line.length and line.length > 3
      depth += 1
      lt = line[i - 1] #value left to operator
      rt = line[i + 1] #value right to operator
      if lt == ")"
        #recursive left
        left = recursive(line[1...i - 1], depth)
      else
        #base left
        if lt.to_i.to_s == line[i - 1] #true if a number
          left = Constant.new(lt.to_i, depth + 1)
        else
          left = Variable.new(lt, depth + 1)
        end
      end
      if rt == "("
        #recursive right
        right = recursive(line[i + 1...line.length - 1], depth)
      else
        #base right
        if rt.to_i.to_s == line[i + 1] #true if a number
          right = Constant.new(rt.to_i, depth + 1)
        else
          right = Variable.new(rt, depth + 1)
        end
      end
      return Operator.new(line[i], left, right, depth)
    end
    return nil
  end

  #index of the current root operator
  def getOperator(line)
    #ignore left and right parentheses
    char = 1
    length = line.length - 1
    bracket = 0
    while char < length
      if line[char] == "("
        bracket += 1
      elsif line[char] == ")"
        bracket -= 1
      end
      if bracket == 0
        return char + 1
      end
      char += 1
    end
    return -1
  end

  #prune nodes
  def simplify(root)
    if root
      if root.is_a?(Operator)
        root.left = simplify(root.left)
        root.right = simplify(root.right)
        if solution = root.solve
          # puts(solution)
          # print(root.left.val.class)
          # puts(root.left.val)
          # print(root.right.val.class)
          # puts(root.right.val)
          
          #check = (solution.to_i.to_s == solution.to_s)
          if solution.is_a? Integer
            # puts "constant"
            root = Constant.new(solution, root.depth) 
          else
            # puts "variable"
            root = solution
          end
        end
      end
    end
    return root
  end

end

