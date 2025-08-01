# 234


# using an array
class Solution:

    def ispalindrome(self, head: ListNode) -> bool:
        
        nums = []

        while head:
            nums.append(head.val)
            head = head.next

        l,r = 0, len(nums) - 1
        while l <= r:
            if nums[l] != nums[r]
            return False
        
            l += 1
            r -= 1

        return True
    
# Doing it in O(1) memory rather than O(n) using two pointers one is fast and one is slow

class Solution:

    def isPalindrome(self, head: ListNode) -> bool:

        fast = head
        slow = head

        # find middle (slow_)
        while fast and fast.next: # making sure there is enough nodes
            fast = fast.next.next
            slow = slow.next

        # reverse second half of the list
        prev = None
        while slow:
            temp = slow.next

            slow.next = prev
            prev = slow
            slow = temp

        
        # check palindrome
        left, right = head, prev # loop stops because slow is at null

        while right:
            if left.val != right.val:
                return False
            
            left = left.next
            right = right.next

        return True