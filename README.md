# Global-Tech-Layoffs-Analysis-Using-SQL

# 🌐 Global Tech Layoffs Analysis Using SQL

This project involves end-to-end data cleaning and exploratory data analysis (EDA) using SQL on a dataset of global tech layoffs. It includes creating database schemas, transforming raw data, handling duplicates and null values, and performing insightful aggregations and trend analyses.

## 📂 Dataset
- **Source:** [Layoffs dataset](layoffs.csv)
- **Size:** ~400+ companies, global coverage
- **Fields:** Company, Location, Industry, Layoff Count, Percentage Laid Off, Date, Stage, Country, Funds Raised

## 🧰 Tools & Technologies
- MySQL / SQL
- SQL Workbench / DBeaver
- Excel / CSV preprocessing
- Git & GitHub

## 🏗️ Project Structure

1. **Database & Table Creation**  
   - Created schema `world_layoffs` and table `layoffs` using `CREATE TABLE`.
   - Loaded data using `INSERT INTO` with date conversion.

2. **Data Cleaning (`Data_Cleaning.sql`)**  
   - Removed duplicates using `ROW_NUMBER() OVER (PARTITION BY ...)`.
   - Standardized columns like `company`, `country`, and `industry`.
   - Fixed date formats and handled NULLs appropriately.
   - Cleaned industry names and imputed missing values using joins.

3. **Exploratory Data Analysis (`EDA.sql`)**  
   - Identified top affected companies, trends over months/years.
   - Aggregated layoffs by industry, country, and funding stage.
   - Used window functions (`DENSE_RANK`, `ROLLING SUM`) to capture patterns.

## 📈 Key Insights
- Most layoffs occurred between mid-2022 to early 2023.
- The US was the most affected country.
- Tech giants like Google and Amazon had major layoffs.
- Startups with large funding rounds also saw significant job cuts.

## 📄 SQL Files
- `layoffs_sql_code_single_insert.sql`: Schema & table creation with raw inserts.
- `Data_Cleaning.sql`: Full cleaning workflow.
- `EDA.sql`: Exploratory queries and trend analysis.

## 🔍 Future Improvements
- Create dashboards using Tableau or Power BI.
- Add Python notebooks for visualization and automation.
- Integrate external APIs for real-time data updates.

## 📬 Contact
**Sanyam Gandotra**  
[LinkedIn](https://linkedin.com/in/your-profile) • [Email](mailto:your-email@example.com)
