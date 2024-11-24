CREATE TABLE DiscountedItem (
    promotionName VARCHAR (50),
    itemName VARCHAR (50),
    restaurantId INT,
    PRIMARY KEY (promotionName,itemName,restaurantId),
    FOREIGN KEY (promotionName,restaurantId) REFERENCES Promotions (promotionName,restaurantId),
    FOREIGN KEY (itemName, restaurantId) REFERENCES MenuItem(itemName, restaurantId)
);