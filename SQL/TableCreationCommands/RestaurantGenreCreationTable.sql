CREATE TABLE RestaurantGenre (
    restaurantId INT NOT NULL,
    genre VARCHAR (300) NOT NULL,
    PRIMARY KEY (restaurantId, genre),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);