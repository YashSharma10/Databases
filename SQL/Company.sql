/* Experiment 3*/

create database company;
use company;
drop database company;

CREATE TABLE Employee (
    Fname CHAR(15) NOT NULL,
    Minit CHAR,
    Lname CHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate VARCHAR(20),
    Address CHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10 , 2 ),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    CHECK (Salary > 1000),
    PRIMARY KEY (Ssn)
);

insert into employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) values ("Yash", "A", "Sharma", "B", "4-6-2004", "Gurgaon", "M", 100000, "a", 5);
insert into employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) values ("Akul", "B", "Shrivastava", "C", "5-7-2002", "Stafford", "M", 100000, "B", 6);
insert into Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) values ('John', 'C', 'Smith', 'D', '5-3-2006', '123 Main St', 'M', 50000, '20000', 1);


CREATE TABLE Department (
    Dname CHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Ssn1 CHAR(9) NOT NULL,
    Mgr_start_date CHAR(20) NOT NULL,
    PRIMARY KEY (Dnumber),
    FOREIGN KEY (Ssn1)
        REFERENCES Employee (Ssn),
    UNIQUE (Dname)
);

insert into Department(Dname, Dnumber, Ssn1, Mgr_start_date) values ("CSE", 295, "B", "2-5-2060");
insert into Department(Dname, Dnumber, Ssn1, Mgr_start_date) values ("SOL", 247, "C", "2-5-2050");
insert into Department (Dname, Dnumber, Ssn1, Mgr_start_date) values ('Research', 5, 'D', '5-3-2004');



/* Experiment 4*/


CREATE TABLE Dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(20) NOT NULL,
    PRIMARY KEY (Dnumber , Dlocation),
    FOREIGN KEY (Dnumber)
        REFERENCES Department (Dnumber)
);

insert into Dept_Locations(Dnumber,Dlocation)values(295,"Gurgaon");
insert into Dept_Locations(Dnumber,Dlocation)values(247,"Noida");


CREATE TABLE Project (
    Pnumber INT NOT NULL,
    Pname VARCHAR(20) NOT NULL,
    Dnum INT NOT NULL,
    Plocation VARCHAR(20) NOT NULL,
    PRIMARY KEY (Pnumber),
    FOREIGN KEY (Dnum)
        REFERENCES Department (Dnumber)
);

insert into Project(Pnumber,Pname,Dnum,Plocation)values(1,"bookride",295,"Gurgaon");
insert into Project(Pnumber,Pname,Dnum,Plocation)values(2,"todo",247,"Stafford");


-- 1st
SELECT Bdate, Address
FROM Employee
WHERE Fname = 'John' AND Minit = 'C'AND Lname = 'Smith';

-- 2nd
SELECT Fname, Minit, Lname, Address
FROM Employee JOIN Department ON Dno = Dnumber
WHERE Dname = 'Research';

-- 3rd
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM Project JOIN Department ON Dnum = Dnumber JOIN Employee ON Ssn1 = Ssn
WHERE Plocation = 'Stafford';

-- 4th
SELECT Ssn, Dname
FROM Employee JOIN Department;

-- 5th
SELECT *
FROM department
WHERE Dnumber = 5;

-- 6th
SELECT DISTINCT Salary
FROM Employee;

-- 8th
SELECT *
FROM Employee
WHERE Address = 'Gurgaon';

-- 9th
SELECT *
FROM Employee
WHERE Bdate = '4-6-2004';


SELECT * FROM Employee;
SELECT * FROM department;
SELECT * FROM Dept_locations;
SELECT * FROM Project;


drop table employee;
drop table department;
drop table Dept_locations;
drop table Project;


-- Experiment 5

CREATE TABLE Pack_grades (
    Grade_id INT PRIMARY KEY,
    Grade_name VARCHAR(50),
    Min_price DECIMAL(10,2),
    Max_price DECIMAL(10,2)
);
CREATE TABLE Sectors (
    Sector_id INT PRIMARY KEY,
    Sector_name VARCHAR(50)
);
CREATE TABLE Packages (
    Pack_id INT PRIMARY KEY,
    Speed INT,
    Start_date DATE,
    Monthly_payment DECIMAL(10,2),
    Sector_id INT,
    FOREIGN KEY (Sector_id) REFERENCES Sectors(Sector_id)
);

CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Birth_date DATE,
    Join_date DATE,
    City VARCHAR(50),
    Pack_id INT,
    State VARCHAR(50),
    FOREIGN KEY (Pack_id) REFERENCES Packages(Pack_id)
);



INSERT INTO Sectors (Sector_id, Sector_name) VALUES
(1, 'Business'),
(2, 'Private'),
(3, 'Public');

INSERT INTO Pack_grades (Grade_id, Grade_name, Min_price, Max_price) VALUES
(1, 'Basic', 20.00, 30.00),
(2, 'Standard', 30.00, 50.00),
(3, 'Premium', 50.00, 100.00);

INSERT INTO Packages (Pack_id, Speed, Start_date, Monthly_payment, Sector_id) VALUES
(10, 100, '2023-01-01', 25.00, 1),
(22, 200, '2023-01-01', 40.00, 2),
(27, 300, '2023-01-01', 60.00, 2),
(35, 150, '2023-01-01', 30.00, 3);

INSERT INTO Customers (Customer_id, First_name, Last_name, Birth_date, Join_date, City, Pack_id, State) VALUES
(1, 'Amado', 'Taylor', '1990-05-15', '2023-01-01', 'New York', 10, 'NY'),
(2, 'Jane', 'Smith', '1985-08-20', '2006-01-01', 'Los Angeles', 22, 'CA'),
(3, 'Alice', 'Johnson', '1992-11-10', '2023-01-01', 'Chicago', 27, 'IL'),
(4, 'Bob', 'Brown', '1980-03-25', '2023-01-01', 'Houston', 35, 'TX');



-- 1) 
SELECT c.First_name, c.Last_name, p.Pack_id, p.Speed
FROM Customers c
JOIN Packages p ON c.Pack_id = p.Pack_id;

-- 2) 
SELECT c.First_name, c.Last_name, p.Pack_id, p.Speed
FROM Customers c
JOIN Packages p ON c.Pack_id = p.Pack_id
WHERE c.Pack_id IN (22, 27)
ORDER BY c.Last_name ASC;

-- 3) 
SELECT p.Pack_id, p.Speed, p.Monthly_payment, s.Sector_name
FROM Packages p
JOIN Sectors s ON p.Sector_id = s.Sector_id;

-- 4) 
SELECT c.First_name, c.Last_name, p.Pack_id, p.Speed, p.Monthly_payment, s.Sector_name
FROM Customers c
JOIN Packages p ON c.Pack_id = p.Pack_id
JOIN Sectors s ON p.Sector_id = s.Sector_id;

-- 5) 
SELECT c.First_name, c.Last_name, p.Pack_id, p.Speed, p.Monthly_payment, s.Sector_name
FROM Customers c
JOIN Packages p ON c.Pack_id = p.Pack_id
JOIN Sectors s ON p.Sector_id = s.Sector_id
WHERE s.Sector_name = 'Business';

-- 6) Display last name, first name, join date, package number, internet speed, and sector name for customers in the private sector who joined in 2006.
SELECT c.Last_name, c.First_name, c.Join_date, p.Pack_id, p.Speed, s.Sector_name
FROM Customers c
JOIN Packages p ON c.Pack_id = p.Pack_id
JOIN Sectors s ON p.Sector_id = s.Sector_id
WHERE s.Sector_name = 'Private' AND EXTRACT(YEAR FROM c.Join_date) = 2006;

-- 7) 
SELECT p.Pack_id, p.Speed, p.Monthly_payment, pg.Grade_name
FROM Packages p
JOIN Pack_grades pg ON p.Pack_id = pg.Grade_id;

-- 8) 
SELECT c.First_name, c.Last_name, p.Speed, p.Monthly_payment
FROM Customers c
INNER JOIN Packages p ON c.Pack_id = p.Pack_id;

-- 9) 
SELECT c.Last_name, c.First_name, c.Pack_id
FROM Customers c
JOIN Customers a ON c.Pack_id = a.Pack_id
WHERE a.First_name = 'Amado' AND a.Last_name = 'Taylor';

-- 10) 
SELECT p2.Pack_id, p2.Speed
FROM Packages p1
JOIN Packages p2 ON p1.Speed = p2.Speed
WHERE p1.Pack_id = 10;



/* Experiment 6 */

-- 1st
SELECT 
    SUM(Salary) AS Total_Salary,
    MAX(Salary) AS Max_Salary,
    MIN(Salary) AS Min_Salary,
    AVG(Salary) AS Avg_Salary
FROM Employee;

-- 2nd
SELECT 
    SUM(e.Salary) AS Total_Salary,
    MAX(e.Salary) AS Max_Salary,
    MIN(e.Salary) AS Min_Salary,
    AVG(e.Salary) AS Avg_Salary
FROM Employee e
JOIN Department d ON e.Dno = d.Dnumber
WHERE d.Dname = 'Research';

-- 3rd
SELECT COUNT(*) AS Total_Employees
FROM Employee;

-- 4th
SELECT COUNT(*) AS Research_Employees
FROM Employee e
JOIN Department d ON e.Dno = d.Dnumber
WHERE d.Dname = 'Research';

-- 5th
SELECT COUNT(DISTINCT Salary) AS Distinct_Salaries
FROM Employee;

-- 6th
SELECT 
    d.Dnumber AS Department_Number,
    COUNT(*) AS Number_of_Employees,
    AVG(e.Salary) AS Average_Salary
FROM Department d
JOIN Employee e ON d.Dnumber = e.Dno
GROUP BY d.Dnumber;

-- 7th
SELECT 
    p.Pnumber AS Project_Number,
    p.Pname AS Project_Name,
    COUNT(*) AS Number_of_Employees
FROM Project p
JOIN Employee e ON p.Dnum = e.Dno
GROUP BY p.Pnumber, p.Pname;

-- 8th
SELECT 
    p.Pnumber AS Project_Number,
    p.Pname AS Project_Name,
    COUNT(*) AS Number_of_Employees
FROM Project p
JOIN Employee e ON p.Dnum = e.Dno
GROUP BY p.Pnumber, p.Pname
HAVING COUNT(*) > 2;

-- 9th
SELECT 
    p.Pnumber AS Project_Number,
    p.Pname AS Project_Name,
    COUNT(*) AS Number_of_Employees
FROM Project p
JOIN Employee e ON p.Dnum = e.Dno
WHERE e.Dno = 5
GROUP BY p.Pnumber, p.Pname;

-- 10th
SELECT 
    e.Dno AS Department_Number,
    COUNT(*) AS Number_of_Employees_Above_40k
FROM Employee e
WHERE e.Salary > 40000
GROUP BY e.Dno
HAVING COUNT(*) > 5;



/* Experiment 7 */


-- Query 1: List of all project numbers for projects that involve 'Smith'
SELECT DISTINCT Pno AS ProjectNumber
FROM Works_On
WHERE Essn IN (
    SELECT Ssn FROM Employees WHERE Lname = 'Smith'
    UNION
    SELECT Mgr_ssn FROM Departments WHERE Dnumber IN (
        SELECT Dnum FROM Projects WHERE Pnumber = Works_On.Pno
    )
);

-- Query 2: Select the Essns of all employees who work on the same project and hours
SELECT Essn
FROM Works_On
WHERE Pno IN (
    SELECT Pno FROM Works_On WHERE Essn = '123456789'
) AND Hours IN (
    SELECT Hours FROM Works_On WHERE Essn = '123456789'
);

-- Query 3: Return the names of employees whose salary is greater than all in dept 5
SELECT Fname, Lname
FROM Employees
WHERE Salary > ALL (
    SELECT Salary FROM Employees WHERE Dno = 5
);

-- Query 4: Retrieve name of each employee who has a dependent with the same first name and sex
SELECT E.Fname, E.Lname
FROM Employees E
INNER JOIN Dependents D ON E.Ssn = D.Essn
WHERE E.Fname = D.Dependent_name AND E.Sex = D.Sex;

-- Query 5: Retrieve the names of employees who have no dependents
SELECT Fname, Lname
FROM Employees
WHERE Ssn NOT IN (
    SELECT Essn FROM Dependents
);

-- Query 6: List names of managers who have at least one dependent
SELECT DISTINCT E.Fname, E.Lname
FROM Employees E
WHERE EXISTS (
    SELECT * FROM Departments D WHERE E.Ssn = D.Mgr_ssn
) AND EXISTS (
    SELECT * FROM Dependents DEP WHERE E.Ssn = DEP.Essn
);

-- Query 8: Retrieve the names of all employees who have two or more dependents
SELECT Fname, Lname
FROM Employees
WHERE Ssn IN (
    SELECT Essn FROM Dependents
    GROUP BY Essn
    HAVING COUNT(*) >= 2
);

-- Query 9: Retrieves the names of all employees who work on only one project
SELECT E.Fname, E.Lname
FROM Employees E
WHERE (
    SELECT COUNT(*) FROM Works_On W WHERE W.Essn = E.Ssn
) = 1;