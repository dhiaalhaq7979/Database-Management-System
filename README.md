# Database Management System — Library Management (MySQL)

![MySQL](https://img.shields.io/badge/MySQL-8-4479A1?style=flat-square&logo=mysql&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-10.11-003545?style=flat-square&logo=mariadb&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

Database Systems (Theory + Lab) coursework. I designed a relational database for a **university library**: books, authors, categories, members and loans — with primary and foreign keys, constraints, sample data, CRUD statements, JOINs, GROUP BY reports, views and subqueries. The `db-lab-exercises/` folder holds my weekly SQL lab practice on the same database.

## ER diagram

```mermaid
erDiagram
    AUTHORS ||--o{ BOOK_AUTHORS : writes
    BOOKS ||--o{ BOOK_AUTHORS : "written by"
    CATEGORIES ||--o{ BOOKS : contains
    BOOKS ||--o{ LOANS : "is borrowed in"
    MEMBERS ||--o{ LOANS : makes
    AUTHORS {
        int author_id PK
        varchar full_name
        varchar country
    }
    CATEGORIES {
        int category_id PK
        varchar name UK
    }
    BOOKS {
        int book_id PK
        varchar title
        varchar isbn UK
        int category_id FK
        year published_year
        int total_copies
        int available_copies
    }
    BOOK_AUTHORS {
        int book_id PK, FK
        int author_id PK, FK
    }
    MEMBERS {
        int member_id PK
        varchar full_name
        varchar email UK
        varchar phone
        enum member_type
        date joined_on
    }
    LOANS {
        int loan_id PK
        int book_id FK
        int member_id FK
        date loan_date
        date due_date
        date return_date
        decimal fine_amount
    }
```

![ER diagram](screenshots/er-diagram.png)

**Relationships**

- A **category** has many books (1 : N), `ON DELETE SET NULL`
- A **book** can have many authors and an **author** many books (M : N through `book_authors`)
- A **member** makes many **loans**, and every loan refers to one book (1 : N)

## Project structure

```
library-management/
├── 01_schema.sql        # CREATE DATABASE + tables, PK/FK, UNIQUE, CHECK, indexes
├── 02_seed_data.sql     # sample categories, authors, books, members, loans
├── 03_queries.sql       # CRUD, JOINs, GROUP BY / HAVING, subquery reports
└── 04_views.sql         # active_loans and book_availability views
db-lab-exercises/
├── lab-01-basic-select.sql   # SELECT, WHERE, LIKE, ORDER BY, LIMIT
├── lab-02-constraints.sql    # what each constraint prevents (+ ON DELETE SET NULL demo)
├── lab-03-joins.sql          # INNER / LEFT joins, self-join on loans
├── lab-04-aggregates.sql     # COUNT, SUM, AVG, MIN, MAX, HAVING
└── lab-05-subqueries.sql     # IN, NOT IN, EXISTS, scalar subquery
run_all.sh                    # builds the database and runs every file
```

## How to run

```bash
# MySQL / MariaDB must be installed
./run_all.sh                       # asks for the root password
# or, on Linux with socket auth:
MYSQL="sudo mysql" ./run_all.sh
```

Or file by file:

```bash
mysql -u root -p < library-management/01_schema.sql
mysql -u root -p < library-management/02_seed_data.sql
mysql -u root -p --table < library-management/03_queries.sql
```

## Example reports

| Report | SQL features |
|---|---|
| Books with all their authors | 3-table JOIN, `GROUP_CONCAT` |
| Books currently on loan and who has them | JOIN + `WHERE return_date IS NULL` |
| Members who never borrowed anything | `LEFT JOIN … IS NULL` |
| Loans and total fines per member | `GROUP BY`, `COUNT`, `SUM` |
| Most borrowed categories | JOIN + `GROUP BY` + `ORDER BY` |
| Overdue loans and days late | `DATEDIFF` |
| Books borrowed more than average | `HAVING` with a nested subquery |

## Output screenshots

![CRUD and JOIN queries](screenshots/queries-crud-joins.png)

![GROUP BY reports](screenshots/queries-reports.png)

## What I learned

- Normalising data into separate tables and linking them with foreign keys
- Using a junction table for a many-to-many relationship
- How `CHECK`, `UNIQUE` and `ON DELETE` rules protect the data
- Writing reports with JOIN, GROUP BY, HAVING and subqueries

## Author

**Dheya Alhag** — BS Software Engineering, Superior University, Lahore
GitHub: [@dhiaalhaq7979](https://github.com/dhiaalhaq7979)
