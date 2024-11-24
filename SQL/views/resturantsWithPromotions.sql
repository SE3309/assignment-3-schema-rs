-- Active: 1732482614857@@127.0.0.1@3306@western-se3309-lab3
CREATE VIEW resturantsWithPromotions AS
SELECT
    restaurant.`restaurantId`,
    `restaurantName`,
    `promotionName`,
    `promotionEndDate`,
    `discountPercentage`
FROM restaurant
    RIGHT JOIN promotion ON promotion.`restaurantId` = restaurant.`restaurantId`

SELECT * FROM resturantswithpromotions

-- DOES NOT WORK SINCE VIEWS CAN NOT BE INSERTED INTO
INSERT INTO resturantswithpromotions VALUES(99999999, "Test Resturant", "Test Promotion",2024-04-09,.50)

-- WORKS SINCE IT IS AN ACTUAL TABLE IN THE DATABASE
INSERT INTO restaurant VALUES(99999999, "Test Resturant", "Street Name", 123, "TEST CITY")
