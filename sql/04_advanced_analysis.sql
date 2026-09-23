-- SQL used to support reporting and Tableau analysis
-- 1. Year-over-year sales growth
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY EXTRACT(YEAR FROM order_date)
)

SELECT
    year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        LAG(total_sales) OVER (ORDER BY year),
        2
    ) AS previous_year_sales,
    ROUND(
        (
            total_sales - LAG(total_sales) OVER (ORDER BY year)
        )
        /
        NULLIF(LAG(total_sales) OVER (ORDER BY year), 0)
        * 100,
        2
    ) AS yoy_sales_growth_pct
FROM yearly_sales
ORDER BY year;

-- 2. Rank regions by profit within each year
WITH regional_profit AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        region,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY
        EXTRACT(YEAR FROM order_date),
        region
)

SELECT
    year,
    region,
    ROUND(total_profit, 2) AS total_profit,
    RANK() OVER (
        PARTITION BY year
        ORDER BY total_profit DESC
    ) AS profit_rank
FROM regional_profit
ORDER BY year, profit_rank;

-- 3. Monthly sales trend with running sales total
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS monthly_sales
    FROM superstore
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    ROUND(monthly_sales, 2) AS monthly_sales,
    ROUND(
        SUM(monthly_sales) OVER (
            ORDER BY month
        ),
        2
    ) AS running_sales
FROM monthly_sales
ORDER BY month;
