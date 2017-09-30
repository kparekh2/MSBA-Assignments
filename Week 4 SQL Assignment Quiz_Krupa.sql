
use AdventureWorks2012;

/*a.	Show First name and last name of employees whose job title is “Sales Representative”, ranking from oldest to youngest.
 You may use HumanResources.Employee table and Person.Person table. (14 rows)*/

select a.firstname, a.lastname, b.JobTitle, b.Birthdate from person.person a,HumanResources.Employee b 
where a.BusinessEntityID = b.BusinessEntityID and b.JobTitle = 'Sales Representative' 
Order by b.BirthDate 

/*b.	Find out all the products which sold more than $5000 in total. Show product ID and name and total amount collected after 
selling the products. You may use LineTotal from Sales.SalesOrderDetail table and Production.Product table. (254 rows)*/
select  a.ProductID, b.Name as ProductName, sum(a.LineTotal) as TotalamountCollected
from Sales.SalesOrderDetail a Left Join  Production.Product b on 
 a.ProductID = b.ProductID  
group by a.ProductID , b.Name
Having Sum(a.LineTotal) > 5000

/*c.	Show BusinessEntityID, territory name and SalesYTD of all sales persons whose SalesYTD is greater than $500,000, 
regardless of whether they are assigned a territory. You may use Sales.SalesPerson table and Sales.SalesTerritory table. (16 rows)*/

select a. BusinessEntityID, b.Name as TerritoryName, a.salesYTD as SalesYTD
from Sales.SalesPerson a Left Join Sales.SalesTerritory b on a.TerritoryID=b.TerritoryID 
where a.salesYTD > 500000

/*d.	Show the sales order ID of those orders in the year 2008 of which the total due is great than the average total due 
of all the orders of the same year. (3200 rows)*/

select salesOrderID as SalesOrderId, Totaldue, OrderDate
From Sales.SalesOrderHeader 
Where TotalDue>(select avg(TotalDue) from Sales.SalesOrderHeader where Orderdate like '%2008%') and Orderdate like '%2008%'