CREATE TABLE PlacedOrder (
    DATE DATE NOT NULL,
    TIME TIMESTAMP NOT NULL,
    CustomerId INT,
    RestaurantId INT,
    OrderId INT,
    PRIMARY KEY (OrderId),
    FOREIGN KEY (CustomerId) REFERENCES Customer(UserId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);