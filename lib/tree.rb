# encoding: UTF-8

require_relative 'node'

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array, start = 0, final = array.length-1)
    array = array.sort.uniq
    return nil if start > final
    
    mid = (start + final) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array, start, mid-1)
    root.right = build_tree(array, mid+1, final)

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

new = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

new.pretty_print
