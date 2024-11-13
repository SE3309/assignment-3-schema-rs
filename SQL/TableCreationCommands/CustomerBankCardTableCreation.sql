CREATE TABLE CustomerBankCard ( 
    CustomerId INT, 
    CardNumber VARCHAR(19) NOT NULL, 
    PRIMARY KEY (CustomerId,CardNumber),
    FOREIGN KEY (CustomerId) REFERENCES Customer(UserId),
    FOREIGN KEY (CardNumber) REFERENCES BankCard(CardNumber)
    );