create database PediatricNutritionDB;
go
use PediatricNutritionDB;
go

CREATE TABLE food_items (
food_id INT PRIMARY KEY IDENTITY(1,1),
item_name NVARCHAR(100) NOT NULL,
calories_per_100g DECIMAL(10,2),
protein_per_100g DECIMAL(10,2),
iron_mg_per_100g DECIMAL(10,2)
);

CREATE TABLE nutritional_requirements (
requirement_id INT PRIMARY KEY IDENTITY(1,1),
age_group NVARCHAR(50),
target_calories INT,
target_protein_g DECIMAL(10,2),
target_iron_mg DECIMAL(10,2)
);

CREATE TABLE daily_intake (
entry_id INT PRIMARY KEY IDENTITY(1,1),
entry_date DATE DEFAULT GETDATE(),
food_id INT NOT NULL,
quantity_grams DECIMAL(10,2) NOT NULL,
-- Linking intake to the food items table
CONSTRAINT FK_FoodItem FOREIGN KEY (food_id) REFERENCES food_items(food_id)
);

INSERT INTO nutritional_requirements (age_group, target_calories, target_protein_g, target_iron_mg)
VALUES ('12-24 Months', 1000, 13.0, 7.0);

select *from nutritional_requirements;

iNSERT INTO food_items (item_name, calories_per_100g, protein_per_100g, iron_mg_per_100g)
VALUES
('Whole Milk', 61, 3.2, 0.03),
('Boiled Egg', 155, 13.0, 1.2),
('Oatmeal (Cooked)', 68, 2.4, 1.0),
('Steamed Spinach', 23, 2.9, 2.7),
('Chicken Breast', 165, 31.0, 1.0);

INSERT INTO daily_intake (entry_date, food_id, quantity_grams)
VALUES
('2026-03-01', 1, 250), -- Milk
('2026-03-01', 3, 100), -- Oatmeal
('2026-03-01', 2, 50), -- Half egg
('2026-03-02', 1, 300), -- Milk
('2026-03-02', 5, 40), -- Chicken
('2026-03-02', 4, 30); -- Spinach


create view v_daily_nutritional_summary as
di.entry_date,
ni.age_group,

CREATE VIEW v_daily_nutritional_summary AS
SELECT
daily_intake.entry_date,
nutritional_requirements.age_group;

CREATE VIEW v_daily_nutritional_summary AS
SELECT
di.entry_date,
nr.age_group,
-- Calculate totals based on grams consumed
SUM((fi.calories_per_100g / 100) * di.quantity_grams) AS total_calories,
SUM((fi.protein_per_100g / 100) * di.quantity_grams) AS total_protein,
SUM((fi.iron_mg_per_100g / 100) * di.quantity_grams) AS total_iron,
-- Reference targets
nr.target_calories,
nr.target_protein_g,
nr.target_iron_mg
FROM daily_intake di
JOIN food_items fi ON di.food_id = fi.food_id
CROSS JOIN nutritional_requirements nr -- Use CROSS JOIN since we only have one age group
GROUP BY di.entry_date, nr.age_group, nr.target_calories, nr.target_protein_g, nr.target_iron_mg;


SELECT
entry_date,
total_calories,
CASE
WHEN total_calories < target_calories THEN 'Below Target'
ELSE 'Goal Met'
END AS calorie_status,
total_iron,
target_iron_mg,
-- Calculating the percentage of the daily goal met
CAST((total_iron / target_iron_mg) * 100 AS DECIMAL(10,2)) AS iron_goal_percentage
FROM v_daily_nutritional_summary
ORDER BY entry_date DESC;