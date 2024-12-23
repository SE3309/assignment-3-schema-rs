import generateAddresses
import csv
import mysql.connector
from faker import Faker
import random

import os
# from dotenv import load_dotenv

# load_dotenv()

fake = Faker()

# IF YOU GET AN ERROR!!!
# Add a .env file with the variables below and the values in your mysql database
# you will also need run: pip install python-dotenv

# connection = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     password=os.getenv('MYSQL_PASSWORD'), # So chid can still use his database: "PrettyBoy921;20" 
#     database=os.getenv('MYSQL_DATABASE_SCHEMA'), # So chid can still use his database: "Schema_Eats"
#     auth_plugin='mysql_native_password'
# )

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password= "",
    database= "db"
)

# Create a cursor object
cursor = connection.cursor()

print("CONNECTED")

customers=[]
restaurants=[]
bankCard=[]
drivers=[]
menuItems=[]
promotions = []
address = generateAddresses.generate_addresses(4000,40)




# Customer Insertion
with open("customers.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        customers.append(row)
        query = "INSERT INTO Customer (fName, lName, email,userPassword) VALUES (%s, %s, %s,%s)"
        values = (row["FName"], row["LName"], row["Email"],row["UserPassword"])
        cursor.execute(query, values)
        connection.commit()
        
print("CUSTOMERS DONE")

# #Driver Insertion
with open("drivers.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        drivers.append(row)
        query = "INSERT INTO Driver (fName, lName, email,userPassword, licensePlate) VALUES (%s, %s, %s,%s,%s)"
        values = (row["FName"], row["LName"], row["Email"],row["UserPassword"],row["LicensePlate"])
        cursor.execute(query, values)
        connection.commit()

print("DRIVERS DONE")

#Restaurant Insertion
with open("restaurants.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        restaurants.append(row)
        query = "INSERT INTO Restaurant (restaurantName, street, streetNumber, city) VALUES (%s, %s, %s,%s)"
        values = (row["RestaurantName"], row["Street"], row["StreetNumber"],row["City"])
        cursor.execute(query, values)
        connection.commit()

print("RESTURANTS DONE")

#BankCard Insertion
count=0
with open("bankCard.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        bankCard.append(row)
        query =""" INSERT INTO BankCard (cardNumber, cardType, street, streetNumber, city, 
            cardProvider, expiryDate, bankCVC, cardHolderName) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
        values = (row["CardNumber"],row["CardType"],row["Street"],row["StreetNumber"],row["City"],row["CardProvider"],
            row["ExpiryDate"],row["BankCVC"],customers[count]["FName"]+ " "+ customers[count]["LName"])
        cursor.execute(query, values)
        connection.commit()
        count+=1

print("BANKCARD DONE")

#CustomerBankCard Insertion
count = 0
for row in customers:
    query = "INSERT INTO CustomerBankCard (customerId,cardNumber) VALUES (%s,%s)"
    values= (count+1,bankCard[count]["CardNumber"])
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("CUSTOMER BANKCARD DONE")

#Customer Delivery Address 
count = 0
for row in customers:
    query = "INSERT INTO CustomerDeliveryAddress (customerId,street,streetNumber,city) VALUES (%s,%s,%s,%s)"
    values= (count+1,address[count]["Street"],address[count]["StreetNumber"],address[count]["City"])
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("CUSTOMER DELIVERY ADDRESS DONE")

#Reviews
count=0
for row in restaurants:
    query = "INSERT INTO Review (rating,reviewNotes,dayPosted,customerId,restaurantId) VALUES (%s,%s,%s,%s,%s)"
    values= (random.randint(0,5),random.choice(["Great","Food was bad","Loved it!", "meh","Never eat here again"]),fake.date()
             ,count+1,count+1)
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("REVIEW DONE")

#MenuItems Insertion
with open("menuItems.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        menuItems.append(row)
        query = "INSERT INTO MenuItem (itemName, itemDescription, pictureUrl, itemPrice, restaurantId) VALUES (%s, %s, %s,%s,%s)"
        values = (row["itemName"], row["itemDescription"], row["pictureUrl"],row["itemPrice"],row["restaurantId"])
        cursor.execute(query, values)
        connection.commit()

print("MENU ITEMS DONE")

#RestaurantGenres Insertion
genres = [
"Italian","Chinese","Japanese","Mexican","Indian","Thai","French","Greek","Mediterranean","Spanish"
]
count=0
for row in restaurants:
    query="INSERT INTO RestaurantGenre (restaurantId,genre) VALUES(%s, %s)"
    values=(count+1,random.choice(genres))
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("RESTURANT GENRE DONE")

# OrderPayment
count = 0
requests = ["Love it!","Nice","No comment","Leave at door","Knock twice","Bring extra sauces"]
for row in customers:
    query = """INSERT INTO OrderPayment (specialRequest, street, streetNumber, city, tip, 
            deliveryFee, driverId, cardNumber) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
    values = (random.choice(requests), address[count]["Street"],address[count]["StreetNumber"],address[count]["City"],random.uniform(0, 10), 
                random.uniform(1, 10),(count%999)+1,bankCard[count]["CardNumber"])
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("ORDER PAYMENT DONE")

# PlacedOrders
count = 0

for row in customers:
    order_date = fake.date()
    order_time= fake.time()
    query = """INSERT INTO PlacedOrder (orderDate, orderTime, customerId, restaurantId, orderId) VALUES (%s, %s, %s,%s,%s)"""
    values = (order_date,order_date+ " " + order_time,count+1,count+1,count+1)
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("PLACED ORDER DONE")

#OrderItem
count = 1
for i in range(len(restaurants)):
    query = """INSERT INTO OrderItem (orderId, itemName, restaurantId) VALUES (%s, %s,%s)"""
    values = (count,menuItems[count-1]["itemName"],menuItems[count-1]["restaurantId"])
    cursor.execute(query, values)
    connection.commit()
    count+=1

print("ORDER ITEM DONE")

#Promotions
with open("promotions.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    for row in csv_reader:
        promotions.append(row)
        query = "INSERT INTO Promotion (promotionName, promotionStartDate, promotionEndDate, discountPercentage, restaurantId) VALUES (%s, %s, %s,%s,%s)"
        values = (row["promotionName"], row["promotionStartDate"], row["promotionEndDate"],row["discountPercentage"],row["restaurantId"])
        cursor.execute(query, values)
        connection.commit()

print("PROMOTIONS DONE")

#create list of discounted menu items
promoted_restaurants = {prom["restaurantId"] for prom in promotions}



# DiscountItem insertion
for promotion in promotions:
    # Get all menu items for the restaurant in this promotion
    restaurant_id = promotion["restaurantId"]
    promotion_name = promotion["promotionName"]

    # Find matching menu items
    matching_menu_items = [item for item in menuItems if item["restaurantId"] == restaurant_id]

    if not matching_menu_items:
        # Skip if no menu items found for the restaurant
        continue

    # Select a random menu item for the discount
    discounted_item = random.choice(matching_menu_items)
    item_name = discounted_item["itemName"]

    # Insert into DiscountItem table
    query = "INSERT INTO DiscountedItem (promotionName, itemName, restaurantId) VALUES (%s, %s, %s)"
    values = (promotion_name, item_name, restaurant_id)
    cursor.execute(query, values)
    connection.commit()
    
print("DISCOUTED ITEM DONE")