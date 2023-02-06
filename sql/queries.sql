/* Get the number of movies that Jim Carrey played in */ 

SELECT COUNT(*) as nb_movies from Movies m
JOIN casting c ON m.tmdb_id = c.movie_tmdb_id
WHERE c.actorid in 
(SELECT id FROM Actors 
WHERE name = 'Tom Hanks' );

/* Find how many directors directed Denzel Washington */

EXPLAIN SELECT COUNT(*) as nb_directors 
FROM Directors d JOIN Directed ded 
ON d.id = ded.director_id
JOIN casting c 
on c.movie_tmdb_id = ded.movie_tmdb_id
WHERE c.actorid in
(SELECT id FROM Actors
WHERE name = 'Denzel Washington');

