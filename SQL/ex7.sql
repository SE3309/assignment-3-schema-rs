-- VIEW FOR AVERAGE RESTURANT ITEM PRICE
CREATE VIEW averageresturantitemprice AS
SELECT
    `restaurantId`,
    `restaurantName`,
    AVG(itemPrice) as averagePrice
FROM  (
        SELECT
            restaurant.`restaurantId`, `restaurantName`, street, `streetNumber`, city, `itemPrice`
        FROM restaurant
            LEFT JOIN menuitem ON menuitem.`restaurantId` = restaurant.`restaurantId`
        WHERE
            itemPrice IS NOT NULL
        ORDER BY `restaurantId` ASC
    ) AS innerTableAlias
GROUP BY
    `restaurantId`,
    `restaurantName`
ORDER BY `restaurantId` ASC

SELECT * FROM averageresturantitemprice

-- VIEW FOR RESTURANTS WITH DISCOUNTS AND THE RESPECTIVE DISCOUNT VALUE

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

