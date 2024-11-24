import csv
from faker import Faker
import random

# Initialize Faker
fake = Faker()

# Define the number of records to generate
num_records = 4000
num_cities = 400

# Define the CSV file name
output_file = "restaurants.csv"

# Column headers
fieldnames = ["RestaurantName", "Street", "StreetNumber", "City"]

# Define lists of adjectives, nouns, and patterns
adjectives = ["Hungry", "Delicious", "Savory", "Golden", "Tasty", "Cozy", "Spicy", "Hearty"]
nouns = ["Grill", "Bistro", "Café", "Spot", "Diner", "Kitchen", "Tavern", "Oven", "Plate", "Corner"]
themes = ["Garden", "Rooftop", "River", "Hill", "Lake", "Station", "Parlor", "Palace", "Hut"]

# Function to generate restaurant names
def generate_restaurant_name():
    return f"{random.choice(adjectives)} {random.choice(nouns)} of {random.choice(themes)}"

# Function to generate unique restaurant addresses
def generate_cities():
    cities = set()
    while len(cities) < num_cities:
        cities.add(fake.city())
        
    return list(cities)

cities = generate_cities()

# Function to generate unique restaurant addresses
def generate_unique_addresses(count):
    addresses = set()
    while len(addresses) < count:
        street_number = fake.building_number()
        street_name = fake.street_name()
        city = random.choice(cities)
        address = f"{street_name}-{street_number}-{city}"
        addresses.add(address)
    return list(addresses)

addresses = generate_unique_addresses(num_records)

# Write data to the CSV file
with open(output_file, mode="w", newline="") as file:
    writer = csv.DictWriter(file, fieldnames=fieldnames)
    writer.writeheader()

    for i in range(num_records):
        # Generate random data for each field
        address = addresses[i].split('-')
        
        name = generate_restaurant_name()
        street = address[0]
        streetname = address[1]
        city = address[2]

        # Write the row to the CSV file
        writer.writerow({
            "RestaurantName": name,
            "Street": street,
            "StreetNumber": streetname,
            "City": city
        })

print(f"{num_records} random customer records have been written to {output_file}.")
