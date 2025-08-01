# climbing stairs dynamic programming #70

class Solution:
    def climber(self, n: int) -> int:

        one, two = 1,1

        for i in range(n-1):
            temp = one
            one = one + two
            two = temp
        
        return one