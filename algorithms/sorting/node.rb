class Node

  attr_accessor :data, :left, :right, :parent

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
    @parent = nil
  end

end
