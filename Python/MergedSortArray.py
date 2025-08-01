# 88

class Solution:
    def mergesortarray(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        # Get the last index of nums1
        last = m + n - 1

        # merge in reverse order
        while m > 0 and n > 0:
            if nums1[m -1] > num2[n -1]:
                nums1[last] = nums1[m-1]
                m -= 1
            else:
                nums1[last] = nums2[n]
                n -= 1
            last -= 1

        # fill nums 1 with the leftover nums2 elements if there are any
        while n > 0:
            nums1[last] = nums2[n-1]
            n, last = n -1, last -1