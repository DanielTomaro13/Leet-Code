# 1. Two Sum
'''
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.
'''

class Solution {
    // Time: O(n)
    // Space: O(n)
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++)
        int cur = nums[i];
        // cur + x = target
        // x = target - cur
        int x = target - cur;
        if (map.containsKey(x)) {
            return new int[] {map.get(x), i };
        }
        map.put(cur, i);
    }
    return null;
}