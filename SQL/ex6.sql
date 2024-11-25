INSERT INTO MenuItem (itemName, itemDescription, pictureUrl, itemPrice, restaurantId)
SELECT 'Default Item', 'Default Description', 'default_image.jpg', 0.0, restaurantId
FROM Restaurant
WHERE restaurantId NOT IN (
    SELECT restaurantId
    FROM MenuItem
    GROUP BY restaurantId
    HAVING COUNT(*) > 1
);

SET SQL_SAFE_UPDATES = 0;

UPDATE promotions
SET discountPercentage = 0
WHERE promotionEndDate < NOW();

DELETE r1
FROM review r1
JOIN restaurant r2 ON r1.restaurantId = r2.restaurantId
WHERE r1.rating < 1 AND r2.city = "Lake Markhaven";

SET SQL_SAFE_UPDATES = 1;