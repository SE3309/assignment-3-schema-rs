import csv
from faker import Faker
import random
from datetime import timedelta
from datetime import datetime

# Initialize Faker
fake = Faker()

# Define output file path
output_file = "promotions.csv"

# Open the CSV file for writing
with open(output_file, mode="w", newline="") as file:
    # Create a CSV writer
    writer = csv.writer(file)
    
    # Write the header row
    writer.writerow(["promotionName", "promotionStartDate", "promotionEndDate", "discountPercentage", "restaurantId"])
    
    # Generate 10 promotions
    for i in range(10):
        promotion_name = fake.unique.catch_phrase()[:50]  # Generate a unique promotion name (truncate if necessary)
        promotion_start_date = fake.date_this_year()  # Start date in the current year

        promotion_duration = timedelta(days=random.randint(7, 30))  # Promotion lasts 1 to 4 weeks

        promotion_end_date = (promotion_start_date + promotion_duration).isoformat()
        discount_percentage = round(random.uniform(0,1), 2)  # Random discount between 5% and 50%
        restaurant_id = random.randint(0, 3999)  # Random restaurantId within the valid range
        
        # Write the generated row to the CSV
        writer.writerow([promotion_name, promotion_start_date, promotion_end_date, discount_percentage, restaurant_id])

print(f"CSV file '{output_file}' has been successfully generated!")