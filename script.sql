# Top 10 Best-Selling Products
SELECT
    m.product_id,
    m.product_name,
    SUM(od.quantity) AS totalsold
FROM order_details od
JOIN merchandise m ON od.product_id = m.product_id
GROUP BY m.product_id, m.product_name
ORDER BY totalsold DESC
LIMIT 10;

# Most Expensive Products by School Department
SELECT 
    sd.dept_name,
    COUNT(m.product_id) AS TotalProducts,
    MAX(m.price) AS HighestPrice
FROM school_department_details sd
JOIN merchandise m ON sd.dept_id = m.school_dept_id
GROUP BY sd.dept_name
ORDER BY HighestPrice DESC;

# Top 10 High-Spending Customers
SELECT 
    customer_id,
    SUM(total_price) AS TotalSpend
FROM uci_spirit_shop.order
GROUP BY customer_id
HAVING TotalSpend > (
    SELECT AVG(total_price) FROM uci_spirit_shop.order
)
ORDER BY TotalSpend DESC
LIMIT 10;

# Total Revenue by School Department
SELECT 
    sd.dept_name,
    SUM(od.quantity * m.price) AS TotalRevenue
FROM order_details od
JOIN merchandise m ON od.product_id = m.product_id
JOIN school_department_details sd ON m.school_dept_id = sd.dept_id
GROUP BY sd.dept_name
ORDER BY TotalRevenue DESC;

# Shipment Efficiency (Days to Ship)
SELECT 
    DATEDIFF(s.shipmentdate, o.orderdate) AS DaysToShip,
    COUNT(DISTINCT o.order_id) AS OrdersShipped
FROM uci_spirit_shop.order o
JOIN shipment s ON o.order_id = s.order_id
GROUP BY DaysToShip
ORDER BY DaysToShip DESC;