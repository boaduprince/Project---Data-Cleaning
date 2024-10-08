SQL DATA CLEANING PROJECT
This project demonstrates how to clean and preprocess raw data using SQL queries. The data used in this project contains various inconsistencies such as missing values, incorrect data types, and duplicate records. The goal is to transform the raw dataset into a clean and usable format for further analysis.

PROJECT OVERVIEW
In many real-world datasets, data is often incomplete, incorrect, or duplicated. Cleaning data is a crucial step in ensuring the accuracy and reliability of any analysis or reporting done with the dataset. This project showcases SQL techniques used for:

REMOVING DUPLICATES
Handling missing values
Standardizing formats (dates, text)
Correcting data types
Normalizing data for consistency
The dataset used in this project contains customer information, sales records, and product data.

FEATURES
Remove duplicate rows from datasets.
Handle missing or null values by filling, averaging, or deleting rows.
Standardize inconsistent date formats and correct incorrect data types.
Normalize text fields (e.g., ensuring consistent capitalization or removing whitespace).
Perform data validation checks to ensure data integrity.

TECHNOLOGIES USED
SQL (MySQL)
Sample data in CSV format

GETTING STARTED
Prerequisites
To run the SQL scripts in this project, you'll need:

A SQL database system (MySQL, PostgreSQL, etc.)
Access to a SQL management tool (e.g., SQL Server Management Studio or DBeaver)

Installing
Clone the repository to your local machine:
Create a database in your SQL system for this project (e.g., cleaning_project).
Import the raw data into your database. You can find sample SQL CREATE and INSERT statements for tables in the setup.sql file.

Load the raw dataset into your SQL database using the setup.sql file.
Run Data Cleaning Scripts:

Execute each SQL script in sequence to clean and transform the data. For example:
First, run remove_duplicates.sql to remove any duplicate rows.
Next, run handle_missing_values.sql to address any missing values.
Follow by running the remaining scripts to finalize the data cleaning process.
Inspect Cleaned Data:

After running the scripts, verify that the data is cleaned by running basic SQL queries or exporting the cleaned data for further analysis.















