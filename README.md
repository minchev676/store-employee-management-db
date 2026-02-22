# Store Employee Management Database

Relational SQL database system designed to manage employees, departments, work shifts, attendance tracking, and sales operations in a retail store environment.

---

## 📌 Project Overview

This project models a real-world store management system using a structured relational database design.

It demonstrates:

- Proper table structure
- Primary and foreign key constraints
- Data integrity
- Relationship modeling
- Practical business logic implementation

---

## 🗂 Database Structure

### Core Tables

- **employees** – Stores employee information
- **departments** – Store departments
- **shifts** – Work shift scheduling
- **attendance** – Employee check-in and check-out tracking
- **sales** – Sales transactions linked to shifts

---

## 🔗 Relationships

- Each employee belongs to a department
- Each shift can include multiple employees
- Attendance connects employees with shifts
- Sales are associated with specific shifts

The database ensures referential integrity through foreign key constraints.

---

## 🛠 Technologies Used

- SQL (MySQL-compatible syntax)
- Relational Database Modeling
- ER Diagram Design

---

## 🚀 Setup Instructions

1. Import `01_schema.sql` to create the database structure.
2. Run `02_queries.sql` to execute sample queries.
3. Review the ER diagram inside the `/docs` folder for database visualization.

---

## 🎯 Purpose

This project was developed as a personal portfolio project to demonstrate practical database design skills and relational modeling in a business-oriented scenario.

---

## 📄 License

This project is licensed under the MIT License.
