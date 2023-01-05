// 1. Find the movies that don't have any actor
MATCH (m:Movie) 
WHERE NOT EXISTS((m)--(:RATED)--(:User)) 
RETURN m;


// 2. Get the number of movie that Jim Carrey played in
MATCH (:Actor{name:"Tom Hanks"})-[:ACTED_IN]->(m:Movie)
WITH COUNT(DISTINCT m) AS jim_carrey_movies
RETURN jim_carrey_movies;


// 3. Get the number of movies by genre that Jim Carrey played in
MATCH (g:Genre) OPTIONAL MATCH (g)<-[:GENRE]-(m:Movie)<-[:ACTED_IN]-(:Actor{name:"Jim Carrey"}) 
RETURN g.name, COUNT(DISTINCT m) AS nb_films 
ORDER BY nb_films DESC

// 4. Show the actors that played in at least 50 movies
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)
WITH a, COUNT(*) AS nb_movies
WHERE nb_movies > 50
RETURN a.name, nb_movies 
ORDER BY nb_movies DESC

// 5. Find the number of directors that directed Denzel Washington
MATCH (:Actor{name:"Denzel Washington"})-[path*2]-(d:Director)
return count(distinct d) as nb_directors

// Trouver l'écart maximal entre deux acteurs. deux personnes.
 