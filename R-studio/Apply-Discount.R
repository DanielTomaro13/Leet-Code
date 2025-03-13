# Apply Discount

# A Computer store is offering a 25% discount for all new customers over the age of 65 or customers 
# that spend more than $200 on their first purchase.

# The owner wants to know how many customers received that discount since they started the promotion.

# Write a query to see how many customers received that discount.

valid_customers <- customers %>% filter(age > 65 | total_purchase > 200) # | is OR
answer <- nrow(valid_customers)