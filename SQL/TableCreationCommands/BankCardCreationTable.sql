CREATE TABLE BankCard ( 
    cardNumber VARCHAR(19) PRIMARY KEY, 
    cardType VARCHAR(300) NOT NULL, 
    street VARCHAR(300) NOT NULL, 
    streetNumber  INT NOT NULL, 
    city VARCHAR(300) NOT NULL,
    cardProvider VARCHAR(300) NOT NULL,
    expiryDate VARCHAR(7) NOT NULL,
    bankCVC INT NOT NULL,
    cardHolderName VARCHAR(500) NOT NULL
      );