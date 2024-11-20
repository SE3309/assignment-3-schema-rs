CREATE TABLE Promotions (
    PromotionName VARCHAR(50) NOT NULL,
    PromotionStartDate DATE ,
    PromotionEndDate DATE,
    DiscountPercentage PERCENTAGE,
    RestaurantId INT,
    PRIMARY KEY (PromotionName,RestaurantId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);