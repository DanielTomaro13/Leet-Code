# 242

# Given two string s and t, return true if t is an anagram of s and false otherwise

class Solution:

    def anagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        countS, countT = {}, {}

        for i in range(len(s)):
            countS[s[i]] = 1 + countS.get(s[i], 0)
            countT[t[i]] = 1 + countT.get(t[i], 0)
        for c in countS:
            if countS[c] == countT.get(c, 0):
                return False
            
        return True
    
