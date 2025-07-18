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

select
customer_id,
SUM(amount) as total_spent_per_customer
from payment
group by customer_id



