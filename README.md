# Pediatric_Nutrition_SQL_Analysis
SQL based nutritional gap analysis comparing toddler intake against RDA benchmarks.
## Project Overview
This project demonstrates the application of SQL for clinical nutritional assessment. It compares a 1-year-old child's daily intake against Recommended Dietary Allowances (RDA) to identify specific nutrient deficiencies.

## Data Schema
- **food_items**: Reference table for nutritional values per 100g.
- **daily_intake**: Transactional log of food consumed.
- **nutritional_requirements**: Benchmark table for pediatric RDA.

## Key Insights Demonstrated
* **Database Design:** Use of Primary/Foreign keys and data types.
* **Data Transformation:** Calculated nutrient intake based on quantity using SQL logic.
* **Reporting:** Created a `VIEW` for streamlined analysis and used `CASE` statements to flag "Below Target" days.

## How to Run
1. Execute `pediatricnutrition.sql` in SQL Server Management Studio.
2. Populate the data using `pediatricnutrition.sql`.
3. View the analysis by running `pediatricnutrition.sql`.
4. 
