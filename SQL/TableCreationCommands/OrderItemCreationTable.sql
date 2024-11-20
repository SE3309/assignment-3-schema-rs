CREATE TABLE OrderItem (
    orderId INT,
    itemName VARCHAR(300),
    PRIMARY KEY (orderId,itemName),
    FOREIGN KEY (orderId) REFERENCES PlacedOrder(orderId),
    FOREIGN KEY (itemName) REFERENCES MenuItem(itemName)
);