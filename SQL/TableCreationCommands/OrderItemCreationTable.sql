CREATE TABLE OrderItem (
    orderId INT,
    itemName VARCHAR(50),
    restaurantId INT,
    PRIMARY KEY (orderId, itemName),
    FOREIGN KEY (orderId) REFERENCES PlacedOrder(orderId),
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId)
);