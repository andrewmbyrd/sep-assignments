require_relative 'node'

class MaxHeap

  attr_accessor :root

  def initialize(root)
    @root = root
    #this keeps track of the bottom-right leaf
    @replacer_leaf = root
    #holds the parent of the botto right leaf
    @leaf_parent = nil

    #holds on to the node that was searched up because
    #depth first search just is broke as a joke
    @searched_node = nil
    @new_parent = root
  end

  def insert(num)
    find_parent
    parent = @new_parent


    @leaf_parent = parent
    child = Node.new(num)

    if parent.left == nil
      parent.left = child
      child.parent = parent
      @replacer_leaf = parent.left
    else
      parent.right = child
      child.parent = parent
      @replacer_leaf = parent.right
    end

    while child.data > parent.data
      temp = parent.data
      parent.data = child.data
      child.data = temp
      if parent.parent
        child = parent
        parent = parent.parent
      else
        break
      end
    end

    print
    puts "\n\n"

  end

  def delete(root, data)
    #find the node that is to be deleted
    find(root, data)
    swapping_node = @searched_node
    return_data = swapping_node.data

    #swap the to-be-delted node's data with that of the lower right leaf
    swapping_node.data = @replacer_leaf.data


    #update what the new leaf is
    #if it had a right child, then it must have had a left
    #child by heap insertion rules. set @replacer leaf to the left
    if @leaf_parent.right
      @leaf_parent.right = nil
      @replacer_leaf = @leaf_parent.left
    #else the replacer leaf could be smooth on the other side
    #of the tree. use our function to find it
    else
      @leaf_parent.left = nil
      assign_leaf(@root)
    end

    #now check to make sure that min heap rules still apply
    #by swapping to the left until rating is in the appropriate
    #location


    swap(swapping_node)
    print
    puts "\n\n"
    return return_data
  end

  # a semi-depth-first search. it kept returning nil because it wouldn't stop
  #when it found the correct entry. so we have a global variable that is set
  # when the desired node is found
  def find(root, data)
    return if data == nil || root == nil

    if root.data == data
      @searched_node = root
    end

    if root.left
       find(root.left, data)
    end
    if root.right
       find(root.right, data)
    end

    return @searched_node
  end

  def print(level=[])

    next_level = []
    if level.empty?
      level[0] = @root
    end

    level_output = ""

    level.each do |node|
      level_output += "#{node.data}, "
      next_level.push(node.left) if node.left
      next_level.push(node.right) if node.right
    end

    level_output += "\n"
    puts level_output
    return if next_level.empty?
    print(next_level)

  end


  private

  #checks whether a node has room for a new child
  def find_parent
    parents=[]
    parents.push(@root)
    while parents.length > 0
      dummy = []
      parents.each do |parent|

        if parent.left == nil
          @new_parent = parent
          return
        elsif parent.right == nil
          @new_parent = parent
          return
        else

          dummy.push(parent.left) if parent.left
          dummy.push(parent.right) if parent.right

        end

      end
      parents = dummy

    end

  end

  def swap(node)
    if node.left && node.right
      if node.left.data > node.data || node.right.data > node.data
        if node.left.data > node.right.data
          temp = node.data
          node.data = node.left.data
          node.left.data = temp
          swap(node.left)
        else
          temp = node.data
          node.data = node.right.data
          node.right.data = temp
          swap(node.right)
        end
      end

    else
      if node.left && node.left.data > node.data
        temp = node.data
        node.data = node.left.data
        node.left.data = temp
      end
    end
  end

  #given the knowledge that we keep track of the lower, right leaf. If ever the lower-right leaf
  # is deleted, if it had a left brother, then it's the new lowest right leaf. that
  # situation is handled above in #delete. But if a left node is deleted as the leaf, then
  # the new lowest right leaf could be anywhere in the heap, even on a different level, But
  # we know that in that situation, the new leaf will definitely have a left sibling
  # so traverse the entire heap and assign the global variables everytime you find a parent
  # with two kids. Again with this UNSTOPPABLE recursion thing, this process will just
  # keep going no matter what until we find the lowest-right such parent, which is what
  # we want in this case

  def assign_leaf(node)
    if node.left && node.right
      @leaf_parent = node
      @replacer_leaf = node.right
      assign_leaf(node.left)
      assign_leaf(node.right)
    else
      return
    end
  end

end

array = [3,25,7,43,42,45,6,8,0,78,5,4]
r = Node.new(array[0])
heap = MaxHeap.new(r)


for i in 1...array.length
  heap.insert(array[i])
end

array.length.times  {heap.delete(heap.root, heap.root.data)}

#heap.delete(heap.root, heap.root.data)
#puts "\n\n"
#heap.print
