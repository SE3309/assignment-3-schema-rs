CREATE TABLE Promotions (
    promotionName VARCHAR(50) NOT NULL,
    promotionStartDate DATE ,
    promotionEndDate DATE,
    discountPercentage DECIMAL(5,2),
    restaurantId INT,
    PRIMARY KEY (promotionName,restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);