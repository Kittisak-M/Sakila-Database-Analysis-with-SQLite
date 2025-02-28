/* START */
-- Explore movies in the database
SELECT *
FROM film as f
/* END */

/* START */
-- Count number of movies in each category
SELECT rating,
	   COUNT(*) as movies_count,
       ROUND(AVG(rental_duration),2) as avg_rental_duration,
       ROUND(AVG(length),2) as avg_length
FRom film
GROUP BY rating
Order by COUNT(rating) DESC
/* END */

/* START */
-- Explore the film table
SELECT f.title,
	   f.description,
       f.release_year,
       c.name,
       f.rental_duration,
       f.rental_rate,
       f.length,
       f.replacement_cost,
       f.rating
FROM film as f
LEFT JOIN language as l
ON f.language_id = f.language_id
LEFT JOIN film_category as fc
on fc.film_id = f.film_id
left join category as c
on fc.category_id = c.category_id
/* END */

/* START */
--Count movies categorized by length
WITH m_length AS (
SELECT 
		title,
        CASE 
        	WHEN length < 60  Then 'Short'
            WHEN length < 90  Then 'Medium'
            Else 'Long' End movie_length
FROM film)

SELECT m_length.movie_length,
	   COUNT(*) as movies_count
FROM m_length
GROUP BY movie_length
/* END */

/* START */
-- COUNT number of movies in each category with revenue
SELECT f.title,
	   p.amount,
 	   p.payment_date,
       c.name
FROM payment as p
LEFT JOIN rental as r
on r.rental_id = p.rental_id
LEFT JOIN inventory as i
on i.inventory_id = r.inventory_id
LEFT JOIN film as f
on f.film_id = i.film_id
LEFT JOIn film_category as fc
on f.film_id = fc.film_id
LEFT JOIN category as c
on c.category_id = fc.category_id
WHERe p.customer_id IN (SELECT customer_id
                FROM payment
                WHERE p.customer_id = 1)
/* END */

/* START */
-- Actor fullname
SELECT first_name || '' ||last_name as actor_full_name
FROM actor
/* END */

/* START */
-- Count number of actors in the database
WITH at_fn AS(
  		SELECT first_name || ' ' ||last_name as actor_full_name
		FROM actor
             )
SELECT COUNT(DISTINCT actor_full_name) as actor_cnt
FROM at_fn
/* END */

/* START */
-- Actor appearance in the films actor
SELECT f.title,
	   f.length,
       f.rating,
       a.first_name || ' ' || a.last_name as actor_full_name
FROM film as f
LEFT JOIN film_actor as fa
On f.film_id = fa.film_id
LEFT JOIN actor as a 
on a.actor_id = fa.actor_id
/* END */

/* START */
-- Number of times that actors appear in the movies
With ac_ap AS (
  		SELECT f.title,
	   		   f.length,
     		   f.rating,
     	       a.first_name || ' ' || a.last_name as actor_full_name
	FROM film as f
	LEFT JOIN film_actor as fa
	On f.film_id = fa.film_id
	LEFT JOIN actor as a 
	on a.actor_id = fa.actor_id
               )
SELECT actor_full_name, COUNT(*)
FROM ac_ap
GROUP BY actor_full_name
/* END */