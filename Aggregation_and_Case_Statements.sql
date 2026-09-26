-- Business question
-- For each customer, return:
-- CustomerID
-- CustomerName
-- CompletedOrders
-- CancelledOrders
-- TotalRevenue
-- Rules:
-- Completed orders → count them
-- Cancelled orders → count them
-- Revenue should come only from completed orders
-- Customers with no matching order type should show 0

select c.CustomerID,
       c.CustomerName,
     Count(Distinct 
            Case When o.OrderStatus = 'Completed' 
            Then o.orderId End ) AS Completed_Orders,
	  Count(Distinct 
            Case When o.OrderStatus = 'Cancelled' 
            Then o.orderId End ) AS Cancelled_Orders,
       Sum( Case 
           When o.OrderStatus = 'Completed'
           Then oi.Quantity*oi.UnitPrice Else 0 End ) AS Total_Revenue 
FROM customers c
INNER JOIN Orders o
ON c.CustomerId = o.CustomerID
INNER JOIN orderitems oi
ON o.OrderId = oi.OrderId
Group BY CustomerID, CustomerName
Order BY Total_Revenue DESC;