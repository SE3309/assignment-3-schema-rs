-- Query 1
SELECT * FROM customerdeliveryaddress
WHERE city = "Alyssaberg";

-- Query 2
SELECT r.*  
FROM Restaurant r  
WHERE (SELECT AVG(rating) AS restRating 
    FROM Review v 
    WHERE v.restaurantId = r.restaurantId) > 4; 

-- Query 3
SELECT m.*  
FROM MenuItem m, Restaurant r 
WHERE r.restaurantName = 'Hungry Bistro of Hut' AND 
      r.restaurantId = m.restaurantId; 

-- Query 4
SELECT p.* 
FROM PlacedOrder p, Customer c, Restaurant r, Orderitem o 
WHERE p.customerId = c.userId AND 
      p.restaurantId = r.restaurantId AND 
      p.orderId = o.orderId  
ORDER BY p.orderDate DESC;

-- Query 5
SELECT r.*
FROM Restaurant r
JOIN Promotion p ON r.restaurantId = p.restaurantId;

-- Query 6
SELECT 
    cbc.cardNumber, 
    SUM(m.itemPrice) + SUM(o.tip) + SUM(o.deliveryFee) AS totalAmount
FROM CustomerBankCard cbc
JOIN BankCard b ON cbc.cardNumber = b.cardNumber
JOIN Customer c ON cbc.customerId = c.userId
JOIN PlacedOrder p ON p.customerId = c.userId
JOIN OrderPayment o ON o.orderId = p.orderId AND o.cardNumber = b.cardNumber
JOIN OrderItem o2 ON o2.orderId = o.orderId
JOIN MenuItem m ON o2.itemName = m.itemName
GROUP BY cbc.cardNumber;

-- Query 7
SELECT restaurantName 
FROM RestaurantGenre g JOIN Restaurant r on g.restaurantId = r.restaurantId
WHERE genre = "Greek" ;