# 543
# using recursion and nested function
class Solution:

    def dimbintree(self, root: Optional[TreeNone]) -> int:
        # making a member variable of the class so can be used in nested function
        self.res = 0

        # returns the height
        def depthfirstsearch(current):
            if not current:
                return 0
            
            left = depthfirstsearch(current.left)
            right = depthfirstsearch(current.right)

            self.res = max(self.res, left + right)
            return 1 + max(left, right)
    
    depthfirstsearch(root)
    return self.res


