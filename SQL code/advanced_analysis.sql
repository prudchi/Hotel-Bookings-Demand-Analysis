-- ==========================================
-- PHASE 3: ADVANCED ANALYSIS
-- ==========================================
USE hotel_bookings_demand;

-- ==========================================
-- SEASONALITY AND TRENDS
-- ==========================================
# 1. Which months bring in the most revenue
SELECT 
    arrival_date_month AS month,
    ROUND(SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)), 2) AS total_revenue
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY total_revenue DESC;

# 2. Do cancellations peak in certain months?
SELECT 
    arrival_date_month AS month,
    SUM(is_canceled) AS total_cancellations,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY total_cancellations DESC;

# 3. Comparing monthly trends across hotel types (City vs Resort)
SELECT 
    hotel,
    arrival_date_month AS month,
    ROUND(SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)), 2) AS total_revenue,
    SUM(is_canceled) AS total_cancellations,
    COUNT(*) AS total_bookings,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY hotel, arrival_date_month
ORDER BY hotel, FIELD(arrival_date_month,
    'January','February','March','April','May','June',
    'July','August','September','October','November','December');
    
-- ==========================================
-- CANCELLATION ANALYSIS
-- ==========================================
USE hotel_bookings_demand;

# 1. Cancellation rate by lead time
SELECT 
    lead_time,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY lead_time
ORDER BY lead_time ASC;

# 2. Are certain deposit types or customer types more likely to cancel?
SELECT 
    deposit_type,
    customer_type,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percentage,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY deposit_type, customer_type
ORDER BY cancellation_rate_percentage DESC;

# 3. Cancellation impact on revenue loss
SELECT 
    CASE WHEN is_canceled = 1 THEN 'Cancelled' ELSE 'Not Cancelled' END AS booking_status,
    COUNT(*) AS total_bookings,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_percentage,
    ROUND(SUM(adr * (stays_in_week_nights + stays_in_weekend_nights)), 2) AS total_revenue
FROM hotel_bookings
GROUP BY booking_status;

-- ==========================================
-- GUEST BEHAVIOR INSIGHTS
-- ==========================================

# 1. Which markets/segments bring the most repeated guests?
SELECT
	market_segment,
    SUM(is_repeated_guest) AS total_repeated_guests,
    COUNT(*) AS total_bookings,
    ROUND(SUM(is_repeated_guest)*100 / COUNT(*),2) AS repeated_guest_percentage
FROM hotel_bookings
GROUP BY market_segment
ORDER BY total_repeated_guests DESC;

# 2. What’s the average stay length trend over the years?
SELECT 
	arrival_date_year,
	ROUND(AVG(stays_in_weekend_nights + stays_in_week_nights),2) AS average_stay_length
FROM hotel_bookings
GROUP BY arrival_date_year;

-- ==========================================
-- REVENUE OPTIMIZATION
-- ==========================================

# 1. Revenue per available room:
SELECT 
	assigned_room_type,
    COUNT(*) AS total_bookings,
    ROUND(SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)),2) AS total_revenue,
    ROUND(SUM(adr* (stays_in_weekend_nights + stays_in_week_nights)) / COUNT(*), 2) AS revenue_per_booking
FROM hotel_bookings
GROUP BY assigned_room_type
ORDER BY revenue_per_booking DESC;

# 2. Which channels and customer types bring the highest revenue after cancellations?
SELECT 
    distribution_channel,
    customer_type,
    ROUND(SUM(CASE WHEN is_canceled = 0 
                   THEN adr * (stays_in_weekend_nights + stays_in_week_nights) 
              END), 2) AS revenue_after_cancellations,
    ROUND(SUM(CASE WHEN is_canceled = 1 
                   THEN adr * (stays_in_weekend_nights + stays_in_week_nights) 
              END), 2) AS lost_revenue,
    ROUND(SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)), 2) AS potential_revenue
FROM hotel_bookings
GROUP BY distribution_channel, customer_type
ORDER BY revenue_after_cancellations DESC;

-- ==========================================
-- BOOKING LEAD TIME
-- ==========================================

# 1. Average lead time before booking per hotel
SELECT 
	hotel,
	ROUND(AVG(lead_time),2) AS avg_lead_time
FROM hotel_bookings
GROUP BY hotel;

# 2. Lead time distribution by market segment
SELECT 
	market_segment,
    ROUND(AVG(lead_time), 2) AS avg_lead_time,
    MIN(lead_time) AS min_lead_time,
    MAX(lead_time) AS max_lead_time
FROM hotel_bookings
GROUP BY market_segment
ORDER BY avg_lead_time DESC;

# 3.Relationship between lead time and cancellations: Check if longer lead times equal higher chance of cancellations.
SELECT 
	CASE 
		WHEN lead_time BETWEEN 0 and 30 THEN '0-30 days'
        WHEN lead_time BETWEEN 31 and 90 THEN '31-90 days'
        WHEN lead_time BETWEEN 91 and 180 THEN '91-180 days'
		WHEN lead_time BETWEEN 181 and 365 THEN '181-365 days' 
        ELSE '365+ days' END as lead_time_bucket,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS total_cancellations,
    ROUND(SUM(is_canceled) *100 / COUNT(*), 2) AS cancellation_perc_rate
FROM hotel_bookings
GROUP BY lead_time_bucket
ORDER BY 
   CASE 
       WHEN lead_time_bucket = '0-30 days' THEN 1
       WHEN lead_time_bucket = '31-90 days' THEN 2
       WHEN lead_time_bucket = '91-180 days' THEN 3
       WHEN lead_time_bucket = '181-365 days' THEN 4
       WHEN lead_time_bucket = '365+ days' THEN 5
   END;