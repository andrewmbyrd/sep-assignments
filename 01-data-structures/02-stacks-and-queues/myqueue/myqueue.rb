class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue[0]
    @tail = @queue[0]
  end

  def enqueue(element)
    @queue[@queue.length] = element
    @head = element
    @tail = @queue[0]
  end

  def dequeue
    temp = @queue[0]
    for i in 0...(@queue.length-1)
      @queue[i] = @queue[i + 1]
    end
    @queue.delete_at(@queue.length-1)
    @tail = @queue[0]
    @head = @queue[@queue.length-1]

    return temp
  end

  def empty?
    @queue.length == 0
  end
end
