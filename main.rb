
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
        @array = array
        @root_node = build_tree(array)
    end


    def build_tree(array)
        prepare_array(array)

        start = 0
        last = array.length - 1

        return nil if start > last

        middle = (start + last)/2 #find the middle element

        root_node = Node.new(array[middle])
        root_node.left_child = build_tree(array[0...middle])
        root_node.right_child = build_tree(array[(middle + 1)..last])

        return root_node
    end

    def prepare_array(array)
        array.sort!.uniq!
    end



end

tree = Tree.new([1,3,5,4,6,7])


