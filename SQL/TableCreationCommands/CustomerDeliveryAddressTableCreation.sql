CREATE TABLE CustomerDeliveryAddress (
    customerId INT NOT NULL,
    street VARCHAR (300) NOT NULL,
    streetNumber VARCHAR (20) NOT NULL,
    city VARCHAR (300) NOT NULL,
    PRIMARY KEY (customerId, street, streetNumber, city),
    FOREIGN KEY (customerId) REFERENCES Customer (userId)
);
