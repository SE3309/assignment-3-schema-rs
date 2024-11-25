-- Customer Table (No dependencies)
CREATE TABLE Customer ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email VARCHAR(300) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'), -- Added email format validation
    userPassword VARCHAR(300) NOT NULL 
);
DESCRIBE Customer;

-- Driver Table (No dependencies)
CREATE TABLE Driver ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email VARCHAR(300) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'), -- Added email format validation
    userPassword VARCHAR(300) NOT NULL, 
    licensePlate VARCHAR(20) NOT NULL 
);
DESCRIBE Driver;

-- Restaurant Table (No dependencies)
CREATE TABLE Restaurant ( 
    restaurantId INT AUTO_INCREMENT PRIMARY KEY, 
    restaurantName VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL 
);
DESCRIBE Restaurant;

-- BankCard Table (No dependencies)
CREATE TABLE BankCard ( 
    cardNumber CHAR(19) PRIMARY KEY, -- Changed to CHAR(16) for fixed-length card numbers
    cardType VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL, 
    cardProvider VARCHAR(300) NOT NULL, 
    expiryDate VARCHAR(5), 
    bankCVC CHAR(3) NOT NULL CHECK (bankCVC REGEXP '^[0-9]{3}$'), -- Added regex validation for 3-digit CVC codes
    cardHolderName VARCHAR(500) NOT NULL 
);
DESCRIBE BankCard;

-- CustomerBankCard Table (Depends on Customer and BankCard)
CREATE TABLE CustomerBankCard ( 
    customerId INT, 
    cardNumber CHAR(16) NOT NULL, -- Changed to match CHAR(16) in BankCard
    PRIMARY KEY (customerId, cardNumber), 
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE CustomerBankCard;

-- CustomerDeliveryAddress Table (Depends on Customer)
CREATE TABLE CustomerDeliveryAddress (
    customerId INT NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber VARCHAR(20) NOT NULL, 
    city VARCHAR(300) NOT NULL, 
    PRIMARY KEY (customerId, street, streetNumber, city), 
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE CustomerDeliveryAddress;

-- Review Table (Depends on Customer and Restaurant)
CREATE TABLE Review ( 
    rating INT CHECK (rating BETWEEN 1 AND 5), -- Added CHECK constraint for valid ratings
    reviewNotes VARCHAR(300) NOT NULL, 
    dayPosted DATE NOT NULL, 
    customerId INT NOT NULL, 
    restaurantId INT NOT NULL, 
    PRIMARY KEY (customerId, restaurantId), 
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE RESTRICT -- Added ON DELETE RESTRICT
);
DESCRIBE Review;

-- RestaurantGenre Table (Depends on Restaurant)
CREATE TABLE RestaurantGenre (
    restaurantId INT NOT NULL, 
    genre VARCHAR(300) NOT NULL, 
    PRIMARY KEY (restaurantId, genre), 
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE RestaurantGenre;

-- MenuItem Table (Depends on Restaurant)
CREATE TABLE MenuItem (
    itemName VARCHAR(50) NOT NULL, 
    itemDescription VARCHAR(250), -- Increased description length from 50 to 250
    pictureUrl VARCHAR(50), 
    itemPrice FLOAT CHECK (itemPrice >= 0), -- Added CHECK constraint for non-negative prices
    restaurantId INT, 
    PRIMARY KEY (itemName, restaurantId), 
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE MenuItem;

-- Promotions Table (Depends on Restaurant)
CREATE TABLE Promotions (
    promotionName VARCHAR(50) NOT NULL, 
    promotionStartDate DATE, 
    promotionEndDate DATE, 
    discountPercentage DECIMAL(5,2) CHECK (discountPercentage BETWEEN 0 AND 100), -- Added CHECK for valid discount percentages
    restaurantId INT, 
    PRIMARY KEY (promotionName, restaurantId), 
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    CHECK (promotionEndDate >= promotionStartDate) -- Added CHECK for valid date ranges
);
DESCRIBE Promotions;

-- DiscountedItem Table (Depends on Promotions, MenuItem, and Restaurant)
CREATE TABLE DiscountedItem (
    promotionName VARCHAR(50), 
    itemName VARCHAR(50), 
    restaurantId INT, 
    PRIMARY KEY (promotionName, itemName, restaurantId), 
    FOREIGN KEY (promotionName, restaurantId) REFERENCES Promotions(promotionName, restaurantId) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE DiscountedItem;

-- OrderPayment Table (Depends on Driver and BankCard)
CREATE TABLE OrderPayment ( 
    orderId INT PRIMARY KEY AUTO_INCREMENT, 
    specialRequest VARCHAR(300), 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL, 
    tip DECIMAL(4, 2),
    deliveryFee DECIMAL(5, 2) NOT NULL,
    driverId INT, 
    cardNumber CHAR(16), -- Changed to match CHAR(16) in BankCard
    FOREIGN KEY (driverId) REFERENCES Driver(userId) ON DELETE RESTRICT, -- Added ON DELETE RESTRICT
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber) ON DELETE RESTRICT -- Added ON DELETE RESTRICT
);
DESCRIBE OrderPayment;

-- PlacedOrder Table (Depends on Customer, Restaurant, and OrderPayment)
CREATE TABLE PlacedOrder (
    orderDate DATE NOT NULL, 
    orderTime TIMESTAMP NOT NULL, 
    customerId INT, 
    restaurantId INT, 
    orderId INT PRIMARY KEY, 
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE RESTRICT, -- Added ON DELETE RESTRICT
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    FOREIGN KEY (orderId) REFERENCES OrderPayment(orderId) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE PlacedOrder;

-- OrderItem Table (Depends on PlacedOrder and MenuItem)
CREATE TABLE OrderItem (
    orderId INT, 
    itemName VARCHAR(50), 
    restaurantId INT, 
    PRIMARY KEY (orderId, itemName), 
    FOREIGN KEY (orderId) REFERENCES PlacedOrder(orderId) ON DELETE CASCADE, -- Added ON DELETE CASCADE
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId) ON DELETE CASCADE -- Added ON DELETE CASCADE
);
DESCRIBE OrderItem;

-- Indexes for Optimization
CREATE INDEX idx_customer_email ON Customer(email);
CREATE INDEX idx_driver_email ON Driver(email);
CREATE INDEX idx_review_customerId ON Review(customerId);
CREATE INDEX idx_customer_delivery_address ON CustomerDeliveryAddress(city, street, streetNumber);
CREATE INDEX idx_promotions_composite ON Promotions(promotionName, restaurantId);