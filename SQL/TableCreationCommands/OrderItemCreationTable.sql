CREATE TABLE OrderItem (
    OrderId INT,
    ItemName VARCHAR(300),
    PRIMARY KEY (OrderId,ItemName),
    FOREIGN KEY (OrderId) REFERENCES PlacedOrder(OrderId),
    FOREIGN KEY (ItemName) REFERENCES MenuItem(ItemName)
);