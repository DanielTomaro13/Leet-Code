# 206

# Iterative

class Solution:
    def reverseiterative(self, head: ListNode) -> ListNode:
        # null for the end
        prev, curr = None, head

        while curr:
            nxt = curr.next
            curr.next = prev
            prev = curr
            curr = nxt
        return prev
    
class Solution:
    def reverserecursion(self, head: ListNode) -> ListNode:

        if not head:
            return None
        newHead = head
        if head.next:
            newHead = self.reverseList(head.next)
            head.next.next = head
        head .next = None

        return newHead