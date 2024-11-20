CREATE TABLE Orders (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    specialRequest VARCHAR (300),
    expectedTime TIME NOT NULL,
    maxTime TIME NOT NULL,
    orderDate DATE NOT NULL,
    orderTime TIME NOT NULL,
    driverId INT,
    FOREIGN KEY (driverId) REFERENCES Driver(driverId)
);