-- Validate Superstore dataset before analysis

-- 1. Basic dataset size and uniqueness checks
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT row_id) AS unique_row_ids,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id) AS unique_products
FROM superstore;

-- 2. Check for missing values in key fields
SELECT
    COUNT(*) - COUNT(row_id) AS missing_row_id,
    COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(order_date) AS missing_order_date,
    COUNT(*) - COUNT(ship_date) AS missing_ship_date,
    COUNT(*) - COUNT(customer_id) AS missing_customer_id,
    COUNT(*) - COUNT(product_id) AS missing_product_id,
    COUNT(*) - COUNT(sales) AS missing_sales,
    COUNT(*) - COUNT(quantity) AS missing_quantity,
    COUNT(*) - COUNT(discount) AS missing_discount,
    COUNT(*) - COUNT(profit) AS missing_profit
FROM superstore;

-- 3. Check for duplicate row IDs
SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1;

-- 4. Confirm row IDs are unique
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT row_id) AS unique_row_ids
FROM superstore;

-- 5. Check repeated order IDs
-- Repeated order IDs are expected because one order can contain multiple products
SELECT
    order_id,
    COUNT(*) AS line_items
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY line_items DESC
LIMIT 10;

-- 6. Check for invalid numeric values
SELECT *
FROM superstore
WHERE sales < 0
   OR quantity <= 0
   OR discount < 0
   OR discount > 1;

-- 7. Check for negative-profit transactions
SELECT
    COUNT(*) AS negative_profit_rows
FROM superstore
WHERE profit < 0;

-- 8. Review the largest losses
SELECT
    order_id,
    product_name,
    category,
    sub_category,
    sales,
    discount,
    profit
FROM superstore
WHERE profit < 0
ORDER BY profit ASC
LIMIT 10;

-- 9. Confirm the date range of the dataset
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    MIN(ship_date) AS earliest_ship_date,
    MAX(ship_date) AS latest_ship_date
FROM superstore;

-- 10. Check for invalid shipping dates
SELECT *
FROM superstore
WHERE ship_date < order_date;

-- 11. Review shipping-time range
SELECT
    MIN(ship_date - order_date) AS minimum_shipping_days,
    MAX(ship_date - order_date) AS maximum_shipping_days,
    ROUND(AVG(ship_date - order_date), 2) AS average_shipping_days
FROM superstore;

-- 12. Check category values for consistency
SELECT DISTINCT category
FROM superstore
ORDER BY category;

-- 13. Check region values for consistency
SELECT DISTINCT region
FROM superstore
ORDER BY region;

-- 14. Check customer segment values for consistency
SELECT DISTINCT segment
FROM superstore
ORDER BY segment;

-- 15. Check ship mode values for consistency
SELECT DISTINCT ship_mode
FROM superstore
ORDER BY ship_mode;

-- 16. Check discount distribution
SELECT
    discount,
    COUNT(*) AS row_count
FROM superstore
GROUP BY discount
ORDER BY discount;

-- 17. Summary statistics for major numeric fields
SELECT
    ROUND(MIN(sales), 2) AS min_sales,
    ROUND(MAX(sales), 2) AS max_sales,
    ROUND(AVG(sales), 2) AS avg_sales,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    ROUND(AVG(quantity), 2) AS avg_quantity,
    ROUND(MIN(profit), 2) AS min_profit,
    ROUND(MAX(profit), 2) AS max_profit,
    ROUND(AVG(profit), 2) AS avg_profit
FROM superstore;
