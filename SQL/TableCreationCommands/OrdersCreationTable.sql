CREATE TABLE Orders (
    OrderId INT PRIMARY KEY AUTO_INCREMENT,
    SpecialRequest VARCHAR (300),
    ExpectedTime TIME NOT NULL,
    MaxTime TIME NOT NULL,
    OrderDate DATE NOT NULL,
    OrderTime TIME NOT NULL,
    DriverId INT,
    FOREIGN KEY (DriverId) REFERENCES Driver(DriverId)
);