CREATE TABLE Review ( 
    rating INT, 
    reviewNotes VARCHAR(300) NOT NULL, 
    dayPosted DATE NOT NULL, 
    customerId  INT NOT NULL, 
    restaurantId INT NOT NULL, 
    PRIMARY KEY (customerId,restaurantId),
    FOREIGN KEY (customerId) REFERENCES Customer(userId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);