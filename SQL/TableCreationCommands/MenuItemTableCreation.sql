CREATE TABLE MenuItem(
    itemName VARCHAR(50) NOT NULL,
    itemDescription VARCHAR(50),
    pictureUrl VARCHAR(50),
    itemPrice FLOAT,
    restaurantId INT,
    PRIMARY KEY (itemName,restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);