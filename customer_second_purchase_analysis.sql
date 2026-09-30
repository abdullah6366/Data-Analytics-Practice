With CTE1 AS (
Select c.CustomerId,
       c.CustomerName,
       o.OrderDate,
       o.OrderId,
       ROW_NUMBER () OVER ( Partition BY c.CustomerId Order BY o.OrderDate ) AS OrderNumber
FROM Customers c
Inner JOIN Orders o 
ON c.CustomerId = o.CustomerId
Where o.OrderStatus = "Completed"
 ),
 CTE2 AS (
 Select CustomerID,
	    CustomerName,
        OrderNumber,
        OrderDate,
		Lead(OrderDate) Over (partition by CustomerID Order BY OrderDate,OrderId) AS SecondOrderDate
FROM CTE1
 )

Select CustomerId, CustomerName,
      OrderDate AS FirstOrderDate,
      SecondOrderDate AS SecondOrderDate2,
      datediff(SecondOrderDate,OrderDate) AS NUMBER_OF_DAYS
FROM CTE2
Where OrderNumber= 1 AND SecondOrderDate IS NOT NULL
Order BY CustomerId,CustomerName;
