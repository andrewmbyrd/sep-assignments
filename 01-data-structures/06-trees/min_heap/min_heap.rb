require_relative 'node'

class MinHeap

  attr_accessor :root

  def initialize(root)
    @root = root
    @replacer_leaf = root
    @leaf_parent = nil
  end

  def insert(parent_node, new_movie)

    if new_movie.rating < parent_node.rating
      replaced_node = Node.new(parent_node.title, parent_node.rating)

      parent_node_in_heap = find(@root, parent_node.title)
      parent_node_in_heap.title = new_movie.title
      parent_node_in_heap.rating = new_movie.rating

      @root = parent_node_in_heap if replaced_node == @root

      insert(parent_node_in_heap, replaced_node)

    else
      if parent_node.left && parent_node.right
        if has_vacancy(parent_node.left)
          insert(parent_node.left, new_movie)
        elsif has_vacancy(parent_node.right)
          insert(parent_node.right, new_movie)
        end
      elsif parent_node.left
        parent_node.right = new_movie
        @replacer_leaf = parent_node.right
        @leaf_parent = parent_node
        return
      else
        parent_node.left = new_movie
        @replacer_leaf = parent_node.left
        @leaf_parent = parent_node
        return
      end
    end

  end

  def delete(root, data)
    #find the node that is to be deleted
    swapping_node = find(root, data)

    #swap the to-be-delted node's data with that of the lower right leaf
    swapping_node.rating = @replacer_leaf.rating
    swapping_node.title = @replacer_leaf.title

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
    left_kid = swapping_node.left

    while left_kid
      if swapping_node.rating > swapping_node.left.rating
        temp = Node.new(swapping_node.title, swapping_node.rating)
        #will temp have a different address than swap node here?
        swapping_node.title = left_kid.title
        swapping_node.rating = left_kid.rating

        left_kid.title = temp.title
        left_kid.rating = temp.rating

        left_kid = left_kid.left
      else
        break
      end

    end

  end

  def find(root, data)
    return if data == nil || root == nil


    return root if root.title == data

    find(root.left, data)

    if root.left
      return root.left if root.left.title == data
    end
    if root.right
      return root.right if root.right.title == data
    end


    find(root.right, data)

  end

  def print(root)
  end

  def swap
  end

  private

  def has_vacancy(node)
    !(node.left && node.right)
  end

  def assign_leaf(node)
    if node.left && node.right
      @leaf_parent = node
      @replacer_leaf = node.right
      find_leaf(node.left)
      find_leaf(node.right)
    else
      return
    end
  end

end

root = Node.new("The Matrix", 87)
heap = MinHeap.new(root)

hope = Node.new("Hope", 93)
martian = Node.new("Martian", 92)
empire = Node.new("Empire", 94)
max = Node.new("Max", 98)
shank = Node.new("Shank", 91)

heap.insert(root, hope)
heap.insert(root, martian)

heap.insert(root, empire)
heap.insert(root, max)
heap.insert(root, shank)

jim = heap.find(root, "Empire")

puts "#{jim.title}"
puts "#{root.title}"
puts "#{root.left.title}  #{root.right.title}"
puts "#{root.left.left.title}  #{root.left.right.title}"

puts "#{root.right.left.title}"
