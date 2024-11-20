import csv
import random
from faker import Faker
from utils.generateAddresses import generate_addresses

# Initialize Faker
fake = Faker()

# Define the number of records to generate
num_records = 4000
num_cities = 40

# Define the CSV file name
output_file = "bankCard.csv"

# Column headers
fieldnames = [
    "CardNumber",
    "CardType", 
    "Street", 
    "StreetNumber",
    "City",
    "CardProvider",
    "ExpiryDate",
    "BankCVC",
    "CardHolderName",
]

card_types = ["Debit", "Credit", "Prepaid"]
card_providers = ["Visa", "MasterCard"]
addesses = generate_addresses(num_records,num_cities)

# Write data to the CSV file
with open(output_file, mode="w", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    writer.writeheader()

    for i in range(num_records):
        # Generate random data for each field        
        writer.writerow({
            "CardNumber": fake.credit_card_number(),
            "CardType": random.choice(card_types),
            "Street": addesses[i]["Street"],
            "StreetNumber": addesses[i]["StreetNumber"],
            "City": addesses[i]["City"],
            "CardProvider": random.choice(card_providers),
            "ExpiryDate": fake.credit_card_expire(),
            "BankCVC": fake.credit_card_security_code(),
            "CardHolderName": fake.name(),
        })

print(f"{num_records} random customer records have been written to {output_file}.")
