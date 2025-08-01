# Best time to buy and sell stock 121 

class Solution:
    def buysell(self, nums: List[int]) -> int:
        l,r = 0,1 # left buys and right sells
        maxp = 0

        while r < len(prices):
            # profitable?
            if prices[l] < prices[r]:
                profit = prices[r] - prices[l]
                maxp = max(maxp, profit)
            else:
                l = r
            r += 1
        return maxp
