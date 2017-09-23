USE AdventureWorks2012; /*Set current database*/

/*1, Display the total amount collected from the orders for each order date. */

select orderdate As OrderDate , 
sum(TotalDue) as TotalAmount 
from sales.SalesOrderHeader
Group by orderdate 
order by OrderDate


/*2, Display the total amount collected from selling each of the products, 774 and 777.*/
select ProductID, sum(LineTotal) as AmountCollected from sales.SalesOrderDetail
where ProductID in (777, 774)
Group by (ProductID)


/*3, Write a query to display the sales person BusinessEntityID, last name and first name of ALL the sales persons and the name of 
the territory to which they belong, even though they don't belong to any territory.*/

Select A.FirstName , A.LastName , B.BusinessEntityId , C.Name as TerritoryName
from  sales.salesperson B Left JOin sales.SalesTerritory c on B.TerritoryID = C.TerritoryID 
JOin Person.Person A on A.businessEntityId = B.BusinessEntityID

/*4,  Write a query to display the Business Entities (IDs, names) of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/

select A.FirstName , A.LastName , B.BusinessEntityID , C.CardType
from Sales.creditcard C , sales.personCreditcard B , person.person A
where CardType = 'Vista'and 
 B.CreditcardID = C.CreditcardID 
 and  A.BusinessEntityID = B.BusinessEntityID  
order by BusinessEntityID



/*5, Write a query to display ALL the countries/regions along with their corresponding territory IDs, including those the countries/regions that do not belong to any territory.*/
/* tables: Sales.SalesTerritory and Person.CountryRegion*/

SELECT c.CountryRegionCode, c.Name as CountryName  , s.TerritoryID 
FROM Sales.SalesTerritory s
Right JOIN Person.CountryRegion AS c
		ON s.CountryRegionCode = c.CountryRegionCode
		order by CountryRegionCode

		

/*6, Find out the average of the total dues of all the orders.*/
select avg(totaldue) as AverageTotaldue
from sales.salesorderheader


/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/

Select SalesOrderID, Totaldue 
from Sales.SalesOrderHeader
Where TotalDue>(select avg(TotalDue) from Sales.SalesOrderHeader)
order by SalesOrderID



