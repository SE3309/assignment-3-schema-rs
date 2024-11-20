CREATE TABLE PlacedOrder (
    orderDate DATE NOT NULL,
    orderTime TIMESTAMP NOT NULL,
    customerId INT,
    restaurantId INT,
    orderId INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES Customer(userId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);