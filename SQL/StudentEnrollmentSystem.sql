CREATE DATABASE studentdb;
USE studentdb;

CREATE TABLE student (
    sid INT PRIMARY KEY,
    sname VARCHAR(25),
    semail VARCHAR(25)
);

create table Course(
cid int,
cname varchar(25)
);

create table Instructor(
iid int,
iname varchar(25)
);

select * from Student;
select * from Course;
select * from Instructor;

drop table Student;
drop table Course;
drop table Instructor;