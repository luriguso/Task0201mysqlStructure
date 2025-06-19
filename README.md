# 🧠 Database Modeling Exercises – Entity-Relationship Diagrams

---

## 📄 Description – Project Overview

This repository contains solutions to a series of structured exercises focused on designing relational databases using entity-relationship (ER) diagrams. The goal is to practice logical database design for different real-world scenarios, applying best practices and correct relationships.

The exercises are organized into three levels of difficulty, from basic models to more complex structures with multiple entities and relationships.

---

## 🎯 Objectives

- Learn to model SQL databases using entity-relationship diagrams.
- Understand and properly apply concepts such as entities, attributes, primary and foreign keys, and relationships.
- Verify that the design supports typical queries for each practical case.

---

## 💻 Technologies Used

- Entity-Relationship diagram modeling.
- Relational database MySQL (for validation queries).
- Git & GitHub for version control.

---

## 📋 Requirements

- Basic knowledge of relational databases and SQL.
- ER diagram modeling tool (optional, recommended).
- MySQL installed locally for testing (optional).

---

## 🛠️ Installation and Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/luriguso/Task0201mysqlStructure.git
   cd db-modeling-exercises
   ```

2. Open the ER diagrams with Workbench.

3. Implement the SQL scripts to create tables and relationships according to the proposed models (if included).

4. Execute queries to validate the model integrity.

---

## 🧩 Exercises and Levels

### 🔹 Level 1

- **Exercise 1 - Optics “Cul d'Ampolla”**  
  Model for managing clients, suppliers, employees, and glasses sales. 
  Includes entities for provider, glass (with detailed features), clients, employees and sale.

- **Exercise 2 - Pizzeria**  
  Database for online food orders, with clients, products, categories, stores, and employees.

  Normalized data for localities and provinces.  
  Order model including date, type (delivery or pickup), quantity, total price, and relationships with products and stores.  
  Employee management with specific roles (cooks, delivery persons) and delivery tracking.

### 🔹 Level 2

- **Exercise 1 - YouTube**  
  Simple model for managing user, video, tags, channels, subscriptions, likes/dislikes, comments, and playlists.

### 🔹 Level 3

- **Exercise 1 - Spotify**  
  Modeling free and premium users, subscriptions, payments, playlists (active and deleted), songs, albums, artists, favorites, and artist relationships.

---

## 📌 Validation Queries

To check that the design is correct, typical queries are proposed that should return consistent results:

- **Optics:**  
  - Total invoices of a client within a given period.  
  - Models of glasses sold by an employee during a year.  
  - Suppliers who have supplied glasses successfully sold.

- **Pizzeria:**  
  - Number of products from category "Drinks" sold in a specific locality.  
  - Number of orders made by a specific employee.

---

## 🌐 Deployment

This project is for educational use only and is not intended for production deployment.

---

## 🤝 Contributions

Contributions are welcome. To contribute:  
1. Fork the repository.  
2. Create a feature branch: `git checkout -b feature/my-feature`.  
3. Commit your changes.  
4. Push to your branch: `git push origin feature/my-feature`.  
5. Open a Pull Request.

---

## ✨ Author

[Your Name] – [luriguso]  
🌐 [GitHub Profile](https://github.com/luriguso)

---

## 📝 License

This project is part of an educational exercise and is not licensed for commercial use.
