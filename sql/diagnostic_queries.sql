-- Query 1: Late delivery rate by shipping mode
SELECT 
    Shipping_Mode,
    COUNT(*) AS total_orders,
    SUM(Late_delivery_risk) AS late_orders,
    ROUND(SUM(Late_delivery_risk) * 100.0 / COUNT(*), 1) AS late_delivery_pct
FROM orders
GROUP BY Shipping_Mode
ORDER BY late_delivery_pct DESC;
-- Query 2: Worst performing regions by late delivery

SELECT 
    Order_Region,
    Market,
    COUNT(*) AS total_orders,
    SUM(Late_delivery_risk) AS late_orders,
    ROUND(SUM(Late_delivery_risk) * 100.0 / COUNT(*), 1) AS late_pct,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS avg_profit
FROM orders
GROUP BY Order_Region, Market
ORDER BY late_pct DESC
LIMIT 10;

-- Query 3: Shipping mode vs region worst combinations  

SELECT 
    Shipping_Mode,
    Market,
    COUNT(*) AS total_orders,
    ROUND(SUM(Late_delivery_risk) * 100.0 / COUNT(*), 1) AS late_pct,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS total_profit
FROM orders
GROUP BY Shipping_Mode, Market
ORDER BY late_pct DESC
LIMIT 10;

-- Query 4: Monthly order volume trend

SELECT 
    YEAR(STR_TO_DATE(order_date_DateOrders, '%m/%d/%Y %H:%i')) AS order_year,
    MONTH(STR_TO_DATE(order_date_DateOrders, '%m/%d/%Y %H:%i')) AS order_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS total_profit
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
-- Query 5: Top 10 most loss-making individual orders
SELECT 
    Order_Id,
    Category_Name,
    Shipping_Mode,
    Market,
    Order_Region,
    ROUND(Order_Profit_Per_Order, 2) AS profit,
    ROUND(Order_Item_Discount_Rate * 100, 1) AS discount_pct
FROM orders
WHERE Order_Profit_Per_Order < 0
ORDER BY Order_Profit_Per_Order ASC
LIMIT 10;
