# Employee-SQL-Data-Analysis

This repository contains a T-SQL file with employee data analysis from the AdventureWorks sample data. [Microsoft](https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms) offers the AdventureWorks data set to provide a sample database, data warehouse, and OLAP cube.<br>

### Project Objective<br>

This employee data analysis was completed for self-learning purpose and to practice T-SQL queries. We, also explored restoring the AdventureWorks data warehouse into SQL server 2019 using the graphical interface (GUI) in SQL Server Management Studio.<br>

### Challenges<br>

Most systems that manage employee data, store them in a common format with a start and end date for each employee. This format provides some unique challenges when looking to analyse the data. Since there are no point of reference for when employees come and go, there is no transaction record, rather just a single record for each employee with multiple dates on it. Another common obstacle due to the way employee data is stored is to show trends of active counts over time. <br>

### Conclusions <br>

The analysis was able to answer some of the most common question when working with employee data. How many active employees were there on a given day?. In this case I used November 13th, 2013. Most of the time management this is related to reporting externally or for staff plans.<br> 

To show an active trend of employees we used the date table and a subquery against the employee table to get the number of people that were active. Then we applied the same logic as previously. 

Finally, we were able to practice the use of common table expression CTEs. CTEs are temporary structures that contain separate data than the main query and are self- referencing. This allowed us to perform a hierarchy analysis of employee. 









 
