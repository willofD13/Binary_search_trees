require 'pry-byebug'
class Node 

    attr_accessor :value, :left_child, :right_child

    def initialize(value,left_child = nil,right_child = nil)
        @value = value
        @left_child =  left_child
        @right_child = right_child
    end 

end

class Tree  
    attr_accessor :array, :root_node

    def initialize(array) 
        @array = array.sort!.uniq!
        @root_node = build_tree(array)
    end


    def build_tree(array)
        array.sort!.uniq!
        start = 0
        last = array.length - 1

        return nil if start > last

        middle = (start + last)/2 #find the middle element

        root_node = Node.new(array[middle])
        root_node.left_child = build_tree(array[0...middle])
        root_node.right_child = build_tree(array[(middle + 1)..last])

        return root_node
    end

    def print_tree(node = root_node)
        return if node.nil?

        puts node.value
        print_tree(node.left_child)
        print_tree(node.right_child)
             
    end

    def insert(value,node = root_node)

        if value == node.value 
            return 
        elsif value > node.value 
            if node.right_child.nil?
                node.right_child = Node.new(value)
            else 
                insert(value,node.right_child)
            end 
        elsif value < node.value 
            if node.left_child.nil?
                node.left_child = Node.new(value)
            else 
                insert(value,node.left_child)
            end 
        end
    end

    def delete(value, node = root_node)
        if node.nil? #base case
            puts 'value not found'
        elsif value == node.value
            if node.left_child.nil? && node.right_child.nil? 
                node = nil
                return node
            elsif node.left_child.nil? 
                node = node.right_child
                return node
            elsif node.right_child.nil? 
                node = node.left_child
                return node
            else 
                inorder_successor = find_successor(node.right_child) # both children present
                node.value = inorder_successor.value 
                node.right_child = delete(inorder_successor.value, node.right_child)
                return node
            end
        elsif value > node.value
            node.right_child = delete(value, node.right_child)
        elsif value < node.value
            node.left_child = delete(value, node.left_child)
        end
        return node
    end

    def find_successor(node)
        return node if node.left_child.nil? 
        find_successor(node.left_child)
    end

    def find(value, node = root_node)
        if node.nil?
            puts 'value not found'
            return
        end

        if value == node.value
            puts "#{node}, #{node.value}"
            return node
        elsif value > node.value
            find(value, node.right_child)
        else 
            find(value, node.left_child)
        end 
    end 

    #def level_order(node = root_node)
    #    array = []
    #   array.push(node)
    #
    #   while !array.empty?
    #        current_node = array[0]
    #        current_node.value += 1

    #       array.push(current_node.left_child) if !current_node.left_child.nil?
    #        array.push(current_node.right_child) if !current_node.right_child.nil?

    #        array.shift 
    #    end

    #end

    def level_order(node = root_node, array = [root_node])
        return if array.empty?
        node.value += 1 
        array << node.left_child if !node.left_child.nil?
        array << node.right_child if !node.right_child.nil? 
        array.shift
        level_order(array[0], array)
    end

    def pretty_print(node = @root_node, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end

    def preorder_traversal(node = root_node)

        return if node.nil?
        puts "#{node.value}"
        preorder_traversal(node.left_child)
        preorder_traversal(node.right_child)
    end

    def inorder_traversal (node = root_node, array = [])
        return if node.nil? 

        inorder_traversal(node.left_child,array)
        puts "#{node.value}"
        inorder_traversal(node.right_child,array)
    end

    def postorder_traversal(node = root_node)
        return if node.nil? 

        postorder_traversal(node.left_child)
        postorder_traversal(node.right_child)
        puts " #{node.value}"
    end

    def height(node = root_node)
        return -1 if node.nil?

        left_height = height(node.left_child) + 1
        right_height = height(node.right_child) + 1

        return left_height if left_height > right_height        
        return right_height if right_height > left_height
        return left_height if left_height == right_height
    end 

    def depth(value, node = root_node)
        return 0 if value == node.value 

        left_depth = depth(value, node.left_child) if value < node.value
        right_depth = depth(value, node.right_child) if value > node.value

        return left_depth if right_depth.nil?
        return right_depth if left_depth.nil?
    end

    def balanced?(node = root_node)
        return -1 if node.nil?

        left_height = height(node.left_child) + 1
        right_height = height(node.right_child) + 1
        height_difference = left_height - right_height

        return true if height_difference >= -1 && height_difference <= 1
        if height_difference > 1 || height_difference < -1
            puts 'tree not balanced'
            return
        end
    end

    def rebalance
        new_array = inorder_array
    end

    def inorder_array (node = root_node, array = [])
        return if node.nil? 

        inorder_array(node.left_child,array)
        array << node.value
        inorder_array(node.right_child,array)

        return array
    end
end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.balanced?
tree.pretty_print
#tree.inorder_traversal
#tree.preorder_traversal
#tree.postorder_traversal
tree.insert(105)
tree.insert(150)
tree.insert(185)
tree.insert(201)
tree.pretty_print