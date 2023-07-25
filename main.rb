class Node 

    def initialize(value)
        @value = value
        @left = nil 
        @right = nil
    end 

end

class Tree  

    def initialize(array) 
        @array = array
        @root = build_tree(array)
    end


    def build_tree(array)
        prepare_array(array)

        start = 0
        last = array.length - 1

        return nil if start > last

        middle = (start + last)/2 #find the middle element

        root_node = Node.new(array[middle])

        left_child = build_tree(array.slice(0..middle - 1))
        right_child = build_tree(array.slice((middle + 1)..last))

        return root_node
    end

    def prepare_array(array)
        array.sort!.uniq!
    end

end

tree = Tree.new([1,3,5,4,6,7])


