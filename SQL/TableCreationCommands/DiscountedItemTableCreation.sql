CREATE TABLE DiscountedItem (
    promotionName VARCHAR (300),
    itemName VARCHAR (300),
    restaurantId VARCHAR (300),
    PRIMARY KEY (promotionName,itemName,restaurantId),
    FOREIGN KEY (promotionName) REFERENCES Promotion (promotionName),
    FOREIGN KEY (itemName) REFERENCES MenuItem (itemName),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant (restaurantId),
);