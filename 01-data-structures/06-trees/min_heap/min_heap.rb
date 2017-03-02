require_relative 'node'
require 'benchmark'

class MinHeap

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

  end

  def insert(parent_node, new_movie)

    #for the min heap, if ever the new movie rating is lower than the parent node,
    #then we need to swap their positions
    #interestingly, trying to just swap the ACTUAL NODE ADDRESSES caused major problems
    #so we're just swapping the data here
    if new_movie.rating < parent_node.rating
      replaced_node = Node.new(parent_node.title, parent_node.rating)

      find(@root, parent_node.title)
      parent_node_in_heap = @searched_node
      parent_node_in_heap.title = new_movie.title
      parent_node_in_heap.rating = new_movie.rating

      @root = parent_node_in_heap if replaced_node == @root

      insert(parent_node_in_heap, replaced_node)

    #find the lowest, left-most location to put the new entry
    #if ever it violates heap rule, it wil be handled in the Recursive call
    #to insert
    else
      if parent_node.left && parent_node.right
        if has_vacancy(parent_node.left)
          insert(parent_node.left, new_movie)
        elsif has_vacancy(parent_node.right)
          insert(parent_node.right, new_movie)
        end
      #when we find the correct spot to enter the movie, keep track of
      #the new entry as the lowest, right most leaf
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
    find(root, data)
    swapping_node = @searched_node


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

  # a semi-depth-first search. it kept returning nil because it wouldn't stop
  #when it found the correct entry. so we have a global variable that is set
  # when the desired node is found
  def find(root, data)
    return if data == nil || root == nil

    if root.title == data
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
      level_output += "#{node.title}: #{node.rating},  "
      next_level.push(node.left) if node.left
      next_level.push(node.right) if node.right
    end

    level_output += "\n"
    puts level_output
    return if next_level.empty?
    print(next_level)

  end

  def swap
  end

  private

  #checks whether a node has room for a new child
  def has_vacancy(node)
    !(node.left && node.right)
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


root = Node.new(1,1)
heap = MinHeap.new(root)
10_000.times do |num|
  heap.insert(root, Node.new(num,num))
end

Benchmark.bm do |x|
  x.report {r = Node.new(1,1)
            h = MinHeap.new(root)
            10_000.times do |num|
              h.insert(r ,Node.new(num,num))
            end}
  x.report {heap.delete(root, 5_000)}
  x.report {heap.delete(root, 7500)}
  x.report {heap.delete(root, 2500)}
  x.report {heap.delete(root, 8000)}
  x.report {heap.delete(root, 1000)}

end
