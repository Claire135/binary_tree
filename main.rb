# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

new = Tree.new(Array.new(15) { rand(1..100) })
new.root
new.insert(350)
new.insert(359)
new.insert(356)
new.insert(3500)
new.insert(380)
new.pretty_print
p new.balanced?
new.display_height
p new.depth(new.root.left)
new.delete(7)
new.rebalance
new.pretty_print
p new.balanced?
new.display_height
p new.preorder(new.root)
p new.inorder(new.root)
p new.postorder(new.root)
