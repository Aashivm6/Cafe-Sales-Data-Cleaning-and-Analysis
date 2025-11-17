-- Exploratory Data Analysis -- 

SELECT * 
FROM dirty_cafe_sales;

-- What are the most common items sold and which items have the highest revenue contribution?

SELECT Item, SUM(`Total Spent`) AS `Total Money Spent`
FROM dirty_cafe_sales 
GROUP BY Item
ORDER BY `Total Money Spent` DESC;

CREATE TEMPORARY TABLE revenue_contribution
SELECT Item, SUM(`Total Spent`) AS `Total Money Spent`, SUM(Quantity) AS `Total Items Bought`
FROM dirty_cafe_sales
GROUP BY Item 
ORDER BY `Total Money Spent` DESC; 

SELECT * 
FROM revenue_contribution; 

-- Which months have the highest sales/revenue contributions?

SELECT 
    MONTH(`Transaction Date`) AS `Month`,
    COUNT(*) AS `Total Purchases`,
    SUM(`Total Spent`) AS `Total Money Spent`,
    (SUM(`Total Spent`)/COUNT(*)) AS `Average Spent Per Purchase`
FROM dirty_cafe_sales
GROUP BY `Month`
ORDER BY `Total Purchases` DESC;

WITH `Rolling Total` AS
(SELECT 
    MONTH(`Transaction Date`) AS `Month`,
    SUM(`Total Spent`) AS `Total Money Spent`
FROM dirty_cafe_sales
GROUP BY `Month`
ORDER BY `Total Money Spent` DESC)
SELECT `Month`, `Total Money Spent`, SUM(`Total Money Spent`) OVER(ORDER BY `Month`) AS rolling_total
FROM `Rolling Total`;
    
-- Which modes of transaction have the highest sales/revenue contributions?

SELECT `Payment Method`, 
		SUM(`Total Spent`) AS `Total Money By Method`, 
        COUNT(`Payment Method`) AS `Payment Method Count`
FROM dirty_cafe_sales
GROUP BY `Payment Method`
ORDER BY `Total Money By Method` DESC;

-- Is revenue higher on weekends or weekdays, in general?

CREATE TEMPORARY TABLE `Purchases By Weekday`
	SELECT DAYNAME(`Transaction Date`) AS `Day of Transaction`, 
		   SUM(`Total Spent`) AS `Money Spent on Day`,
		   SUM(`Quantity`) AS `Total Items Purchased`
	FROM dirty_cafe_sales
    WHERE `Transaction Date` != 'UNKNOWN'
	GROUP BY `Day of Transaction`
	ORDER BY `Money Spent on Day` DESC;
    
SELECT * 
FROM `Purchases By Weekday`;

WITH `Seperating Weekend and Weekday` AS 
(SELECT SUM(`Money Spent on Day`) AS `Total Money Spent`, 
	   SUM(`Total Items Purchased`) AS `Total Items Purchased`,
CASE
	WHEN `Day of Transaction` = 'Saturday' OR `Day of Transaction` = 'Sunday' THEN 'Weekend'
    WHEN `Day of Transaction` != 'Saturday' AND `Day of Transaction` != 'Sunday' THEN 'Weekday'
END AS `Weekend VS Weekday`
FROM `Purchases By Weekday`
GROUP BY `Weekend VS Weekday`
ORDER BY `Weekend VS Weekday` DESC)
SELECT `Weekend VS Weekday`, `Total Items Purchased`, `Total Money Spent`,
CASE 
    WHEN `Weekend VS Weekday` = 'Weekend' THEN `Total Money Spent` / 2
    ELSE `Total Money Spent` / 5
END AS `Average Money Spent Per Day`,
CASE 
    WHEN `Weekend VS Weekday` = 'Weekend' THEN `Total Items Purchased` / 2
    ELSE `Total Items Purchased` / 5
END AS `Average Items Purchased Per Day`
FROM `Seperating Weekend and Weekday`;