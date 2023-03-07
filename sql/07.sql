/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall_films AS (
    SELECT title, film_id
    FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    WHERE first_name = 'RUSSELL' AND
          last_name = 'BACALL'
),

bacall_num1_actors AS (
    SELECT DISTINCT film_id, title, actor_id, first_name, last_name
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE film_id IN (SELECT film_id FROM bacall_films)
      AND (first_name || ' ' || last_name) != 'RUSSELL BACALL'
),

bacall_num2_films AS (
    SELECT title, film_id
    FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    WHERE actor_id IN (SELECT actor_id FROM bacall_num1_actors)
)

SELECT DISTINCT (first_name || ' ' || last_name) AS "Actor Name"
FROM actor
JOIN film_actor USING (actor_id)
JOIN bacall_num2_films USING (film_id)
WHERE (first_name || ' ' || last_name) != 'RUSSELL BACALL' AND
      actor_id NOT IN (SELECT actor_id FROM bacall_num1_actors)
ORDER BY "Actor Name";



