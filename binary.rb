#------------------------------------------------
#BinaryTree
#------------------------------------------------

class BinaryTree
  attr_accessor :root

  #constructor
  def initialize(item)
    @root = item
  end

  #merge trees
  def merge(variable, subTree)
    self.traverseInorder(root) do |n|
      if n.left and n.left.val == variable
        n.left = subTree.root
        break
      elsif n.right and n.right.val == variable
        n.right = subTree.root
        break
      end
    end
  end

  #inorder tree traversal
  def traverseInorder(root, &block)
    if root
      if block_given?
        traverseInorder(root.left, &block)
        yield root
        traverseInorder(root.right, &block)
      else
        print("(") if root.left != nil
        traverseInorder(root.left)
        print(root.val.to_s)
        #return root.val if yield(root.val)
        traverseInorder(root.right)
        print(")") if root.right != nil
      end
    end
  end

  #postorder tree traversal
  def traversePostorder(root, &block)
    if root
      if block_given?
        traversePostorder(root.left, &block)
        traversePostorder(root.right, &block)
        yield root
      else
        print("(") if root.left != nil
        traversePostorder(root.left)
        traversePostorder(root.right)
        print(root.val)
        print(")") if root.right != nil
      end
    end
  end

  #postorder tree traversal
  def traversePreorder(root, &block)
    if root
      if block_given?
        yield root
        traversePreorder(root.left, &block)
        traversePreorder(root.right, &block)
      else
        print("(") if root.left != nil
        print(root.val)
        traversePreorder(root.left)
        traversePreorder(root.right)
        print(")") if root.right != nil
      end
    end
  end
end
