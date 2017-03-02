require_relative 'node'
require 'benchmark'

class BinarySearchTree

  attr_accessor :root

  def initialize(root)
    @root = root
    @searched_node = nil
  end

  def insert(root, node)

    if root.rating > node.rating
      if root.left
        insert(root.left, node)
      else
        root.left = node
        return
      end
    else
      if root.right
        insert(root.right, node)
      else
        root.right = node
        return
      end
    end

  end

  # Recursive Depth First Search
  def find(root, data)
    return nil unless data && root

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

  def delete(root, data)
    return nil unless data && root

    nixed_node = find(root, data)

    #if the node is a leaf, just set its properties to be nil
    if nixed_node.left == nil && nixed_node.right == nil
      nixed_node.title = nil
      nixed_node.rating = nil
      return

    #otherwise, lets arbitrarily choose to have the
    #deleted nodes left child have preference on the
    #one to replace deleted node
    else
      #so if it has a left node, store that node (AND IMPORTANTLY)
      #all its children in temp
      if nixed_node.left
        temp = nixed_node.left
        nixed_node.left = nil

        #now, it could be that the deleted node's left
        #child has chidren of its own, if it does,
        #we need to find the right-most leaf because
        #it's going to be the parent of the now-deleted-node's right child

        deleted_node_right_childs_new_parent = temp
        while temp.right
          deleted_node_right_childs_new_parent = temp.right
        end
        deleted_node_right_childs_new_parent.right = nixed_node.right
        nixed_node = temp
      #if it doesn't have a left child, then we really
      #just need to shift the entire right sub-tree up by one node
      else
        temp = nixed_node.right
        nixed_node.right = nil

        nixed_node = temp
      end

    end

  end

  # Recursive Breadth First Search
  def printf(children=nil)
    new_children=[]
    if children == nil
      children = []
      children.push(@root)
    end

    children.each do |child|
      puts "#{child.title}: #{child.rating}\n"
    end

    unless children
      new_children.push(@root.left) if @root.left
      new_children.push(@root.right) if @root.right
    else
      children.each do |child|
        new_children.push(child.left) if child.left
        new_children.push(child.right) if child.right
      end
    end

    return if new_children.length == 0
    printf(new_children)
  end

end

root = Node.new(1,1)
tree = BinarySearchTree.new(root)
10_000.times do |num|
  tree.insert(root, Node.new(num,num))
end

Benchmark.bm do |x|
  x.report {r = Node.new(1,1)
            bst = BinarySearchTree.new(r)
            10_000.times do |num|
              bst.insert(r, Node.new(num,num))
            end}
  x.report {tree.delete(root, 5000)}
  x.report {tree.delete(root, 7500)}
  x.report {tree.delete(root, 2500)}
  x.report {tree.delete(root, 8000)}
  x.report {tree.delete(root, 2000)}

end
