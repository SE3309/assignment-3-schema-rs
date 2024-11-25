-- Modification 1
-- The following insert query adds a restaurant specialty to the menu of any restaurant 
-- that has a menu that is less than 5 items long
INSERT INTO MenuItem (itemName, itemDescription, pictureUrl, itemPrice, restaurantId)
SELECT 'Default Item', 'Default Description', 'default_image.jpg', 0.0, restaurantId
FROM Restaurant
WHERE restaurantId NOT IN (
    SELECT restaurantId
    FROM MenuItem
    GROUP BY restaurantId
    HAVING COUNT(*) > 1
);

-- turns off safe mode temporarily to be able to update off non-PK attributes
SET SQL_SAFE_UPDATES = 0;

-- Modification 2
-- Sets the promotion discount amount to 0% if the promotion has already ended 
UPDATE promotions
SET discountPercentage = 0
WHERE promotionEndDate < NOW();

-- Modification 3
-- Deletes all reviews that are ranked at 0 stars from all restaurants in a given city (in this case “Lake Markhaven”
DELETE r1
FROM review r1
JOIN restaurant r2 ON r1.restaurantId = r2.restaurantId
WHERE r1.rating < 1 AND r2.city = "Lake Markhaven";

SET SQL_SAFE_UPDATES = 1;