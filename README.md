# Hotel-Bookings-Demand-Analysis
SQL and Power BI project analyzing hotel booking demand to uncover trends, cancellations, guest profiles, and revenue insights for better occupancy and revenue management.

---

# Hotel Booking Demand Analysis

## Overview

This project analyzes the **Hotel Booking Demand dataset** from Kaggle, containing nearly **120,000 records** across both city and resort hotels. The dataset includes booking details such as stay duration, booking channels, cancellations, guest demographics, and revenue metrics.

The analysis was performed in **SQL** (after initial formatting in Excel), and the results were visualized in **Power BI** to uncover booking patterns, guest behavior, and financial performance.

## Objectives

* Clean and preprocess the raw hotel booking data.
* Analyze booking trends, cancellations, guest profiles, and revenue performance.
* Visualize key findings through an interactive Power BI dashboard.
* Provide data-driven recommendations for improving occupancy and revenue management.

## Tools & Technologies

* **Excel** – Data formatting for SQL import
* **SQL (MySQL)** – Data cleaning, querying, and analysis
* **Power BI** – Data visualization and reporting

## Data Preparation

* Imported raw dataset into SQL with correct data types.
* Handled missing values (e.g., agent, company, country).
* Generated derived fields such as total stay duration and monthly booking trends.
* Filtered and segmented data for analysis (e.g., booking channels, rate plans, guest type).

## Key Insights

* **Booking Trends**: Clear seasonality with peak demand during holidays; OTAs dominate as the main booking channel.
* **Cancellations**: High cancellation rates linked to OTA bookings and first-time guests; non-refundable plans reduce cancellations.
* **Revenue & ADR**: ADR fluctuates with seasonality and peaks during high-demand months; premium room types drive higher revenue.
* **Special Requests**: Guests with requests (e.g., upgrades, late check-out) show higher return rates and spending.
* **Guest Profiles**: Repeat guests and loyalty members account for a large share of revenue with longer stays and higher ADR.

## Recommendations

* **Target High-Value Guests**: Strengthen loyalty programs and tailor promotions to repeat customers.
* **Reduce Cancellations**: Promote non-refundable and flexible-secure rate plans.
* **Revenue Optimization**: Use dynamic pricing strategies based on seasonality and booking channels.
* **Enhance Guest Experience**: Prioritize fulfilling special requests to drive loyalty and lifetime value.
* **Channel Management**: Reduce dependency on OTAs by encouraging direct bookings.

## Dashboard Features (Power BI)

* Interactive slicers for hotel type, booking channel, and guest type.
* KPIs for total bookings, cancellations, ADR, and revenue.
* Line charts showing seasonality in bookings and ADR.
* Bar charts comparing cancellations, revenue, and stay durations across categories.
