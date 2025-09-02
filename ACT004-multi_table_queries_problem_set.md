### Problem Set: Multi-Table Queries with Aggregation

**1. Total amount for each order**

*   **Problem:** Find the total amount for each order. Display the order number and the calculated total amount.
*   **Answer:**
    ```sql
    SELECT
        order_number,
        SUM(number_ordered * quoted_price) AS total_amount
    FROM order_line
    GROUP BY
        order_number;
    ```

**2. Number of orders for each customer**

*   **Problem:** List each customer's last and first name and the number of orders they have placed.
*   **Answer:**
    ```sql
    SELECT
        c.first,
        c.last,
        COUNT(o.order_number) AS number_of_orders
    FROM
        customer c,
        orders o
    WHERE
        c.customer_number = o.customer_number
    GROUP BY
        c.customer_number;
    ```

**3. Total amount ordered by each customer**

*   **Problem:** Find the total amount ordered by each customer. Display the customer's full name and the total amount.
*   **Answer:**
    ```sql
    SELECT
        c.first,
        c.last,
        SUM(ol.number_ordered * ol.quoted_price) AS total_ordered_amount
    FROM
        customer c,
        orders o,
        order_line ol
    WHERE
        c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
    GROUP BY
        c.customer_number;
    ```

**4. Average order amount for each sales rep**

*   **Problem:** Calculate the average order amount for each sales representative. Display the sales rep's full name and their average order amount.
*   **Answer:**
    ```sql
    SELECT
        sr.first,
        sr.last,
        AVG(ol.number_ordered * ol.quoted_price) AS average_order_amount
    FROM
        sales_rep sr,
        customer c,
        orders o,
        order_line ol
    WHERE
        sr.slsrep_number = c.slsrep_number
        AND c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
    GROUP BY
        sr.slsrep_number;
    ```

**5. Customers with more than one order**

*   **Problem:** List the customers who have placed more than one order.
*   **Answer:**
    ```sql
    SELECT
        c.first,
        c.last
    FROM
        customer c,
        orders o
    WHERE
        c.customer_number = o.customer_number
    GROUP BY
        c.customer_number
    HAVING
        COUNT(o.order_number) > 1;
    ```

**6. Total commission for each sales rep**

*   **Problem:** Calculate the total commission earned by each sales rep from their customers' orders.
*   **Answer:**
    ```sql
    SELECT
        sr.first,
        sr.last,
        SUM(ol.number_ordered * ol.quoted_price * sr.commission_rate) AS total_commission
    FROM
        sales_rep sr,
        customer c,
        orders o,
        order_line ol
    WHERE
        sr.slsrep_number = c.slsrep_number
        AND c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
    GROUP BY
        sr.slsrep_number;
    ```

**7. Parts ordered more than 10 times**

*   **Problem:** Find the parts that have been ordered more than 10 times in total across all orders.
*   **Answer:**
    ```sql
    SELECT
        p.part_description,
        SUM(ol.number_ordered) AS total_ordered
    FROM
        part p,
        order_line ol
    WHERE
        p.part_number = ol.part_number
    GROUP BY
        p.part_number
    HAVING
        SUM(ol.number_ordered) > 10;
    ```

**8. Sales rep with the highest single order amount**

*   **Problem:** Identify the sales rep who handled the order with the highest total amount.
*   **Answer:**
    ```sql
    SELECT
        sr.first,
        sr.last,
        MAX(ol.number_ordered * ol.quoted_price) AS highest_order_amount
    FROM
        sales_rep sr,
        customer c,
        orders o,
        order_line ol
    WHERE
        sr.slsrep_number = c.slsrep_number
        AND c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
    GROUP BY
        sr.slsrep_number
    ORDER BY
        highest_order_amount DESC
    LIMIT 1;
    ```

**9. Customers with a total order amount greater than their credit limit**

*   **Problem:** List customers whose total order amount exceeds their credit limit.
*   **Answer:**
    ```sql
    SELECT
        c.first,
        c.last,
        SUM(ol.number_ordered * ol.quoted_price) as total_orders,
        c.credit_limit
    FROM
        customer c,
        orders o,
        order_line ol
    WHERE
        c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
    GROUP BY
        c.customer_number
    HAVING
        SUM(ol.number_ordered * ol.quoted_price) > c.credit_limit;
    ```

**10. Average price of parts in each item class**

*   **Problem:** Calculate the average unit price for each item class.
*   **Answer:**
    ```sql
    SELECT
        item_class,
        AVG(unit_price) AS average_price
    FROM part
    GROUP BY
        item_class;
    ```

**11. Number of parts in each order**

*   **Problem:** For each order, count the number of unique parts included.
*   **Answer:**
    ```sql
    SELECT
        order_number,
        COUNT(part_number) AS parts_count
    FROM order_line
    GROUP BY
        order_number;
    ```

**12. Total number of items ordered per city**

*   **Problem:** Find the total number of items (sum of `number_ordered`) for each city where customers reside.
*   **Answer:**
    ```sql
    SELECT
        c.city,
        SUM(ol.number_ordered) AS total_items_ordered
    FROM
        customer c,
        orders o,
        order_line ol
    WHERE
        c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
    GROUP BY
        c.city;
    ```

**13. Orders with a total amount between $100 and $500**

*   **Problem:** List the order numbers and their total amounts for orders with a total amount between $100 and $500.
*   **Answer:**
    ```sql
    SELECT
        order_number,
        SUM(number_ordered * quoted_price) AS total_amount
    FROM order_line
    GROUP BY
        order_number
    HAVING
        total_amount BETWEEN 100 AND 500;
    ```

**14. Sales reps and the number of customers they manage**

*   **Problem:** For each sales rep, show their full name and the number of customers they manage.
*   **Answer:**
    ```sql
    SELECT
        sr.first,
        sr.last,
        COUNT(c.customer_number) AS number_of_customers
    FROM
        sales_rep sr,
        customer c
    WHERE
        sr.slsrep_number = c.slsrep_number
    GROUP BY
        sr.slsrep_number;
    ```

**15. Most expensive part ordered by each customer**

*   **Problem:** Find the most expensive part ordered by each customer. Display the customer's name and the part's description and price.
*   **Answer:**
    ```sql
    SELECT
        c.first,
        c.last,
        p.part_description,
        MAX(ol.quoted_price) AS max_price
    FROM
        customer c,
        orders o,
        order_line ol,
        part p
    WHERE
        c.customer_number = o.customer_number
        AND o.order_number = ol.order_number
        AND ol.part_number = p.part_number
    GROUP BY
        c.customer_number;
    ```