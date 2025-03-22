# frozen_string_literal: true

require_relative 'tree_traversals'
require_relative 'tree_operations'
require_relative 'tree_display'

class Tree
  attr_accessor :root

  include TreeTraversals
  include TreeOperations
  include TreeDisplay

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array, start = 0, final = array.length - 1)
    array = array.compact.sort.uniq
    return nil if start > final

    mid = (start + final) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, final)

    root
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right) # Check both sides
  end

  def height(node)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def display_height
    puts height(@root)
  end

  def depth(node, current = @root, depth = 0)
    return -1 if current.nil? # Node not found
    return depth if current == node # Found the node

    # Search in the left subtree
    left_depth = depth(current.left, node, depth + 1)
    return left_depth if left_depth != -1 # If node found in left subtree

    # Search in the right subtree
    right_depth = depth(current.right, node, depth + 1)
    return right_depth if right_depth != -1 # If node found in right subtree

    # If the node is not found
    -1
  end

  def rebalance
    sorted_nodes = inorder(@root) # Get sorted array of values
    @root = build_tree(sorted_nodes) # Rebuild the tree
  end
end
