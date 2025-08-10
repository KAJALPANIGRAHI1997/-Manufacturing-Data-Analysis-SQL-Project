# 📊 Manufacturing Data Analysis – SQL Project

## 📌 Overview

This project demonstrates **SQL-based data analysis** for a manufacturing environment using **Production Data** and **Quality Inspection Data**.
The goal is to analyze production efficiency, defect rates, downtime, and department-level performance.

The project includes:

* **SQL scripts** for database creation, queries, joins, aggregations, and indexes.
* **Sample datasets** in CSV format.
* **Visual results** (via screenshots) of executed queries.

---

## 📂 Project Structure

```
📁 Manufacturing-SQL-Analysis
│── 📄 MANUFACTURING(SQL).sql      # Main SQL script with queries
│── 📄 PRODUCTION DATA.csv         # Production-related dataset
│── 📄 Quality_Inspection.csv      # Quality inspection dataset
│── 📁 screenshots                 # Query results & insights
│── 📄 README.md                   # Project documentation
```

---

## 🗄️ Datasets

### 1. **Production Data**

Contains details of batches, machines, operators, and production metrics.
**Key Columns:**

* `Batch_ID` – Unique batch identifier
* `Date` – Production date
* `Shift`, `Department` – Work shift & department
* `Machine` – Machine used
* `Operator_Name`, `Shift_Supervisor`
* `Total_Operating_Time_Min`, `Downtime_Minutes`
* `Units_Produced`

### 2. **Quality Inspection Data**

Contains inspection results for products.
**Key Columns:**

* `Batch_ID` – Links to production data
* `Product_Name`
* `Units_Checked`, `Defective_Units`
* `Defect_Type`

---

## 🛠 SQL Features Implemented

1. **Database & Table Creation**

   * `CREATE DATABASE manufacturing`
   * Table schemas for `production_datas` and `quality_inspections`

2. **Data Cleaning**

   * Renaming columns to fix encoding issues

3. **Basic Queries**

   * Filtering, sorting, and grouping results

4. **Joins**

   * INNER JOIN, LEFT JOIN, RIGHT JOIN between production and quality datasets

5. **Aggregate Analysis**

   * Total units produced by department
   * Operators above average productivity
   * Products with defect rates >10%

6. **Views**

   * `department_efficiency`
   * `defect_summary`

7. **Indexing**

   * Performance optimization using indexes

---

## 📈 Example Insights

* **Top 10 batches** in the Assembly department by units produced.
* **Average downtime** per department.
* **Defect rate analysis** per product.
* **Supplier & defect-type breakdown**.

---

## 📸 Screenshots

Screenshots of query results are available in the `screenshots` folder. These include:

* Department-wise efficiency
* Defect summaries
* High-performing operators
* Joins between production & quality data

---

## 🚀 How to Use

1. Import CSV files into your SQL environment (MySQL, MariaDB, etc.).
2. Run the SQL script `MANUFACTURING(SQL).sql` step by step.
3. View generated tables, results, and performance metrics.

---

## 💡 Future Enhancements

* Add **data visualizations** using Python/Power BI/Tableau
* Include **stored procedures** for automated reporting
* Integrate **real-time data streaming**

---

## 🏷 License

This project is open-source under the **MIT License**.

