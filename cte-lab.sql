use sakila;

-- First, create a view that summarizes rental information for each customer. 
-- The view should include the customer's ID, name, email address, and total number of rentals (rental_count).

create or replace view customer_rental_info as
select
r.customer_id,
count(r.rental_id) as Number_of_Rentals_Per_Customer,
c.first_name,
c.last_name,
c.email
from customer as c
join rental as r on c.customer_id = r.customer_id
group by c.customer_id, 
c.first_name,
c.last_name,
c.email;

-- Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
-- The Temporary Table should use the rental summary view created in Step 1 to join with the payment table and 
-- calculate the total amount paid by each customer.
DROP TEMPORARY TABLE IF EXISTS temp_total_spent_per_customer;
create temporary table temp_total_spent_per_customer as
select
v.customer_id,
SUM(p.amount) as total_spent_per_customer
from customer_rental_info as v -- Using the view
join payment as p
on v.customer_id = p.customer_id
group by v.customer_id;



-- Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. 
-- The CTE should include the customer's name, email address, rental count, and total amount paid.

with customer_reference_table as
(select
cri.customer_id,
cri.first_name,
cri.last_name,
cri.Number_of_Rentals_Per_Customer,
tspc.total_spent_per_customer
from 
customer_rental_info as cri
join
temp_total_spent_per_customer as tspc
on
cri.customer_id = tspc.customer_id)
select * from customer_reference_tables


