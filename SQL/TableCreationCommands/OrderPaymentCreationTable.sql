CREATE TABLE OrderPayment (
    OrderId INT PRIMARY KEY,
    SpecialRequest VARCHAR (300),
    Street VARCHAR(300) NOT NULL, 
    StreetNumber  INT NOT NULL, 
    City VARCHAR(300) NOT NULL,
    Tip DECIMAL(4, 2),
    DeliveryFee DECIMAL(5, 2) NOT NULL,
    DriverId INT,
    CardNumber VARCHAR(19),
    FOREIGN KEY (OrderId) References Orders(OrderId),
    FOREIGN KEY (DriverId) REFERENCES DRIVER(DriverId),
    FOREIGN KEY (CardNumber) REFERENCES BankCard(CardNumber)
);