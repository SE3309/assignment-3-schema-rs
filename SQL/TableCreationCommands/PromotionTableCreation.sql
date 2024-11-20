CREATE TABLE Promotions (
    promotionName VARCHAR(50) NOT NULL,
    promotionStartDate DATE ,
    promotionEndDate DATE,
    discountPercentage PERCENTAGE,
    restaurantId INT,
    PRIMARY KEY (promotionName,restaurantId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);