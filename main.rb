# compare value with node value 
# if node has no children(leaf node) remove the node 
# if node has one child, copy the child in the node 
# 


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
                
            elsif node.left_child.nil? 
                node = node.right_child
                return node
            elsif node.right_child.nil? 
                node = node.left_child
                return node
            else 

            end
        elsif value > node.value
            node.right_child = delete(value, node.right_child)
        elsif value < node.value
            node.left_child = delete(value, node.left_child)
        end
        return root_node
    end

end

tree = Tree.new([1,3,5,4,6,7])
tree.insert(2)
tree.delete(1)
tree.print_tree
