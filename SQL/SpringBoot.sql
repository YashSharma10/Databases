create database recipiedb;
use recipiedb;
CREATE TABLE Recipe (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    ingredients TEXT,
    price DOUBLE,
    calories INT,
    recipeType CHAR(1)
);



