-- 8. *****More JOIN*****

-- 1. List the films where the yr is 1962. Show id and title.
SELECT id, title
FROM movie
WHERE yr = '1962';

-- 2. When was Citizen Kane released?
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr 
-- (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. What's the id for actor Glenn Close?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. What's the id of the film Casablanca?
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for Casablanca.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE movieid = (SELECT id 
                 FROM movie 
                 WHERE title = 'Casablanca');

-- 7. Obtain the cast list for the film Alien.
SELECT name
FROM movie, actor, casting
WHERE title = 'Alien'
AND actor.id = casting.actorid
AND casting.movieid = movie.id;

-- 8. List the films in which Harrison Ford has appeared.
SELECT title
FROM movie, actor, casting
WHERE name = 'Harrison Ford'
AND actor.id = casting.actorid
AND casting.movieid = movie.id;

-- 9. List the films in which Harrison Ford has appeared but not in the starring role. 
-- (The ord field indicates the position of the actor. If ord = 1 then the actor is in the starring role.)
SELECT title
FROM movie, actor, casting
WHERE name = 'Harrison Ford'
AND actor.id = casting.actorid
AND casting.movieid = movie.id
AND ord <> '1';

-- 10. List the films together with the leading star for all 1962 films.
SELECT title, name
FROM movie, actor, casting
WHERE yr = '1962'
AND actor.id = casting.actorid
AND casting.movieid = movie.id
AND ord = 1;

-- 11. Which were the busiest years for Rock Hudson? 
-- Show the year and the number of movies he made each year for any year in which he made more than two movies.
SELECT yr, COUNT(title)
FROM movie
JOIN actor ON movie.id = actor.id
JOIN casting ON movie.id = casting.movieid
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12. List the film title and the leading actor for all of the films Julie Andrews played in.
SELECT title, name
FROM movie, actor, casting
WHERE movie.id IN (SELECT movie.id
                FROM movie, actor, casting 
                WHERE name = 'Julie Andrews'
                AND actor.id = casting.actorid
                AND casting.movieid = movie.id)
AND actor.id = casting.actorid
AND casting.movieid = movie.id
AND ord = 1;

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(name) >= 15;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid)
FROM movie, casting
WHERE yr = '1978'
AND casting.movieid = movie.id
GROUP BY title
ORDER BY 2 DESC, 1;

-- 15. List all the people who have worked with Art Garfunkel.
SELECT DISTINCT name
FROM actor, casting
WHERE actor.id = casting.actorid
AND name <> 'Art Garfunkel'
AND movieid IN (SELECT movieid
                FROM actor, casting
                WHERE name = 'Art Garfunkel'
                AND actor.id = casting.actorid);