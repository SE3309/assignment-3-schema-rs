import csv
from faker import Faker
import random

faker = Faker()

num_records = 4000

output_file = "menuItems.csv"

fieldnames = [
    "itemName",
    "itemDescription",
    "pictureUrl",
    "itemPrice",
    "restaurantId",    
]

with open(output_file, mode="w", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    writer.writeheader()

    for i in range(num_records):
        writer.writerow({
            "itemName": faker.word().capitalize(),
            "itemDescription": faker.sentence(nb_words = 12),
            "pictureUrl": faker.image_url(),
            "itemPrice": faker.random_number(digits=2),
            "restaurantId": round(random.uniform(5, 50), 3),
        })

print(f"{num_records} random menu items have been written to {output_file}.")