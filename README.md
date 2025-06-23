# 📚 Mini Library Management System (SQL)

A simple SQL-based relational database for managing a small library.  
It includes tables for members, authors, books, borrowing, and returns — complete with sample data and useful queries for reporting.

---

## 🗂️ Features

- Track library members and their contact details
- Manage book inventory with authors and genres
- Record which member borrowed which book and when
- Track return dates and calculate fines
- Run queries to generate reports (e.g. overdue returns, most borrowed books, total fines)

---

## 🛠️ Technologies Used

- MySQL / MariaDB
- SQL (DDL + DML)

---

## 📄 Schema Overview

| Table Name | Description |
|------------|-------------|
| `Members`  | Stores library members |
| `Authors`  | Stores book authors |
| `Books`    | Stores book details and stock |
| `Borrow`   | Records books borrowed by members |
| `Returns`  | Tracks returns and fines |

---

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/mini-library-db.git
   cd mini-library-db
