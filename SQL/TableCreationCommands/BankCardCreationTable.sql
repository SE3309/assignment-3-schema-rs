CREATE TABLE BankCard ( 
    CardNumber VARCHAR(19) PRIMARY KEY, 
    CardType VARCHAR(300) NOT NULL, 
    Street VARCHAR(300) NOT NULL, 
    StreetNumber  INT NOT NULL, 
    City VARCHAR(300) NOT NULL,
    CardProvider VARCHAR(300) NOT NULL,
    ExpiryDate DATE NOT NULL,
    BankCVC INT NOT NULL,
    CardHolderName VARCHAR(500) NOT NULL
      );