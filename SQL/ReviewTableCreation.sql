CREATE TABLE Review ( 
    Rating INT, 
    Notes VARCHAR(300) NOT NULL, 
    DayPosted DATE NOT NULL, 
    CustomerId  INT NOT NULL, 
    RestaurantId INT NOT NULL, 
    PRIMARY KEY (CustomerId,RestaurantId),
    FOREIGN KEY (CustomerId) REFERENCES Customer(UserId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);