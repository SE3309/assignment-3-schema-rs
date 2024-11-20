CREATE TABLE MenuItem(
    ItemName VARCHAR(50) NOT NULL,
    ItemDescription VARCHAR(50),
    PictureUrl VARCHAR(50),
    ItemPrice FLOAT,
    RestaurantId INT,
    PRIMARY KEY (ItemName,RestaurantId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);