require "./node"

#------------------------------------------------
#Constant Node
#------------------------------------------------

class Constant < Node
  def initialize(v, d)
    @val, @left, @right, @depth = v, nil, nil, d
  end
end
