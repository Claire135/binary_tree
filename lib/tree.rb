# frozen_string_literal: true

require_relative 'node'

class Tree
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(new_value, node = @root)
    return @root = Node.new(new_value) if node.nil?
  
    if new_value < node.data
      if node.left.nil?
        node.left = Node.new(new_value)
      else
        insert(new_value, node.left)  # Recursive call with left child
      end
    elsif new_value > node.data
      if node.right.nil?
        node.right = Node.new(new_value)
      else
        insert(new_value, node.right) # Recursive call with right child
      end
    end
  end
  

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return nil if node.left.nil? && node.right.nil? #no children

      # One Child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Two children
      successor = min_value_node(node.right)
      node.data = successor.data
      node.right = delete(successor.data, node.right)
    end
    node
  end

  def min_value_node(node)
    node = node.left until node.left.nil?
    node
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

  def rebalance
    sorted_nodes = inorder_traversal(@root)  # Get sorted array of values
    @root = build_tree(sorted_nodes)         # Rebuild the tree
  end
  
  def inorder_traversal(node, values = [])
    return values if node.nil?
  
    inorder_traversal(node.left, values)
    values << node.data
    inorder_traversal(node.right, values)
  
    values
  end
  
end

new = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

new.insert(350)
new.insert(359)
new.insert(356)
new.insert(3500)
new.insert(380)
new.pretty_print
p new.balanced?
new.delete(7)
new.rebalance
new.pretty_print
p new.balanced?

