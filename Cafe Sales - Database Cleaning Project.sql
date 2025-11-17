-- DATA CLEANING 

-- 1. Remove Duplicate Values
-- 2. Standardize the Data 
-- 3. Null Values or Blank Values
-- 4. Remove Unnecessary Rows and Columns

SELECT *
FROM dirty_cafe_sales; 


SELECT * 
FROM dirty_cafe_sales; 

SELECT `Transaction ID`, Item, Quantity, `Price Per Unit`, `Total Spent`, `Payment Method`,
Location, `Transaction Date`,  
ROW_NUMBER() OVER(PARTITION BY 	`Transaction ID`) AS row_num
FROM dirty_cafe_sales;

SELECT item, `Price Per Unit`
FROM dirty_cafe_sales
GROUP BY item, `Price Per Unit`;

SELECT DISTINCT(item), `Price Per Unit`
FROM dirty_cafe_sales
WHERE item != 'UNKNOWN' AND item != 'ERROR' AND item != '';

CREATE TEMPORARY TABLE item_price_table
SELECT DISTINCT(item), `Price Per Unit`
FROM dirty_cafe_sales
WHERE item != 'UNKNOWN' AND item != 'ERROR' AND item != '';

SELECT * 
FROM item_price_table;

SELECT  *
FROM dirty_cafe_sales
WHERE Item = 'ERROR';

UPDATE dirty_cafe_sales
SET Item = 'UNKNOWN'
WHERE Item = 'ERROR';

SELECT *
FROM dirty_cafe_sales
WHERE `Price Per Unit` = 2;

UPDATE dirty_cafe_sales 
SET Item = 'Coffee' 
WHERE `Price Per Unit` = 2; 

SELECT *
FROM dirty_cafe_sales
WHERE `Price Per Unit` = 1.5;

UPDATE dirty_cafe_sales 
SET Item = 'Tea' 
WHERE `Price Per Unit` = 1.5; 

SELECT *
FROM dirty_cafe_sales
WHERE `Price Per Unit` = 5;

UPDATE dirty_cafe_sales 
SET Item = 'Salad' 
WHERE `Price Per Unit` = 5; 


SELECT *
FROM dirty_cafe_sales
WHERE `Price Per Unit` = 1;

UPDATE dirty_cafe_sales 
SET Item = 'Cookie' 
WHERE `Price Per Unit` = 1; 

SELECT *
FROM dirty_cafe_sales
WHERE Item = 'UNKNOWN' AND `Price Per Unit` = 3;

UPDATE dirty_cafe_sales 
SET Item = 'Cake/Juice' 
WHERE `Price Per Unit` = 3 AND (Item = 'UNKNOWN' OR Item = ''); 

SELECT *
FROM dirty_cafe_sales
WHERE Item = 'UNKNOWN' AND `Price Per Unit` = 4;

UPDATE dirty_cafe_sales 
SET Item = 'Smoothie/Sandwich' 
WHERE `Price Per Unit` = 4 AND (Item = 'UNKNOWN' OR Item = ''); 

SELECT * 
FROM dirty_cafe_sales 
WHERE Item = '';

SELECT * 
FROM dirty_cafe_sales
WHERE Quantity = 0;

SELECT * 
FROM dirty_cafe_sales
WHERE `Price Per Unit` = 0;

SELECT *
FROM dirty_cafe_sales
WHERE `Total Spent` = 'UNKNOWN' OR `Total Spent` = 'ERROR' OR `Total Spent` = '';

UPDATE dirty_cafe_sales
SET `Total Spent` = `Quantity` * `Price Per Unit`
WHERE `Total Spent` = 'UNKNOWN' OR `Total Spent` = 'ERROR' OR `Total Spent` = '';


SELECT DISTINCT(Item)
FROM dirty_cafe_sales;

SELECT * 
FROM dirty_cafe_sales
WHERE `Payment Method` = '' OR `Payment Method` = 'UNKNOWN' OR `Payment Method` = 'ERROR';

UPDATE dirty_cafe_sales
SET `Payment Method` = 'UNKNOWN' 
WHERE `Payment Method` = '' OR `Payment Method` = 'UNKNOWN' OR `Payment Method` = 'ERROR';

SELECT * 
FROM dirty_cafe_sales
WHERE Location = '' OR Location = 'UNKNOWN' OR Location = 'ERROR';

UPDATE dirty_cafe_sales
SET Location = 'UNKNOWN'
WHERE Location = '' OR Location = 'UNKNOWN' OR Location = 'ERROR';

SELECT * 
FROM dirty_cafe_sales
WHERE `Transaction Date` = '' OR `Transaction Date` = 'UNKNOWN' OR `Transaction Date` = 'ERROR';

UPDATE dirty_cafe_sales
SET `Transaction Date` = 'UNKNOWN'
WHERE `Transaction Date` = '' OR `Transaction Date` = 'UNKNOWN' OR `Transaction Date` = 'ERROR';

SELECT * 
FROM dirty_cafe_sales;

