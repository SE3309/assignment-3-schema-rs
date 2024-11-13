CREATE TABLE DiscountedItem (
    PromotionName VARCHAR (300),
    ItemName VARCHAR (300),
    RestaurantId VARCHAR (300),
    PRIMARY KEY (PromotionName,ItemName,RestaurantId),
    FOREIGN KEY (PromotionName) REFERENCES Promotion (PromotionName),
    FOREIGN KEY (ItemName) REFERENCES MenuItem (PromotionName),
    FOREIGN KEY (PromotionName) REFERENCES Promotion (PromotionName),
);