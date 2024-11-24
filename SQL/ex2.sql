-- Customer Table
CREATE TABLE Customer ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email VARCHAR(300) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'), -- Email format validation
    userPassword VARCHAR(300) NOT NULL 
);

CREATE INDEX idx_customer_email ON Customer(email); -- Index for faster email lookups

-- Driver Table
CREATE TABLE Driver ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email VARCHAR(300) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'), -- Email format validation
    userPassword VARCHAR(300) NOT NULL, 
    licensePlate VARCHAR(20) NOT NULL 
);

CREATE INDEX idx_driver_email ON Driver(email); -- Index for faster email lookups

-- Restaurant Table
CREATE TABLE Restaurant ( 
    restaurantId INT AUTO_INCREMENT PRIMARY KEY, 
    restaurantName VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL 
);

CREATE INDEX idx_restaurant_city ON Restaurant(city); -- Index for city-based searches

-- BankCard Table
CREATE TABLE BankCard ( 
    cardNumber CHAR(16) PRIMARY KEY, -- Ensures card numbers are always 16 characters
    cardType VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL, 
    cardProvider VARCHAR(300) NOT NULL, 
    expiryDate DATE NOT NULL, 
    bankCVC CHAR(3) NOT NULL, -- Ensures CVC codes are always 3 characters
    cardHolderName VARCHAR(500) NOT NULL 
);

CREATE INDEX idx_bankcard_cardnumber ON BankCard(cardNumber); -- Index for faster card lookups

-- CustomerBankCard Table
CREATE TABLE CustomerBankCard ( 
    id INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    customerId INT, 
    cardNumber CHAR(16) NOT NULL, 
    UNIQUE (customerId, cardNumber), -- Enforce uniqueness
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL, 
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber) 
);

-- CustomerDeliveryAddress Table
CREATE TABLE CustomerDeliveryAddress (
    addressId INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    customerId INT, 
    street VARCHAR(300) NOT NULL,
    streetNumber VARCHAR(20) NOT NULL,
    city VARCHAR(300) NOT NULL,
    UNIQUE (customerId, street, streetNumber, city), -- Enforce uniqueness
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL -- SET NULL for safer deletion
);

CREATE INDEX idx_customer_delivery_address ON CustomerDeliveryAddress(city, street, streetNumber); -- Index for faster address lookups

-- Review Table
CREATE TABLE Review ( 
    reviewId INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    rating INT CHECK (rating BETWEEN 1 AND 5), -- Ensures ratings are between 1 and 5
    reviewNotes VARCHAR(300) NOT NULL, 
    dayPosted DATE NOT NULL, 
    customerId INT, 
    restaurantId INT, 
    UNIQUE (customerId, restaurantId), -- Enforce uniqueness
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL, -- SET NULL for safer deletion
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL -- SET NULL for safer deletion
);

CREATE INDEX idx_review_customer ON Review(customerId); -- Index for faster customer-based lookups

-- RestaurantGenre Table
CREATE TABLE RestaurantGenre (
    restaurantId INT, 
    genre VARCHAR(300) NOT NULL,
    PRIMARY KEY (restaurantId, genre),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL -- SET NULL for safer deletion
);

-- MenuItem Table
CREATE TABLE MenuItem (
    itemName VARCHAR(50) NOT NULL,
    itemDescription VARCHAR(50),
    pictureUrl VARCHAR(50),
    itemPrice FLOAT CHECK (itemPrice >= 0), -- Ensures non-negative prices
    restaurantId INT, 
    PRIMARY KEY (itemName, restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL -- SET NULL for safer deletion
);

CREATE INDEX idx_menuitem_restaurant ON MenuItem(restaurantId); -- Index for faster restaurant-based lookups

-- Promotions Table
CREATE TABLE Promotions (
    promotionName VARCHAR(50) NOT NULL,
    promotionStartDate DATE,
    promotionEndDate DATE,
    discountPercentage DECIMAL(5,2) CHECK (discountPercentage BETWEEN 0 AND 100), -- Ensures percentages are between 0 and 100
    restaurantId INT, 
    PRIMARY KEY (promotionName, restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL, -- SET NULL for safer deletion
    CHECK (promotionEndDate >= promotionStartDate) -- Ensures valid date ranges
);

-- DiscountedItem Table
CREATE TABLE DiscountedItem (
    discountId INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    promotionName VARCHAR(50),
    itemName VARCHAR(50),
    restaurantId INT, 
    UNIQUE (promotionName, itemName, restaurantId), -- Enforce uniqueness
    FOREIGN KEY (promotionName, restaurantId) REFERENCES Promotions(promotionName, restaurantId) ON DELETE SET NULL, -- SET NULL for safer deletion
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId) ON DELETE SET NULL -- SET NULL for safer deletion
);

-- OrderPayment Table
CREATE TABLE OrderPayment (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    specialRequest VARCHAR(300),
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL,
    tip DECIMAL(4,2) CHECK (tip >= 0), -- Ensures non-negative tips
    deliveryFee DECIMAL(5,2) NOT NULL CHECK (deliveryFee >= 0), -- Ensures non-negative fees
    driverId INT DEFAULT NULL, -- Nullable to support SET NULL on deletion
    cardNumber CHAR(16) DEFAULT NULL, -- Nullable to support SET NULL on deletion
    FOREIGN KEY (driverId) REFERENCES Driver(userId) ON DELETE SET NULL, -- SET NULL for safer deletion
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber)
);

CREATE INDEX idx_orderpayment_driver ON OrderPayment(driverId); -- Index for faster driver-based lookups

-- PlacedOrder Table
CREATE TABLE PlacedOrder (
    orderDate DATE NOT NULL,
    orderTime TIMESTAMP NOT NULL,
    customerId INT, 
    restaurantId INT, 
    orderId INT PRIMARY KEY,
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL, -- SET NULL for safer deletion
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL, -- SET NULL for safer deletion
    FOREIGN KEY (orderId) REFERENCES OrderPayment(orderId)
);

CREATE INDEX idx_placedorder_customer ON PlacedOrder(customerId); -- Index for faster customer-based lookups

-- OrderItem Table
CREATE TABLE OrderItem (
    orderItemId INT PRIMARY KEY AUTO_INCREMENT, -- Surrogate key
    orderId INT, 
    itemName VARCHAR(50),
    restaurantId INT, 
    UNIQUE (orderId, itemName), -- Enforce uniqueness
    FOREIGN KEY (orderId) REFERENCES PlacedOrder(orderId),
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId)
);

CREATE INDEX idx_orderitem_order ON OrderItem(orderId); -- Index for faster order-based lookups
