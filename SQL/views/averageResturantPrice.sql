CREATE VIEW averageResturantItemPrice AS
SELECT
    restaurant.`restaurantId`,
    `restaurantName`,
    street,
    `streetNumber`,
    city,
    `itemPrice`
FROM restaurant
    LEFT JOIN menuitem ON menuitem.`restaurantId` = restaurant.`restaurantId`
WHERE
    itemPrice IS NOT NULL
    ORDER BY `restaurantId` DESC

SELECT `restaurantId`, `restaurantName`, AVG(itemPrice)
FROM averageResturantItemPrice
GROUP BY `restaurantId`,`restaurantName`

DROP VIEW averageresturantitemprice
