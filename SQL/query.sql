-- Need 7 query statements and only 1 can be simple 

SELECT fName FROM CUSTOMER WHERE userId=10;

SELECT p.* 
FROM PlacedOrders p, Customer c, Restaurant r, Order o
WHERE p.customerId = c.userId AND
               p.restaurantId = r.restaurantId AND
               p.orderId = o.orderId
ORDER BY date DESC
GROUP BY restaurantId