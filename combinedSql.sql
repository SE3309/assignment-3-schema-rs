-- Customer Table (No dependencies)
CREATE TABLE Customer ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email  VARCHAR(300) NOT NULL UNIQUE, 
    userPassword VARCHAR(300) NOT NULL 
);

-- Driver Table (No dependencies)
CREATE TABLE Driver ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email  VARCHAR(300) NOT NULL UNIQUE, 
    userPassword VARCHAR(300) NOT NULL,
    licensePlate VARCHAR(20) NOT NULL
);

-- Restaurant Table (No dependencies)
CREATE TABLE Restaurant ( 
    restaurantId INT AUTO_INCREMENT PRIMARY KEY , 
    restaurantName VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber  INT NOT NULL, 
    city VARCHAR(300) NOT NULL 
);

-- BankCard Table (No dependencies)
CREATE TABLE BankCard ( 
    cardNumber VARCHAR(19) PRIMARY KEY, 
    cardType VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber  INT NOT NULL, 
    city VARCHAR(300) NOT NULL,
    cardProvider VARCHAR(300) NOT NULL,
    expiryDate VARCHAR(7) NOT NULL,
    bankCVC INT NOT NULL,
    cardHolderName VARCHAR(500) NOT NULL
);

-- CustomerBankCard Table (Depends on Customer and BankCard)
CREATE TABLE CustomerBankCard ( 
    customerId INT, 
    cardNumber VARCHAR(19) NOT NULL, 
    PRIMARY KEY (customerId, cardNumber),
    FOREIGN KEY (customerId) REFERENCES Customer(userId),
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber)
);

-- CustomerDeliveryAddress Table (Depends on Customer)
CREATE TABLE CustomerDeliveryAddress (
    customerId INT NOT NULL,
    street VARCHAR (300) NOT NULL,
    streetNumber VARCHAR (20) NOT NULL,
    city VARCHAR (300) NOT NULL,
    PRIMARY KEY (customerId, street, streetNumber, city),
    FOREIGN KEY (customerId) REFERENCES Customer(userId)
);

-- Review Table (Depends on Customer and Restaurant)
CREATE TABLE Review ( 
    rating INT, 
    reviewNotes VARCHAR(300) NOT NULL, 
    dayPosted DATE NOT NULL, 
    customerId  INT NOT NULL, 
    restaurantId INT NOT NULL, 
    PRIMARY KEY (customerId, restaurantId),
    FOREIGN KEY (customerId) REFERENCES Customer(userId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);

-- RestaurantGenre Table (Depends on Restaurant)
CREATE TABLE RestaurantGenre (
    restaurantId INT NOT NULL,
    genre VARCHAR (300) NOT NULL,
    PRIMARY KEY (restaurantId, genre),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);

-- MenuItem Table (Depends on Restaurant)
CREATE TABLE MenuItem (
    itemName VARCHAR(50) NOT NULL,
    itemDescription VARCHAR(50),
    pictureUrl VARCHAR(50),
    itemPrice FLOAT,
    restaurantId INT,
    PRIMARY KEY (itemName, restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);

-- Promotions Table (Depends on Restaurant)
CREATE TABLE Promotions (
    promotionName VARCHAR(50) NOT NULL,
    promotionStartDate DATE,
    promotionEndDate DATE,
    discountPercentage DECIMAL(5,2),
    restaurantId INT,
    PRIMARY KEY (promotionName, restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);

-- DiscountedItem Table (Depends on Promotions, MenuItem, and Restaurant)
CREATE TABLE DiscountedItem (
    promotionName VARCHAR (50),
    itemName VARCHAR (50),
    restaurantId INT,
    PRIMARY KEY (promotionName,itemName,restaurantId),
    FOREIGN KEY (promotionName,restaurantId) REFERENCES Promotions (promotionName,restaurantId),
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId)
);



-- OrderPayment Table (Depends on Driver and BankCard)
CREATE TABLE OrderPayment (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    specialRequest VARCHAR (300),
    street VARCHAR(300) NOT NULL, 
    streetNumber  INT NOT NULL, 
    city VARCHAR(300) NOT NULL,
    tip DECIMAL(4, 2),
    deliveryFee DECIMAL(5, 2) NOT NULL,
    driverId INT,
    cardNumber VARCHAR(19),
    FOREIGN KEY (driverId) REFERENCES Driver(userId),
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber)
);


CREATE TABLE PlacedOrder (
    orderDate DATE NOT NULL,
    orderTime TIMESTAMP NOT NULL,
    customerId INT,
    restaurantId INT,
    orderId INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES Customer(userId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId),
    FOREIGN KEY (orderId) REFERENCES OrderPayment(orderId)
);



-- OrderItem Table (Depends on PlacedOrder and MenuItem)
CREATE TABLE OrderItem (
    orderId INT,
    itemName VARCHAR(50),
    restaurantId INT,
    PRIMARY KEY (orderId, itemName),
    FOREIGN KEY (orderId) REFERENCES PlacedOrder(orderId),
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId)
);

