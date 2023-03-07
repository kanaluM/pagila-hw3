/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

WITH circus_actors AS (
    SELECT film_id, actor_id, first_name, last_name
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)

SELECT DISTINCT title
FROM film
JOIN film_actor F1 USING (film_id)
JOIN film_actor F2 USING (film_id)
WHERE F1.actor_id != F2.actor_id
  AND F1.actor_id IN (SELECT actor_id FROM circus_actors)
  AND F2.actor_id IN (SELECT actor_id FROM circus_actors)
ORDER BY title ASC;

