// 1. (Negative filter) Find the movies that don't have any actor
MATCH (m:Movie) 
WHERE NOT EXISTS((m)--(:RATED)--(:User)) 
RETURN m;


// 2. (With agrégation) Get the number of movie that Jim Carrey played in
MATCH (:Actor{name:"Tom Hanks"})-[:ACTED_IN]->(m:Movie)
WITH COUNT(DISTINCT m) AS jim_carrey_movies
RETURN jim_carrey_movies;


// 3. Get the number of movies by genre that Jim Carrey played in
MATCH (g:Genre) OPTIONAL MATCH (g)<-[:GENRE]-(m:Movie)<-[:ACTED_IN]-(:Actor{name:"Jim Carrey"}) 
RETURN g.name, COUNT(DISTINCT m) AS nb_films 
ORDER BY nb_films DESC

// 4. (Filtering after with) Show the actors that played in at least 50 movies
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)
WITH a, COUNT(*) AS nb_movies
WHERE nb_movies > 50
RETURN a.name, nb_movies 
ORDER BY nb_movies DESC

// 5. (données + topologie de graphe) Find the number of directors that directed Denzel Washington
MATCH (:Actor{name:"Denzel Washington"})-[path*2]-(d:Director)
return count(distinct d) as nb_directors

// 6. (Fonctions prédicats) Find the directors that directed a movie that got a 5-star rating
MATCH (director:Director)-[:DIRECTED]->(movie:Movie)
WHERE EXISTS( (movie)<-[:RATED{grade:5}]-(:User) )
RETURN director.name as director


// 7. (Reduce) Find the total duration for actors
MATCH (movie:Movie)<-[:ACTED_IN]-(actor:Actor)
WITH actor, COLLECT(movie) AS movies
RETURN actor.name, REDUCE(total_duration = 0, movie IN movies | total_duration + movie.duration) AS total_duration

// 8. (POST-UNION FILTER) Find the movies that have an average grade above 8 and are French or American, and that last at least 120 minutes.

EXPLAIN CALL {
   MATCH (movie:Movie) WHERE movie.vote_average > 8 AND movie.principal_country = "US" RETURN movie as film
   UNION
   MATCH (movie:Movie) WHERE movie.vote_average > 8 AND movie.principal_country = "FR" RETURN movie as film
}
WITH film
WHERE film.duration > 120
RETURN film.title as title, film.budget as budget, film.principal_country as country, film.duration as duration  order by budget desc

// 9. (COLLECT and UNWIND)
