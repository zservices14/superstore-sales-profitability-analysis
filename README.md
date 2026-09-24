# Superstore Sales & Profitability Analysis
This project analyzes 9,994 retail transaction records from the Superstore dataset using PostgreSQL, Excel, and Tableau.

The goal was to evaluate sales performance, profitability, discounting, product performance, and regional trends, then present the findings through interactive dashboards.

## SQL was used as the main analysis layer to:
- Create and structure the Superstore table
- Validate row counts, null values, duplicates, dates, and numeric fields
- Calculate sales, profit, profit margin, orders, customers, and average order value
- Analyze performance by year, region, category, sub-category, product, customer, and discount level
- Use CTEs and window functions for year-over-year growth, regional ranking, and monthly trends

## Excel was used for:
- Importing SQL outputs
- PivotTables
- KPI validation
- Conditional formatting
- Summary charts and reporting

## Tableau Product & Profitability Analysis
This dashboard focuses on:
- Profitability by sub-category
- Product sales vs. profitability
- Profit by region
- Average profit by discount level
- Interactive category filtering

## Tableau 2017 Executive Profitability
This dashboard focuses on:
- 2017 sales, profit, and quantity KPIs
- 2016 vs. 2017 trend comparisons
- Year-over-year percentage changes
- State-level profit ratio
- Interactive filters for date, category, region, and profit ratio

- ## Key Findings
- Several sub-categories generated negative profit despite meaningful sales volume.
- Higher discount levels were generally associated with substantially lower average profit.
- Regional profitability varied significantly, with some regions contributing much more profit than others.
- Certain products generated strong sales but weak or negative profitability, showing that revenue alone does not indicate strong performance.
- Geographic profit ratios varied considerably across states.
