-- ==========================================
-- Hotel Bookings EXPLORATORY DATA ANALYSIS(Phase 2)
-- Dataset: Hotel Bookings Demand
-- Author: Prudence Chishiri
-- Description: Exploratory analysis including
-- bookings demand, cancellations, guest profiles,
-- revenue, and special requests.
-- ==========================================

USE hotel_bookings_demand;

-- ==========================================
-- 1. BOOKINGS DEMAND
-- ==========================================

-- Total bookings per year
SELECT 
    arrival_date_year,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY arrival_date_year
ORDER BY total_bookings ASC;

-- Total bookings per month
SELECT 
    arrival_date_month AS month,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY FIELD(month,
    'January','February','March','April','May','June',
    'July','August','September','October','November','December');

-- Most booked hotel type
SELECT 
    hotel,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_bookings DESC;

-- ==========================================
-- 2. CANCELLATIONS
-- ==========================================

-- Cancellations by customer type, deposit type, and hotel
SELECT 
    customer_type,
    deposit_type,
    hotel,
    COUNT(CASE WHEN is_canceled = 1 THEN 1 END) AS cancelled_bookings,
    COUNT(CASE WHEN is_canceled = 0 THEN 1 END) AS confirmed_bookings,
    ROUND(SUM(is_canceled) * 100 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY customer_type, deposit_type, hotel
ORDER BY cancellation_rate_percentage DESC;

-- ==========================================
-- 3. GUEST PROFILE
-- ==========================================

-- Average group size per hotel
SELECT 
    hotel,
    ROUND(AVG(adults), 2) AS avg_adults,
    ROUND(AVG(children), 2) AS avg_children,
    ROUND(AVG(babies), 2) AS avg_babies
FROM hotel_bookings
GROUP BY hotel;

-- Top 10 countries by total bookings
SELECT 
    country,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;

-- Repeated vs first-time guests
SELECT
    COUNT(CASE WHEN is_repeated_guest = 0 THEN 1 END) AS first_time_guests,
    COUNT(CASE WHEN is_repeated_guest = 1 THEN 1 END) AS repeated_guests,
    ROUND(SUM(is_repeated_guest) * 100 / COUNT(*), 2) AS repetition_percentage
FROM hotel_bookings;

-- Average, longest, and shortest stay length by hotel
SELECT 
    hotel,
    ROUND(AVG(stays_in_weekend_nights + stays_in_week_nights), 2) AS avg_length_of_stay,
    MAX(stays_in_weekend_nights + stays_in_week_nights) AS longest_stay,
    MIN(stays_in_weekend_nights + stays_in_week_nights) AS shortest_stay
FROM hotel_bookings
GROUP BY hotel;

-- ==========================================
-- 4. REVENUE ANALYSIS
-- ==========================================

-- Total revenue per hotel
SELECT 
    hotel,
    SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_revenue DESC;

-- Average daily rate by hotel
SELECT 
    hotel,
    ROUND(AVG(adr), 2) AS average_daily_rate
FROM hotel_bookings
GROUP BY hotel;

-- Revenue by market segment
SELECT 
    market_segment,
    SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_revenue DESC;

-- Revenue by year
SELECT 
    arrival_date_year,
    SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM hotel_bookings
GROUP BY arrival_date_year
ORDER BY total_revenue DESC;

-- Distribution channels by total bookings
SELECT 
    distribution_channel,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY total_bookings DESC;

-- Cancellations by distribution channel
SELECT 
    distribution_channel,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS cancelled_bookings,
    ROUND(SUM(is_canceled) * 100 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY cancellation_rate_percentage DESC;

-- ==========================================
-- 5. DISTRIBUTION CHANNELS
-- ==========================================

-- Total bookings per distribution channel
SELECT 
    distribution_channel,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY total_bookings DESC;

-- Cancellation rates per distribution channel
SELECT 
    distribution_channel,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS cancelled_bookings,
    ROUND(SUM(is_canceled) * 100 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY cancellation_rate_percentage DESC;

-- Revenue contribution by distribution channel
SELECT 
    distribution_channel,
    ROUND(SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)), 2) AS total_revenue,
    ROUND(AVG(adr), 2) AS avg_daily_rate,
    ROUND(AVG(adr * (stays_in_weekend_nights + stays_in_week_nights)), 2) AS avg_booking_revenue
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY total_revenue DESC;

-- ==========================================
-- 6. SPECIAL REQUESTS & CUSTOMER PREFERENCES
-- ==========================================

-- Most common number of special requests
SELECT 
    total_of_special_requests,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY total_bookings DESC;

-- Impact of special requests on cancellation rates
SELECT 
    total_of_special_requests,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS cancelled_bookings,
    ROUND(SUM(is_canceled) * 100 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY cancellation_rate_percentage DESC;

-- Parking space requests vs cancellations
SELECT 
    required_car_parking_spaces,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS cancelled_bookings,
    ROUND(SUM(is_canceled) * 100 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY required_car_parking_spaces
ORDER BY required_car_parking_spaces ASC;

-- Special requests impact on revenue
SELECT 
    total_of_special_requests,
    ROUND(AVG(adr), 2) AS avg_daily_rate,
    ROUND(SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)), 2) AS total_revenue
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY total_revenue DESC;


