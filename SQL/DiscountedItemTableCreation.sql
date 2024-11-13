CREATE TABLE DiscountedItem (
    PromotionName VARCHAR (30),
    ItemName VARCHAR (30),
    RestaurantId VARCHAR (30),
    PRIMARY KEY (PromotionName,ItemName,RestaurantId),
    FOREIGN KEY (PromotionName) REFERENCES Promotion (PromotionName),
    FOREIGN KEY (ItemName) REFERENCES MenuItem (PromotionName),
    FOREIGN KEY (PromotionName) REFERENCES Promotion (PromotionName),
);