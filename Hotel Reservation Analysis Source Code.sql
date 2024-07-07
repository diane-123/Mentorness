-- Hotel Reservation Analysis with SQL 

CREATE TABLE hotel_reservation_data (
	booking_id varchar,
	no_of_adults int,
	no_of_children int,
	no_of_weekend_nights int,
	no_of_week_nights int,
	type_of_meal_plan varchar,
	room_type_reserved varchar,
	lead_time int,
	arrival_date date,
	market_segment_type varchar,
	avg_price_per_room float,
	booking_status varchar
);

SELECT * FROM hotel_reservation_data

-- 1: What is the total number of reservations in the dataset?

-- Total number of reservations (whether canceled or not) 
SELECT count(booking_id) AS total_reservations
FROM hotel_reservation_data


-- 2: Which meal plan is the most popular among guests? 
SELECT type_of_meal_plan, count(type_of_meal_plan) AS no_of_meal_plan_ordered
FROM hotel_reservation_data
GROUP BY type_of_meal_plan
ORDER BY no_of_meal_plan_ordered DESC


-- 3: What is the average price per room for reservations involving children?  
SELECT avg(avg_price_per_room) 
FROM hotel_reservation_data
WHERE no_of_children > 0


-- 4: How many reservations were made for the year 20XX (replace XX with the desired year)? 
SELECT 
EXTRACT (YEAR FROM arrival_date) AS YEAR, count(booking_id) AS reservation_count
FROM hotel_reservation_data
GROUP BY YEAR


-- 5: What is the most commonly booked room type?  
SELECT room_type_reserved AS room_type, count(room_type_reserved) AS reservation_count
FROM hotel_reservation_data
GROUP BY room_type_reserved
ORDER BY reservation_count DESC


--  6: How many reservations fall on a weekend (no_of_weekend_nights > 0)?  
SELECT count(booking_id) AS total_reservations
FROM hotel_reservation_data
WHERE no_of_weekend_nights > 0


-- 7: What is the highest and lowest lead time for reservations? 
SELECT max(lead_time) AS highest_lead_time,  min(lead_time) AS lowest_lead_time
FROM hotel_reservation_data


-- 8: What is the most common market segment type for reservations? 
SELECT market_segment_type, count(market_segment_type) AS count_of_market_segment_type
FROM hotel_reservation_data
GROUP BY market_segment_type
ORDER BY count_of_market_segment_type DESC


-- 9: How many reservations have a booking status of "Confirmed"?  
SELECT count(booking_id) AS total_reservations
FROM hotel_reservation_data
WHERE booking_status = 'Not_Canceled'


-- 10: What is the total number of adults and children across all reservations?  
SELECT SUM(no_of_adults) AS total_no_of_adults, SUM(no_of_children) AS total_no_of_children
FROM hotel_reservation_data


-- 11: What is the average number of weekend nights for reservations involving children? 
-- If a reservation involves or included children, it will be greater than zero. 
-- 0 means no children. If it involves children, it will be greater than 0

SELECT avg(no_of_weekend_nights) 
FROM hotel_reservation_data
WHERE no_of_children > 0


-- 12: How many reservations were made in each month of the year?
SELECT 
EXTRACT (MONTH FROM arrival_date) AS MONTH, EXTRACT (YEAR FROM arrival_date) AS YEAR,
count(booking_id) AS reservation_count
FROM hotel_reservation_data
GROUP BY MONTH, YEAR
ORDER BY MONTH ASC, YEAR DESC


-- 13: What is the average number of nights (both weekend and weekday) spent by guests for each room type?  
SELECT room_type_reserved, avg(no_of_weekend_nights) AS weekend_nights_avg, avg(no_of_week_nights) AS weekday_nights_avg
FROM hotel_reservation_data
GROUP BY room_type_reserved


-- 14: For reservations involving children, what is the most common room type, and what is the average price for that room type?  
SELECT room_type_reserved AS room_type, count(room_type_reserved) AS reservation_count
FROM hotel_reservation_data
WHERE no_of_children > 0
GROUP BY room_type
ORDER BY reservation_count DESC

-- Average price for Room_Type 1
SELECT avg(avg_price_per_room) 
FROM hotel_reservation_data
WHERE room_type_reserved = 'Room_Type 1'


-- 15: Find the market segment type that generates the highest average price per room. 
SELECT market_segment_type, avg(avg_price_per_room) 
FROM hotel_reservation_data
GROUP BY market_segment_type
ORDER BY avg(avg_price_per_room) DESC








