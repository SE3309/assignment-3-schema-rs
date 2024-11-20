import csv
from faker import Faker
import random

# Initialize Faker
fake = Faker()

# Column headers
fieldnames = ["Street", "StreetNumber", "City"]

# Function to generate unique cities
def generate_cities(numCities):
    cities = set()
    while len(cities) < numCities:
        cities.add(fake.city())
        
    return list(cities)

# Function to generate unique restaurant addresses
def generate_unique_address_strings(numAddresses, cities):
    addresses = set()
    
    while len(addresses) < numAddresses:
        street_number = fake.building_number()
        street_name = fake.street_name()
        city = random.choice(cities)
        address = f"{street_name}-{street_number}-{city}"
        addresses.add(address)
    return list(addresses)

def generate_addresses(numAddresses, numCities):
    cities = generate_cities(numCities)
    addressStrings = generate_unique_address_strings(numAddresses, cities)
    addresses = []
    for address in addressStrings:
        addressParts = address.split('-')
        
        street = addressParts[0]
        streetNumber = addressParts[1]
        city = addressParts[2]
        
        addresses.append({
            'Street':street,
            'StreetNumber':streetNumber,
            'City':city
        })
        
    return addresses