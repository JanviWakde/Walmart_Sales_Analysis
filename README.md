# Walmart Sales Analysis Using SQL

This project analyzes Walmart sales data using SQL to uncover insights into product performance, customer behavior, revenue trends, and operational efficiency across different branches.


## Dataset
The dataset used was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

It contains sales transactions with attributes such as:
- Invoice ID
- Branch
- City
- Customer 
- Gender
- Product Line
- Price
- Quantity
- VAT (Tax)
- Total Sales
- Date
- Time
- Payment Method
- Gross Margin Percentage
- Gross Income
- Rating


## Objectives
- Identify top-performing branches and products
- Understand customer behavior and preferences
- Analyze sales patterns by time, day, and month
- Recommend strategies to optimize sales and operations


## Key Insights
### Branch & Location
- Branch C sold the most products with a total quantity exceeding the average product quantity sold per branch.
- Each branch is located in a different city:
  - Branch A → Yangon
  - Branch B → Mandalay
  - Branch C → Naypyitaw
- Yangon (Branch A) generated the highest total revenue among all cities.

### Product Analysis
- The dataset contains 6 unique product lines.
- "Food and beverages" is the most sold product line in terms of quantity.
- "Food and beverages" also generated the highest total revenue.
- "Health and beauty" products have the highest average customer rating.
- "Home and lifestyle" products incur the highest average VAT (tax).

### Payment & Customer Trends
- Ewallet is the most used payment method, followed by Cash and Credit card.
- There are 2 customer types: Member and Normal.
- Members generated more revenue and purchased more items than Normal customers.
- Gender distribution across branches is relatively balanced but varies slightly per branch.

### Time & Day Trends
- Sunday is the busiest day, especially during the Evening.
- Branch A sees the most ratings in the Evening, while Branch B sees more in the Morning.

### Monthly Trends
- January generated the highest total revenue.
- January also had the highest COGS (Cost of Goods Sold), indicating a peak in sales volume.

### Ratings
- Friday has the highest average customer rating overall.
- Branch C has the best ratings on Friday, while Branch A peaks on Monday.


## Conclusion
This project demonstrates how structured SQL queries can be used to generate valuable business insights from raw sales data. With only SQL, 
we were able to:
- Discover revenue-driving products and customer types
- Understand temporal sales patterns
- Support data-driven decision-making for branch operations and inventory planning






