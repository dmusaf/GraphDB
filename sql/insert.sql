\COPY Actors(id,name,original_name,gender,popularity) FROM '../data/actors.csv' DELIMITER ',' CSV HEADER;
\COPY Directors(id,name,original_name,gender,popularity) FROM '../data/directors.csv' DELIMITER ',' CSV HEADER;

create temporary table t (
    tmdb_id int, 
    movie_id int, 
    popularity float, 
    original_title text, 
    genres text, 
    release_date date, 
    studios text, 
    duration int
);

\copy t (tmdb_id, movie_id, popularity, original_title, genres, release_date, studios, duration) from '../data/correct_format_movies.csv' DELIMITER ',' CSV HEADER;
insert into Movies(id, tmdb_id, original_title, release_date, duration, popularity)
select movie_id, tmdb_id, original_title, release_date, duration, popularity
from t;

drop table t;

\COPY Directed(movie_tmdb_id, director_id) from '../data/links_crew.csv' DELIMITER ',' CSV HEADER;
\COPY Casting(movie_tmdb_id, actorId) from '../data/links_cast.csv' DELIMITER ',' CSV HEADER;
