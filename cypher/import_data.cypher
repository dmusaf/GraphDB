CREATE CONSTRAINT FOR (m:Movie) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT FOR (m:Movie) REQUIRE m.tmdbId IS UNIQUE;
CREATE CONSTRAINT FOR (a:Actor) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT FOR (d:Director) REQUIRE d.id IS UNIQUE;

CREATE INDEX rating_movie for (r:Rating) on (r.movieId);

LOAD CSV WITH HEADERS FROM "file:/movies.csv" AS row 
CREATE (movie:Movie{
            id:toInteger(row.movie_id), 
            title:row.original_title, 
            releaseDate:date(row.release_date), 
            popularity:row.popularity,
            tmdbId:toInteger(row.tmdb_id)
        });
    
:auto LOAD CSV WITH HEADERS FROM "file:/genres.csv" AS row 
CALL {
    WITH row
    MERGE (m:Movie{id:toInteger(row.movie_id)})
    MERGE (g:Genre{name:row.genre})
    CREATE (m)-[:GENRE]->(g)
} IN TRANSACTIONS



:auto LOAD CSV WITH HEADERS FROM "file:/actors.csv" AS row   
CALL {
    WITH row
    CREATE (a:Actor{
        id:toInteger(row.actor_id),
        name:row.name,
        originalName:row.original_name,
        gender:toInteger(row.gender),
        popularity:toFloat(row.popularity)})
} IN TRANSACTIONS OF 1000 ROWS

:auto LOAD CSV WITH HEADERS FROM "file:/directors.csv" AS row   
CALL {
    WITH row
    CREATE (d:Director{
        id:toInteger(row.director_id),
        name:row.name,
        originalName:row.original_name,
        gender:toInteger(row.gender),
        popularity:toFloat(row.popularity)})
} IN TRANSACTIONS OF 1000 ROWS


:auto LOAD CSV WITH HEADERS FROM "file:/links_cast.csv" AS row
CALL {
    WITH row
    MERGE (m:Movie{tmdbId:toInteger(row.tmdb_movie_id)})
    MERGE (a:Actor{id:toInteger(row.actor_id)})
    CREATE (a)-[:ACTED_IN]->(m)
} IN TRANSACTIONS OF 1000 ROWS

:auto LOAD CSV WITH HEADERS FROM "file:/links_crew.csv" AS row
CALL {
    WITH row
    MERGE (m:Movie{tmdbId:toInteger(row.tmdb_movie_id)})
    MERGE (d:Director{id:toInteger(row.director_id)})
    CREATE (d)-[:DIRECTED]->(m)
} IN TRANSACTIONS OF 1000 ROWS

:auto LOAD CSV WITH HEADERS FROM "file:/ratings.csv" AS row
CALL {
    WITH row
    MERGE (u:User{id:toInteger(row.user_id)})
    MERGE (m:Movie{id:toInteger(row.movie_id)})
    CREATE (u)-[:RATED]->(r:Rating{score:toFloat(row.rating)})-[:FOR]->(m)
} IN TRANSACTIONS OF 1000 ROWS
