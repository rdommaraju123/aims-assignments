-------------- Get all customers whose first name starts with 'J' and who are active.--------
select first_name
from sakila.customer
where first_name like 'j%' and active =1;

#Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.

select title, description
from sakila.film
where title like '%action%' or description like '%war%';

#List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.

select first_name , last_name
from sakila.customer 
where last_name  not like 'smith' and first_name like '%a%';

##4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.

select *
from sakila.film
where rental_rate > 3.0 and replacement_cost is not null; 

#Count how many customers exist in each store who have active status = 1.

select store_id , count(*) as total_customers
from sakila.customer
where active =1
group by store_id;

#6. Show distinct film ratings available in the film table.
select distinct (rating)
from sakila.film;

##7. Find the number of films for each rental duration where the average length is more than 100 minutes.

select count(*)
from sakila.film 
group by rental_duration
having avg(length) >100;

#8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.


select payment_date , sum(amount) as total_amount
from sakila.payment
group by payment_date
having total_amount > 100;

#9. Find customers whose email address is null or ends with '.org'.

select *
from sakila.customer
where email is null or email like'%.org';


#10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select *
from sakila.film 
where rating = 'pg' or rating = 'p'
order by rental_rate desc;

#11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.

select length , count(*) 
from sakila.film 
where title like'T%'
group by length
having count(*) >5;


#12. List all actors who have appeared in more than 10 films.

select a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_films
from sakila.actor a
join sakila.film_actor fa
on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
having COUNT(fa.film_id) > 10;

#13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.

SELECT title, rental_rate, length
FROM sakila.film
ORDER BY rental_rate DESC, length DESC
LIMIT 5;

#14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
SELECT c.customer_id, c.first_name , c.last_name , count(r.rental_id) as total_amount
FROM sakila.customer as c
JOIN sakila.rental as r
ON c.customer_id= r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC;

#5. List the film titles that have never been rented.
SELECT f.title
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i
    ON f.film_id = i.film_id
LEFT JOIN sakila.rental AS r
    ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;