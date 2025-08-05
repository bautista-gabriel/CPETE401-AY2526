# Premiere Products Database Schema

## Core Idea
Premiere Products is a fictional distributor. The database tracks sales reps, the customers they manage, the orders those customers place, and the parts that make up those orders.

## Tables and their Columns

### sales_rep
Stores information about the sales representatives.

- **slsrep_number** (Primary Key): Unique ID for each rep.
- **last**: Last name of the sales representative.
- **first**: First name of the sales representative.
- **street**: The street address of the sales representative.
- **city**: The city where the sales representative resides.
- **state**: The state where the sales representative resides.
- **zip_code**: The zip code of the sales representative.
- **total_commission**: The total commission earned.
- **commission_rate**: The commission rate.

### customer
Information about the customers.

- **customer_number** (Primary Key): Unique ID for each customer.
- **last**: The customer's last name.
- **first**: The customer's first name.
- **street**: The customer's street address.
- **city**: The city where the customer is located.
- **state**: The state where the customer is located.
- **zip_code**: The customer's zip code.
- **balance**: The customer's current balance.
- **credit_limit**: The customer's credit limit.
- **slsrep_number** (Foreign Key): Links to the `sales_rep` table, showing which rep is assigned to this customer.

### orders
Contains information about each order.

- **order_number** (Primary Key): Unique ID for each order.
- **order_date**: When the order was placed.
- **customer_number** (Foreign Key): Links to the `customer` table, indicating who placed the order.

### part
Details about the products.

- **part_number** (Primary Key): Unique ID for each part.
- **part_description**: Description of the part.
- **units_on_hand**: How many units are in stock.
- **item_class**: Category of the part (e.g., 'AP' for Appliances).
- **warehouse_number**: The warehouse where the part is stored.
- **unit_price**: The price of the part.

### order_line
This is a "junction" or "linking" table. It connects `orders` and `part`.

- **order_number** (Composite Primary Key, Foreign Key): Part of the primary key and links to the `orders` table.
- **part_number** (Composite Primary Key, Foreign Key): Part of the primary key and links to the `part` table.
- **number_ordered**: How many units of a specific part were included in the order.
- **quoted_price**: The price of the part when the order was made.

## Relationships between the tables

- **One-to-Many:**
    - One `sales_rep` can have many `customer`s.
    - One `customer` can have many `orders`.
- **Many-to-Many:**
    - One `order` can have many `part`s, and one `part` can be in many `orders`. The `order_line` table manages this relationship.
