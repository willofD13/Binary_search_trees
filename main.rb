#sort the given array 
#find the middle element and make it the root node 
#separate in two subarrays 
#repeat

# array.sort
# root = Node.new(a[array.count/2]) -> middle element
# left_child = build_tree(array.slice(0..araay.length/2))
# right_child = build_tree(array.slice(array.length/2..array.length))
#return middle

#[1,2,3,4,6,8,9]
class Node 

    def initialize(value)
        @value = value 
    end 

end

class Tree  

    def initialize(array) 
        @array = array
    end


    def build_tree(array)
        start = 0
        last = array.length - 1

        return nil if start > last

        middle = (start + last)/2 #find the middle element

        root_node = Node.new(array[middle])

        left_child = build_tree(array.slice(0..middle - 1))
        right_child = build_tree(array.slice((middle + 1)..last))

        return root_node
    end

end


