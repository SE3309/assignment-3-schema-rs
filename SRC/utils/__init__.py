import generateAddresses
import csv
import mysql.connector
from faker import Faker
import random


fake = Faker()

connection = mysql.connector.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="your_database"
)

# Create a cursor object
cursor = connection.cursor()


customers=[]
restaurants=[]
bankCard=[]
drivers=[]
address = generateAddresses.generate_addresses()

#Tables left to do
#DiscountItem,OrderItem,OrderPayment,Orders,PlacedOrders,Promotion,

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
        

#Driver Insertion
with open("drivers.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        drivers.append(row)
        query = "INSERT INTO Driver (fName, lName, email,userPassword, licensePlate) VALUES (%s, %s, %s,%s,%s)"
        values = (row["FName"], row["LName"], row["Email"],row["UserPassword"],row["LicensePlate"])
        cursor.execute(query, values)
        connection.commit()


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


#BankCard Insertion
with open("bankCard.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        bankCard.append(row)
        query = query = """ INSERT INTO BankCard (cardNumber, cardType, street, streetNumber, city, 
            cardProvider, expiryDate, bankCVC, cardHolderName) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
        values = (row["CardNumber"],row["CardType"],row["Street"],row["StreetNumber"],row["City"],row["CardProvider"],
            row["ExpiryDate"],row["BankCVC"],customers["fName"]+ " "+ customers["lName"])
        cursor.execute(query, values)
        connection.commit()


#CustomerBankCard Insertion
count = 0
for row in customers:
    query = "INSERT INTO CustomerBankCard (customerId,cardNumber) VALUES (%d,%s)"
    values= (count,bankCard[count]["CardNumber"])
    count+=1

#Customer Delivery Address 
count = 0
for row in customers:
    query = "INSERT INTO CustomerDeliveryAddress (customerId,street,streetNumber,city) VALUES (%d,%s,%s,%s)"
    values= (count,address["Street"],address["StreetNumber"],address["City"])
    count+=1

#Reviews
count=0
for row in restaurants:
    query = "INSERT INTO Review (rating,reviewNotes,dayPosted,customerId,restaurantId) VALUES (%d,%s,%s,%d,%d)"
    values= (random.randint(0,5),random.choice(["Great","Food was bad","Loved it!", "meh","Never eat here again"],fake.date())
             ,count,count)
    count+=1

#MenuItems Insertion
with open("menuItems.csv", mode="r") as file:
    csv_reader = csv.DictReader(file)
    
    # Access a specific column by name (e.g., "ColumnName")
    for row in csv_reader:
        query = "INSERT INTO MenuItem (itemName, itemDescription, pictureUrl, itemPrice, restaurantId) VALUES (%s, %s, %s,%s,%s)"
        values = (row["itemName"], row["itemDescription"], row["pictureUrl"],row["itemPrice"],row["restaurantId"])
        cursor.execute(query, values)
        connection.commit()

#RestaurantGenres Insertion
    genres = [
    "Italian","Chinese","Japanese","Mexican","Indian","Thai","French","Greek","Mediterranean","Spanish"
    ]
    count=0
    for row in restaurants:
        query="INSERT INTO RestaurantGenres (restaurantId,genre) VALUES(%d, %s)"
        values=(count,random.choice(genres))


