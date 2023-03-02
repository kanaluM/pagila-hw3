/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT actor_id 
    FROM (SELECT DISTINCT actor_id, name
          FROM film_actor
          JOIN film USING (film_id)
          JOIN film_category USING (film_id)
          JOIN category USING (category_id)
    ) AS t
    WHERE name = 'Horror'
)
AND actor_id IN (
    SELECT actor_id 
    FROM (SELECT DISTINCT actor_id, name
          FROM film_actor
          JOIN film USING (film_id)
          JOIN film_category USING (film_id)
          JOIN category USING (category_id)
    ) AS t 
    WHERE name = 'Children')
ORDER BY last_name ASC, first_name ASC;
