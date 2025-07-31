# House Robber

class Solution:
    def rob(self, nums: List[int]) -> int:
        rob1, rob2 = 0,0

        # [rob1, rob2, n, n+1, ...] if I rob n I have to rob rob1
        for n in nums:
            temporary_variable = max(n + rob1, rob2)
            rob1 = rob2
            rob2 = temporary_variable
        return rob2
    