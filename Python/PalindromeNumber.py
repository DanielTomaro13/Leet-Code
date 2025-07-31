# 9 Palindrome Number

'''

Given an integer x, return true if x is a palindrome, and false otherwise.

'''

class Solution(object):
    def isPalindrome(self, x):
        boolean = False

        if str(x) == str(x)[::-1]:
            boolean = True

        return boolean