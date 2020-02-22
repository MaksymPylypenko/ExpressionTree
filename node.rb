#------------------------------------------------
#Node
#------------------------------------------------

class Node
  attr_accessor :val
  attr_accessor :left
  attr_accessor :right
  attr_accessor :depth

  #constructor
  def initialize(v, l, r)
    @val, @left, @right, @dept = v, l, r, 0
  end
end