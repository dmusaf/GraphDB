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


// 7. Find the total duration for actors
MATCH (movie:Movie)<-[:ACTED_IN]-(actor:Actor)
WITH actor, COLLECT(movie) AS movies
RETURN actor.name, REDUCE(total_duration = 0, movie IN movies | total_duration + movie.duration) AS total_duration

// 8. Trouver le nombre de films
MATCH (movie:Movie)<-[:ACTED_IN]-(actor:Actor)
WHERE actor.name IN ['Tom Hanks', 'Julia Roberts']
RETURN actor.name, movie.title, movie.year
UNION
MATCH (movie:Movie)<-[:DIRECTED]-(director:Director)
WHERE director.name IN ['Steven Spielberg', 'Ron Howard']
RETURN director.name, movie.title, movie.year
CALL {
  MATCH (actor:Actor)
  RETURN actor.name, count(*) AS movie_count
}
FILTER movie_count > 2
RETURN name, movie_count

// 9. 
MATCH (movie:Movie)<-[:ACTED_IN]-(actor:Actor)
WHERE actor.name IN ['Tom Hanks', 'Julia Roberts']
RETURN actor.name,
       ALL(x IN movies WHERE x.rating > 7) AS all_high_rated,
       ANY(x IN movies WHERE x.rating > 7) AS any_high_rated,
       EXISTS(x IN movies WHERE x.rating > 7) AS exists_high_rated,
       NONE(x IN movies WHERE x.rating > 7) AS none_high_rated,
       SINGLE(x IN movies WHERE x.rating > 7) AS single_high_rated