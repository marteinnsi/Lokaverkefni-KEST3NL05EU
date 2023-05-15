CREATE DATABASE IF NOT EXISTS HumanResource;

USE HumanResource;

CREATE TABLE Employees (
  Kennitala VARCHAR(11),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Email VARCHAR(255),
  PhoneNumber VARCHAR(20),
  HireDate DATE,
  Salary DECIMAL(10, 2),
  PRIMARY KEY (Kennitala)
);

CREATE TABLE Departments (
  DepartmentID INT,
  DepartmentName VARCHAR(255),
  ManagerKennitala VARCHAR(11),
  PRIMARY KEY (DepartmentID)
);

CREATE TABLE Locations (
  LocationID INT,
  City VARCHAR(255),
  Address VARCHAR(255),
  ZipCode VARCHAR(10),
  PRIMARY KEY (LocationID)
);

CREATE TABLE Jobs (
  JobID INT,
  JobTitle VARCHAR(255),
  MinSalary DECIMAL(10, 2),
  MaxSalary DECIMAL(10, 2),
  PRIMARY KEY (JobID)
);
