CREATE TABLE OrderPayment (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    specialRequest VARCHAR (300),
    street VARCHAR(300) NOT NULL, 
    streetNumber  INT NOT NULL, 
    city VARCHAR(300) NOT NULL,
    tip DECIMAL(4, 2),
    deliveryFee DECIMAL(5, 2) NOT NULL,
    driverId INT,
    cardNumber VARCHAR(19),
    FOREIGN KEY (driverId) REFERENCES DRIVER(userId),
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber)
);