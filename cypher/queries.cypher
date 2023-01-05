// 1. Find the movies that don't have any actor
MATCH (m:Movie) WHERE NOT EXISTS((m)--(:RATED)--(:User)) 
RETURN m;


// 2. Get the number of movie that Jim Carrey played in
MATCH (:Actor{name:"Tom Hanks"})-[:ACTED_IN]->(m:Movie)
WITH COUNT(DISTINCT m) AS jim_carrey_movies
RETURN jim_carrey_movies;


// 3. Get the number of movies by genre that Jim Carrey played in
MATCH (g:Genre) OPTIONAL MATCH (g)<-[:genre]-(m:Movie)-[:ACTED_IN]->(:Actor{name:"Jim Carrey"}) 
RETURN g, COUNT(DISTINCT m) AS nb_films 
ORDER BY nb_films DESC

// 4. Show the actors that played in at least 50 movies
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)
WITH a, COUNT(*) AS nb_movies
WHERE nb_movies > 50
RETURN a.name

// Trouver l'écart maximal entre deux acteurs. deux personnes.
 