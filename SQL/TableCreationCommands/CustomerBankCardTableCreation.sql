CREATE TABLE CustomerBankCard ( 
    customerId INT, 
    cardNumber VARCHAR(19) NOT NULL, 
    PRIMARY KEY (customerId,cardNumber),
    FOREIGN KEY (customerId) REFERENCES Customer(userId),
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber)
    );