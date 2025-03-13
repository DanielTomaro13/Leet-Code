# Electric Bike Replacement

# After about 10,000 miles, Electric bike batteries begin to degrade and need to be replaced.

# Write a query to determine the amount of bikes that currently need to be replaced.

bikes_to_be_replaced <- bikes %>% filter(miles > 10000)
answer <- nrow(bikes_to_be_replaced)