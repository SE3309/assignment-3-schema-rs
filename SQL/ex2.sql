-- Domain Definitions
-- Domain for validating email format
CREATE DOMAIN EmailDomain AS VARCHAR(300)
    CHECK (VALUE LIKE '%_@__%.__%'); -- Ensures email format consistency

-- Domain for validating ratings between 1 and 5
CREATE DOMAIN RatingDomain AS INT
    CHECK (VALUE BETWEEN 1 AND 5); -- Restricts ratings to the range 1-5

-- Domain for 16-character card numbers
CREATE DOMAIN CardNumberDomain AS CHAR(16); -- Ensures card numbers are always 16 characters

-- Domain for validating percentages between 0 and 100
CREATE DOMAIN PercentageDomain AS DECIMAL(5,2)
    CHECK (VALUE BETWEEN 0 AND 100); -- Restricts percentage values to the range 0-100

-- Domain for 3-character bank CVC codes
CREATE DOMAIN CVCDomain AS CHAR(3); -- Restricts CVC codes to exactly 3 characters


-- Customer Table
CREATE TABLE Customer ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email EmailDomain NOT NULL UNIQUE, -- Uses EmailDomain for consistent validation
    userPassword VARCHAR(300) NOT NULL 
);

CREATE INDEX idx_customer_email ON Customer(email); -- Added index to optimize email lookups

-- Driver Table
CREATE TABLE Driver ( 
    userId INT PRIMARY KEY AUTO_INCREMENT, 
    fName VARCHAR(300) NOT NULL, 
    lName VARCHAR(300) NOT NULL, 
    email EmailDomain NOT NULL UNIQUE, -- Uses EmailDomain for consistent validation
    userPassword VARCHAR(300) NOT NULL, 
    licensePlate VARCHAR(20) NOT NULL 
);

CREATE INDEX idx_driver_email ON Driver(email); -- Added index to optimize email lookups

-- Restaurant Table
CREATE TABLE Restaurant ( 
    restaurantId INT AUTO_INCREMENT PRIMARY KEY, 
    restaurantName VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL 
);

CREATE INDEX idx_restaurant_city ON Restaurant(city); -- Added index to optimize city-based searches

-- BankCard Table
CREATE TABLE BankCard ( 
    cardNumber CardNumberDomain PRIMARY KEY, -- Uses CardNumberDomain for consistency
    cardType VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL, 
    cardProvider VARCHAR(300) NOT NULL, 
    expiryDate DATE NOT NULL, 
    bankCVC CVCDomain NOT NULL, -- Uses CVCDomain for consistent CVC validation
    cardHolderName VARCHAR(500) NOT NULL 
);

CREATE INDEX idx_bankcard_cardnumber ON BankCard(cardNumber); -- Added index for faster card lookups

-- CustomerBankCard Table
CREATE TABLE CustomerBankCard ( 
    customerId INT NULL, -- Nullable to support SET NULL on deletion
    cardNumber CardNumberDomain NOT NULL, 
    PRIMARY KEY (customerId, cardNumber), 
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber) 
);

-- CustomerDeliveryAddress Table
CREATE TABLE CustomerDeliveryAddress (
    customerId INT NULL, -- Nullable to support SET NULL on deletion
    street VARCHAR(300) NOT NULL,
    streetNumber VARCHAR(20) NOT NULL,
    city VARCHAR(300) NOT NULL,
    PRIMARY KEY (customerId, street, streetNumber, city),
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL -- Added SET NULL for safer deletion
);

CREATE INDEX idx_customer_delivery_address ON CustomerDeliveryAddress(city, street, streetNumber); -- Added index for faster address lookups

-- Review Table
CREATE TABLE Review ( 
    rating RatingDomain, -- Uses RatingDomain for consistency
    reviewNotes VARCHAR(300) NOT NULL, 
    dayPosted DATE NOT NULL, 
    customerId INT NULL, -- Nullable to support SET NULL on deletion
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    PRIMARY KEY (customerId, restaurantId), 
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL -- Added SET NULL for safer deletion
);

CREATE INDEX idx_review_customer ON Review(customerId); -- Added index for faster customer-based lookups

-- RestaurantGenre Table
CREATE TABLE RestaurantGenre (
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    genre VARCHAR(300) NOT NULL,
    PRIMARY KEY (restaurantId, genre),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL -- Added SET NULL for safer deletion
);

-- MenuItem Table
CREATE TABLE MenuItem (
    itemName VARCHAR(50) NOT NULL,
    itemDescription VARCHAR(50),
    pictureUrl VARCHAR(50),
    itemPrice FLOAT CHECK (itemPrice >= 0), -- Added constraint to ensure non-negative prices
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    PRIMARY KEY (itemName, restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL -- Added SET NULL for safer deletion
);

CREATE INDEX idx_menuitem_restaurant ON MenuItem(restaurantId); -- Added index for faster restaurant-based lookups

-- Promotions Table
CREATE TABLE Promotions (
    promotionName VARCHAR(50) NOT NULL,
    promotionStartDate DATE,
    promotionEndDate DATE,
    discountPercentage PercentageDomain, -- Uses PercentageDomain for consistency
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    PRIMARY KEY (promotionName, restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    CHECK (promotionEndDate >= promotionStartDate) -- Added constraint to ensure valid date ranges
);

-- DiscountedItem Table
CREATE TABLE DiscountedItem (
    promotionName VARCHAR(50),
    itemName VARCHAR(50),
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    PRIMARY KEY (promotionName, itemName, restaurantId),
    FOREIGN KEY (promotionName, restaurantId) REFERENCES Promotions(promotionName, restaurantId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId) ON DELETE SET NULL -- Added SET NULL for safer deletion
);

-- OrderPayment Table
CREATE TABLE OrderPayment (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    specialRequest VARCHAR(300),
    street VARCHAR(300) NOT NULL, 
    streetNumber INT NOT NULL, 
    city VARCHAR(300) NOT NULL,
    tip DECIMAL(4,2),
    deliveryFee DECIMAL(5,2) NOT NULL,
    driverId INT DEFAULT NULL, -- Nullable to support SET NULL on deletion
    cardNumber CardNumberDomain DEFAULT NULL, -- Nullable to support SET NULL on deletion
    FOREIGN KEY (driverId) REFERENCES Driver(userId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber)
);

CREATE INDEX idx_orderpayment_driver ON OrderPayment(driverId); -- Added index for faster driver-based lookups

-- PlacedOrder Table
CREATE TABLE PlacedOrder (
    orderDate DATE NOT NULL,
    orderTime TIMESTAMP NOT NULL,
    customerId INT NULL, -- Nullable to support SET NULL on deletion
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    orderId INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES Customer(userId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId) ON DELETE SET NULL, -- Added SET NULL for safer deletion
    FOREIGN KEY (orderId) REFERENCES OrderPayment(orderId)
);

CREATE INDEX idx_placedorder_customer ON PlacedOrder(customerId); -- Added index for faster customer-based lookups

-- OrderItem Table
CREATE TABLE OrderItem (
    orderId INT NULL, -- Nullable to support SET NULL on deletion
    itemName VARCHAR(50),
    restaurantId INT NULL, -- Nullable to support SET NULL on deletion
    PRIMARY KEY (orderId, itemName),
    FOREIGN KEY (orderId) REFERENCES PlacedOrder(orderId),
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId)
);

CREATE INDEX idx_orderitem_order ON OrderItem(orderId); -- Added index for faster order-based lookups
