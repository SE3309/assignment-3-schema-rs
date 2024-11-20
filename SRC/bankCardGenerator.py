import csv
from faker import Faker

# Initialize Faker
fake = Faker()

# Define the number of records to generate
num_records = 4000

# Define the CSV file name
output_file = "customers.csv"

# Column headers
fieldnames = ["CardNum", "LName", "Email", "UserPassword"]

# Write data to the CSV file
with open(output_file, mode="w", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    writer.writeheader()

    for _ in range(num_records):
        # Generate random data for each field
        # first_name = fake.first_name()
        # last_name = fake.last_name()
        # email = fake.unique.email()
        # password = fake.password(length=12)  # Generating a random 12-character password
        card_num=fake.credit_card_number
        # Write the row to the CSV file
        writer.writerow({
            "FName": first_name,
            "LName": last_name,
            "Email": email,
            "UserPassword": password
        })

print(f"{num_records} random customer records have been written to {output_file}.")
