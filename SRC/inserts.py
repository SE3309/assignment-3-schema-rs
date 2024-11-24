import generateAddresses
import csv
import mysql.connector
from faker import Faker
import random


fake = Faker()

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="PrettyBoy921;20",
    database="Schema_Eats"
)

# Create a cursor object
cursor = connection.cursor()


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
        # query = "INSERT INTO Customer (fName, lName, email,userPassword) VALUES (%s, %s, %s,%s)"
        # values = (row["FName"], row["LName"], row["Email"],row["UserPassword"])
        # cursor.execute(query, values)
        # connection.commit()
        

# #Driver Insertion
with open("drivers.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        drivers.append(row)
        # query = "INSERT INTO Driver (fName, lName, email,userPassword, licensePlate) VALUES (%s, %s, %s,%s,%s)"
        # values = (row["FName"], row["LName"], row["Email"],row["UserPassword"],row["LicensePlate"])
        # cursor.execute(query, values)
        # connection.commit()


#Restaurant Insertion
with open("restaurants.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)

    print(csv_reader)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        restaurants.append(row)
        # query = "INSERT INTO Restaurant (restaurantName, street, streetNumber, city) VALUES (%s, %s, %s,%s)"
        # values = (row["RestaurantName"], row["Street"], row["StreetNumber"],row["City"])
        # cursor.execute(query, values)
        # connection.commit()


#BankCard Insertion
count=0
with open("bankCard.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        bankCard.append(row)
        # query = query = """ INSERT INTO BankCard (cardNumber, cardType, street, streetNumber, city, 
        #     cardProvider, expiryDate, bankCVC, cardHolderName) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        #     """
        # values = (row["CardNumber"],row["CardType"],row["Street"],row["StreetNumber"],row["City"],row["CardProvider"],
        #     row["ExpiryDate"],row["BankCVC"],customers[count]["FName"]+ " "+ customers[count]["LName"])
        # cursor.execute(query, values)
        # connection.commit()
        # count+=1


#CustomerBankCard Insertion
# count = 0
# for row in customers:
#     query = "INSERT INTO CustomerBankCard (customerId,cardNumber) VALUES (%s,%s)"
#     values= (count+1,bankCard[count]["CardNumber"])
#     cursor.execute(query, values)
#     connection.commit()
#     count+=1

#Customer Delivery Address 
# count = 0
# for row in customers:
#     query = "INSERT INTO CustomerDeliveryAddress (customerId,street,streetNumber,city) VALUES (%s,%s,%s,%s)"
#     values= (count+1,address[count]["Street"],address[count]["StreetNumber"],address[count]["City"])
#     cursor.execute(query, values)
#     connection.commit()
#     count+=1

#Reviews
# count=0
# for row in restaurants:
#     query = "INSERT INTO Review (rating,reviewNotes,dayPosted,customerId,restaurantId) VALUES (%s,%s,%s,%s,%s)"
#     values= (random.randint(0,5),random.choice(["Great","Food was bad","Loved it!", "meh","Never eat here again"]),fake.date()
#              ,count+1,count+1)
#     cursor.execute(query, values)
#     connection.commit()
#     count+=1

#MenuItems Insertion
with open("menuItems.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        menuItems.append(row)
        # query = "INSERT INTO MenuItem (itemName, itemDescription, pictureUrl, itemPrice, restaurantId) VALUES (%s, %s, %s,%s,%s)"
        # values = (row["itemName"], row["itemDescription"], row["pictureUrl"],row["itemPrice"],row["restaurantId"])
        # cursor.execute(query, values)
        # connection.commit()

#RestaurantGenres Insertion
genres = [
"Italian","Chinese","Japanese","Mexican","Indian","Thai","French","Greek","Mediterranean","Spanish"
]
# count=0
# for row in restaurants:
#     query="INSERT INTO RestaurantGenre (restaurantId,genre) VALUES(%s, %s)"
#     values=(count+1,random.choice(genres))
#     cursor.execute(query, values)
#     connection.commit()
#     count+=1


#OrderPayment
# count = 0
# requests = ["","","","Leave at door","Knock twice","Bring extra sauces"]
# for row in customers:
#     query = """INSERT INTO OrderPayment (specialRequest, street, streetNumber, city, tip, 
#             deliveryFee, driverId, cardNumber) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
#     values = (random.choice(requests), address[count]["Street"],address[count]["StreetNumber"],address[count]["City"],random.uniform(0, 10), 
#                 random.uniform(1, 10),(count%999)+1,bankCard[count]["CardNumber"])
#     cursor.execute(query, values)
#     connection.commit()
#     count+=1

# PlacedOrders
count = 0
for row in customers:
    query = """INSERT INTO PlacedOrder (orderDate, orderTime, customerId, restaurantId, orderId) VALUES (%s, %s, %s,%s,%s)"""
    values = (fake.date(),fake.time(),count,count,count)
    cursor.execute(query, values)
    connection.commit()
    count+=1

#OrderItem
count = 0
for row in customers:
    query = """INSERT INTO OrderItem (orderId, itemName) VALUES (%s, %s)"""
    values = (count+1,menuItems[count]["itemName"])
    cursor.execute(query, values)
    connection.commit()
    count+=1

#Promotions
with open("promotions.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    for row in csv_reader:
        promotions.append(row)
        query = "INSERT INTO Promotion (promotionName, promotionStartDate, promotionEndDate, discountPercentage, restaurantId) VALUES (%s, %s, %s,%s,%s)"
        values = (row["promotionName"], row["promotionStartDate"], row["promotionEndDate"],row["discountPercentage"],row["restaurantId"])
        cursor.execute(query, values)
        connection.commit()

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