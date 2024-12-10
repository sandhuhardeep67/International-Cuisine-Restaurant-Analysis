use RestaurantOrders;

                                     -- Exploring menu_items --
SELECT * FROM menu_items;



-- Total Items on the Menu.
SELECT COUNT(menu_item_id) AS total_items
FROM menu_items;

-- Most Expensive item on the Menu.
SELECT TOP 1 * FROM menu_items
ORDER BY price DESC;

-- Most cheapest item on the Menu.
SELECT TOP 1 * FROM menu_items
ORDER BY price ASC ;


-- Most Expensive Italian dish.
SELECT TOP 1 * FROM menu_items
WHERE category = 'Italian'
ORDER BY price Desc;

-- Cheapest Italian dish.
SELECT TOP 1 * FROM menu_items
WHERE category = 'Italian'
ORDER BY price Asc;

-- Total number of dishes by each category.
SELECT category,COUNT(menu_item_id) AS total_dishes
FROM menu_items
GROUP BY category ;

-- Average price of dishes by each category
SELECT category, CAST(ROUND(AVG(price),2) AS decimal(10,2)) AS avg_price
FROM menu_items
GROUP BY category ;



	                                   -- Exploring order_details --
SELECT * FROM order_details;

-- start and end date of order details.
SELECT MIN(order_date) AS start_date, MAX(order_date) AS end_date
FROM order_details ;

--unique orders.
SELECT COUNT(DISTINCT(order_id)) AS unique_orders
FROM order_details ;

-- total number of orders 
SELECT COUNT(*) AS total_orders FROM order_details;

-- orders with total number of items
SELECT order_id, COUNT(item_id) AS num_of_items
FROM order_details
GROUP BY order_id
ORDER BY num_of_items DESC, order_id DESC;


-- total order where items ordered are more then 12.
SELECT COUNT(*) AS total_orders
FROM
	(SELECT order_id, COUNT(item_id) AS num_of_items
	FROM order_details
	GROUP BY order_id 
	HAVING COUNT(item_id) > 12) 
	AS num_of_orders;



                                         -- Analyzing customer behavior --

-- Top most item by orders.
SELECT TOP 1 m.item_name, m.category, COUNT(*) AS order_count
FROM order_details o
INNER JOIN
     menu_items m ON m.menu_item_id = o.item_id
GROUP BY m.category,m.item_name
ORDER BY order_count DESC;

-- Least ordered item.
SELECT TOP 1 m.item_name, m.category, COUNT(*) AS order_count
FROM order_details o
INNER JOIN
     menu_items m ON m.menu_item_id = o.item_id
GROUP BY m.category,m.item_name
ORDER BY order_count;

-- Top 5 order by money spent.
SELECT TOP 5 o.order_id, SUM(m.price) AS total_spent
FROM order_details o
LEFT JOIN 
     menu_items m ON m.menu_item_id = o.item_id
GROUP BY order_id
ORDER BY total_spent DESC;

-- further analysis of Top 5 orders by money spent by category.
SELECT m.category, COUNT(o.item_id) AS num_of_orders
FROM order_details o
LEFT JOIN
	 menu_items m ON m.menu_item_id = o.item_id
WHERE o.order_id IN (440,2075,1957,330,2675) 
GROUP BY m.category
ORDER BY m.category ;

