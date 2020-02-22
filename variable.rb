require "./node"

#------------------------------------------------
#Variable Node
#------------------------------------------------

class Variable < Node
  def initialize(v, d)
    @val, @left, @right, @depth = v, nil, nil, d
  end
end
