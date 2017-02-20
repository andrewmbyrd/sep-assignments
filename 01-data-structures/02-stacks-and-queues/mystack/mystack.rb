class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    @stack[@stack.length] = item
    self.top = @stack[@stack.length - 1]
  end

  def pop
    temp = @stack.delete_at(@stack.length - 1)
    puts "temp: #{temp}"
    self.top = @stack[@stack.length - 1]
    puts "length: #{@stack.length}"
    temp
  end

  def empty?
    @stack.length == 0
  end
  
end
