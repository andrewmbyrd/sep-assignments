require_relative 'node'
require 'benchmark'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @head = nil
    @tail = nil
  end

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @tail.next = node if @tail
    @tail = node
    @head = node unless head
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    current_node = @head
    if current_node == @tail
      @head = nil
      @tail = nil
    else
      while current_node.next
        if current_node.next.next
          current_node = current_node.next
        else
          current_node.next = nil
          @tail = current_node
        end
      end
    end
  end

  # This method prints out a representation of the list.
  def print
    current_node = @head
    while current_node
      puts current_node.data
      current_node = current_node.next
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.

  def delete(node)
    if node == @head
      if @head == @tail
        @head = nil
        @tail = nil
      else
        @head = @head.next
      end
    else
      current_node = @head
      while current_node.next
        if current_node.next == node
          current_node.next = current_node.next.next
         @tail = current_node if current_node.next == nil
         break
        end
        current_node = current_node.next
      end
    end
  end


  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    node.next = @head
    @head = node
    @tail = node unless @tail
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    temp = @head
    @head = @head.next
    @tail = nil if @head == nil
    return temp
  end
end

llist = LinkedList.new
10000000.times do
  llist.add_to_tail(Node.new(1))
end

llist2 = LinkedList.new
5000000.times do
  llist2.add_to_tail(Node.new(1))
end

specialNode = Node.new(2)
llist2.add_to_tail(specialNode)

5000000.times do
  llist2.add_to_tail(Node.new(1))
end

a = Array.new(10_000_000)

Benchmark.bm do |x|
  x.report {b = Array.new()
            10_000_000.times do
              b << 1
            end}
  x.report {10000000.times do llist.add_to_tail(Node.new(1)) end}
  x.report {elem = a[5000000]}
  x.report {curr = llist.head
              5000000.times do
                curr.next
                curr = curr.next
              end}
  x.report {a.delete_at(5_000_000)}
  x.report {curr = llist.head
              5_000_000.times do
                curr.next
                curr = curr.next
              end
              curr.next = curr.next.next
            }
 x.report {llist2.delete(specialNode)}
end
