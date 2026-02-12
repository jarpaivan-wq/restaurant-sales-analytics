# 🍽️ Restaurant Analytics - SQL Project

A comprehensive SQL analysis project for an Italian restaurant, focusing on product performance, revenue tracking, peak hours identification, service comparison, and menu optimization.

## 📋 Business Context

La Bella Italia is an Italian restaurant offering both dine-in and delivery services. The management needed data-driven insights to:
- Identify top-selling products by category
- Compare revenue between dine-in and delivery services
- Optimize staffing based on peak hours
- Understand average ticket size per service type
- Identify underperforming menu items for potential removal

## 🎯 Key Business Questions Answered

1. **Product Performance**: Which products sell most within each category?
2. **Revenue by Service**: How does dine-in revenue compare to delivery monthly?
3. **Peak Hours**: At what times does the restaurant experience highest demand?
4. **Average Ticket**: How much does a customer spend on average per service type?
5. **Menu Optimization**: Which products are underperforming and should be reviewed?

## 🗄️ Database Schema

The database consists of 6 interconnected tables:

- **categorias** (5 records) - Menu categories: Pastas, Pizzas, Salads, Drinks, Desserts
- **productos** (15 records) - Menu items with prices
- **mesas** (8 records) - Restaurant tables with zone information
- **empleados** (5 records) - Restaurant staff
- **pedidos** (50 records) - Orders with service type and timestamp
- **detalle_pedidos** (146 records) - Order line items with quantities and prices

## 📁 Project Structure

```
restaurant-analytics/
│
├── README.md
├── sql/
│   ├── 01_schema.sql          # Database schema
│   ├── 02_data.sql            # Sample data
│   └── 03_queries.sql         # Business queries
│
├── docs/
│   └── business_questions.md  # Detailed query documentation
│
├── .gitignore
└── LICENSE
```

## 🚀 Getting Started

### Prerequisites
- MySQL 8.0 or higher
- Any SQL client (MySQL Workbench, DBeaver, etc.)

### Setup Instructions

1. **Create Database**
```sql
CREATE DATABASE restaurant_analytics;
USE restaurant_analytics;
```

2. **Execute Schema**
```bash
Run sql/01_schema.sql
```

3. **Load Sample Data**
```bash
Run sql/02_data.sql
```

4. **Run Queries**
```bash
Execute queries from sql/03_queries.sql
```

## 💡 Key Insights

- **Top Products**: Pasta and Pizza categories drive highest revenue
- **Service Comparison**: Dine-in generates higher average ticket than delivery
- **Peak Hours**: Lunch (12-13h) and dinner (19-20h) are highest demand periods
- **Menu Optimization**: Some desserts and salads show low unit sales
- **Revenue Tracking**: Monthly breakdown enables trend analysis by service type

## 🛠️ Technologies Used

- **MySQL** - Database management
- **SQL** - Query language
- **DBeaver** - Database client

## 📚 SQL Concepts Demonstrated

- Multiple INNER JOINs (up to 3 tables)
- Aggregate Functions (SUM, COUNT, AVG)
- Conditional aggregation (COALESCE, NULLIF)
- Date/Time Functions (DATE_FORMAT, HOUR)
- GROUP BY with HAVING clauses
- Common Table Expressions (CTEs)
- Defensive coding patterns (NULL handling)
- Multi-level ORDER BY

## 📈 Future Enhancements

- Add weekly revenue trends analysis
- Build employee performance metrics
- Implement table turnover rate analysis
- Create seasonal menu performance comparison
- Add customer satisfaction correlation with order size

## 📧 Contact

Created for portfolio demonstration - SQL analytics for Food & Beverage industry

---

⭐ If you found this project useful, please consider giving it a star!
