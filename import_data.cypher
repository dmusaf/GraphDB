CREATE CONSTRAINT ON (m:Movie) ASSERT m.id IS UNIQUE;
CREATE INDEX movie_id for (m:Movie) on (m.id)

LOAD CSV WITH HEADERS FROM "file:/movies.csv" AS row 
CREATE (movie:Movie{
            id:toInteger(row.movie_id), 
            title:row.original_title, 
            releaseDate:date(row.release_date), 
            popularity:row.popularity
        });
    
:auto LOAD CSV WITH HEADERS FROM "file:/genres.csv" AS row 
CALL {
    WITH row
    MERGE (m:Movie{id:toInteger(row.movie_id)})
    MERGE (g:Genre{name:row.genre})
    CREATE (m)-[:GENRE]->(g)
} IN TRANSACTIONS


