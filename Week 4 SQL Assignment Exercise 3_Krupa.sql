use AdventureWorksDW2012;


/*1, Display number of orders and total sales amount(sum of SalesAmount) of Internet Sales in 1st quarter each year in each country. Note: your result set should produce a total of 18 rows. */
SELECT count(a.SalesOrderNumber) AS 'NumberOfOrders',sum(a.SalesAmount) AS 'TotalSalesAmount',b.CalendarYear AS 'OrderYear',d.EnglishCountryRegionName AS 'Country'

FROM dbo.DimDate AS b ,dbo.FactInternetSales AS a,dbo.DimCustomer AS c ,dbo.DimGeography AS d

WHERE b.CalendarQuarter = 1 AND b.DateKey = a.OrderDateKey AND a.CustomerKey = c.CustomerKey AND c.GeographyKey = d.GeographyKey

GROUP BY b.CalendarYear, d.EnglishCountryRegionName

ORDER BY b.CalendarYear, d.EnglishCountryRegionName;


/*2, Show total reseller sales amount (sum of SalesAmount), calendar quarter of order date, product category name and 
reseller’s business type by quarter by category and by business type in 2006. Note: your result set should produce a total of 44 rows. */
SELECT sum(a.SalesAmount) AS 'TotalResellerSalesAmount',b.CalendarQuarter,c.EnglishProductCategoryName AS 'CategoryName',e.BusinessType AS 'ResellerBusinessType'

FROM dbo.FactResellerSales AS a,dbo.DimDate AS b,dbo.DimProduct AS f,dbo.DimProductCategory AS c,dbo.DimProductSubcategory AS d,dbo.DimReseller AS e

WHERE a.OrderDateKey = b.DateKey AND b.CalendarYear = 2006 AND a.ProductKey = f.ProductKey AND f.ProductSubcategoryKey = d.ProductSubcategoryKey
		AND d.ProductCategoryKey = c.ProductCategoryKey AND a.ResellerKey = e.ResellerKey

GROUP BY b.CalendarQuarter,c.EnglishProductCategoryName,e.BusinessType

ORDER BY b.CalendarQuarter,c.EnglishProductCategoryName,e.BusinessType;


/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, i.e. 
what do you do to what dimension(s)? Why is it a operation of slicing?*/

 /** I am slicing the dataset to Product CalenderQuarter. This is a slice operation because I am reducing the dimensionality 
 of cube to a specific value i.e CalenderQuater. The number of rows decreased from 44 to 10**/

SELECT sum(a.SalesAmount) AS 'TotalResellerSalesAmount',b.CalendarQuarter,c.EnglishProductCategoryName AS 'CategoryName',e.BusinessType AS 'ResellerBusinessType' 

FROM dbo.FactResellerSales AS a ,dbo.DimDate AS b ,dbo.DimProduct AS f ,dbo.DimProductCategory AS c ,dbo.DimProductSubcategory AS d,dbo.DimReseller AS e

WHERE a.OrderDateKey = b.DateKey AND b.CalendarYear = 2006 AND a.ProductKey = f.ProductKey 
AND f.ProductSubcategoryKey = d.ProductSubcategoryKey AND d.ProductCategoryKey = c.ProductCategoryKey 
AND a.ResellerKey = e.ResellerKey And b.CalendarQuarter='1' 

GROUP BY b.CalendarQuarter,c.EnglishProductCategoryName,e.BusinessType

ORDER BY b.CalendarQuarter,c.EnglishProductCategoryName,e.BusinessType


/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down, i.e. 
what do you do to what dimension(s)? Why is it a operation of drilling-down?*/

/** I am drilling-down on the product category dimension  from Category name to product name. This is drill down operation because 
it summarizes data at a lower level of the dimension hierarchy, there by viewing data in a more specialized level within a dimension. By adding Product
name there was addition of a new header and no. of rows increased to 646 as compared to 44 in the second query**/ 
		
SELECT sum(a.SalesAmount) AS 'TotalResellerSalesAmount',b.CalendarQuarter ,c.EnglishProductCategoryName AS 'CategoryName',
f.EnglishProductName as ProductName,e.BusinessType AS 'ResellerBusinessType'

FROM dbo.FactResellerSales AS a,dbo.DimDate AS b,dbo.DimProduct AS f,dbo.DimProductCategory AS c,dbo.DimProductSubcategory AS d,dbo.DimReseller AS e

WHERE a.OrderDateKey = b.DateKey AND b.CalendarYear = 2006 AND a.ProductKey = f.ProductKey 
AND f.ProductSubcategoryKey = d.ProductSubcategoryKey AND d.ProductCategoryKey = c.ProductCategoryKey 
AND a.ResellerKey = e.ResellerKey 

GROUP BY b.CalendarQuarter,c.EnglishProductCategoryName,f.EnglishProductName, e.BusinessType

ORDER BY b.CalendarQuarter,c.EnglishProductCategoryName,f.EnglishProductName, e.BusinessType
