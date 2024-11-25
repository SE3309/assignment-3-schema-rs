-- Insert 1
INSERT INTO Customer (fName, lName, email, userPassword) 
VALUES ("Jonathan", "Bailey", "Jhardry34@gmail.com", "Incredible&9s");

SELECT *
FROM Customer;

-- Insert 2
INSERT INTO MenuItem (itemName, itemDescription, pictureUrl, itemPrice, restaurantId)
SELECT "Chicken Parmesan",
       "Breaded chicken topped with marinara sauce and melted cheese",
       "https://www.google.com",
       12.99,
       restaurantId
FROM Restaurant
WHERE restaurantId = 1;

SELECT *
FROM MenuItem;

-- Insert 3
INSERT INTO CustomerDeliveryAddress (customerId, street, streetNumber, city)
Select userId, 
         "1234 Elm St",
         "123",
         "Springfield"
FROM Customer
WHERE userId = 1;

SELECT *
FROM CustomerDeliveryAddress;