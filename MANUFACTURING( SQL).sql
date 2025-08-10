CREATE DATABASE manufacturing;
USE manufacturing;
select * from quality_inspections;
CREATE TABLE production_data (
    Batch_ID VARCHAR(50),
    Date DATE,
    Shift VARCHAR(50),
    Department VARCHAR(50),
    Machine VARCHAR(50),
    Operator_Name VARCHAR(50),
    Shift_Supervisor VARCHAR(50),
    Total_Operating_Time_Min INT,
    Downtime_Minutes INT,
    Units_Produced INT
);
select * from production_datas;
ALTER TABLE production_datas
RENAME COLUMN `ï»¿Batch_ID` TO Batch_ID;
ALTER TABLE quality_inspections
RENAME COLUMN `ï»¿Batch_ID` TO Batch_ID;
##############################(1)-- Example: Get top 10 batches in Assembly department by highest Units Produced
-- 1a_Select_Where_OrderBy
SELECT Batch_ID,Department, Units_Produced
FROM production_datas
WHERE Department = 'Assembly'
ORDER BY Units_Produced DESC
LIMIT 10;

-- 1_b_Example: Group by Department and get total Units Produced
SELECT Department, SUM(Units_Produced) AS Total_Units
FROM production_datas
GROUP BY Department
ORDER BY Total_Units DESC;
#########################(2_a)-- INNER JOIN: Link production and quality data by Batch_ID
SELECT p.Batch_ID, p.Department, q.Product_Name, p.Units_Produced, q.Units_Checked, q.Defective_Units
FROM production_datas p
INNER JOIN quality_inspections q
ON p.Batch_ID = q.Batch_ID;

#--2-b- LEFT JOIN: Keep all production records, even if not inspected
SELECT p.Batch_ID, p.Department, q.Product_Name
FROM production_datas p
LEFT JOIN quality_inspections q
ON p.Batch_ID = q.Batch_ID;

#--2-c RIGHT JOIN: Keep all quality inspection records, even if no production match
SELECT p.Batch_ID, q.Product_Name, p.Department
FROM production_datas p
RIGHT JOIN quality_inspections q
ON p.Batch_ID = q.Batch_ID;
###########################(3_a)-- Operators with above-average production
SELECT Operator_Name, SUM(Units_Produced) AS Total_Produced
FROM production_datas
GROUP BY Operator_Name
HAVING SUM(Units_Produced) > (
    SELECT AVG(total) FROM (
        SELECT SUM(Units_Produced) AS total
        FROM production_datas
        GROUP BY Operator_Name
    ) sub
);

#--3-b- Products with defect rate higher than 10%
SELECT Product_Name, 
       (SUM(Defective_Units) * 100.0 / SUM(Units_Checked)) AS Defect_Percentage
FROM quality_inspections
GROUP BY Product_Name
HAVING (SUM(Defective_Units) * 100.0 / SUM(Units_Checked)) > 10;

##########################(4-a)-- Total Units Produced
SELECT SUM(Units_Produced) AS Total_Units FROM production_datas;

#--4-b Average Downtime per Department
SELECT Department, AVG(Downtime_Minutes) AS Avg_Downtime
FROM production_datas
GROUP BY Department;

#--4-c Total defects by defect type
SELECT Defect_Type, SUM(Defective_Units) AS Total_Defects
FROM quality_inspections
GROUP BY Defect_Type;
###########################(5-a)-- Department-wise Efficiency
CREATE VIEW department_efficiency AS
SELECT Department,
       SUM(Units_Produced) AS Total_Units,
       AVG(Downtime_Minutes) AS Avg_Downtime
FROM production_datas
GROUP BY Department;
SELECT * FROM department_efficiency;


#5-b-- Defect Summary by Supplier/Product
CREATE VIEW defect_summary AS
SELECT Product_Name, Defect_Type, SUM(Defective_Units) AS Total_Defects
FROM quality_inspections
GROUP BY Product_Name, Defect_Type;
SELECT * FROM defect_summary;
###############################(6)

-- Drop if already exists
DROP INDEX idx_production_date ON production_datas; 
DROP INDEX idx_production_department ON production_datas; 

-- Create indexes (length only for string columns)
CREATE INDEX idx_production_date ON production_datas(Date(20)); 
CREATE INDEX idx_production_department ON production_datas(Department(50)); 
CREATE INDEX idx_quality_product ON quality_inspections(Product_Name(50));


