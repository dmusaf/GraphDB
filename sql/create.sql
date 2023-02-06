DROP TABLE IF EXISTS Casting;
DROP TABLE IF EXISTS Directed;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Movies;


CREATE TABLE Movies(
    id int NOT NULL,
    tmdb_id int NOT NULL UNIQUE, 
    original_title text,
    release_date date,
    duration int,
    popularity int,
    primary key(id)
);

CREATE TABLE Actors(
    id int NOT NULL,
    name text,
    original_name text,
    gender int,
    popularity float,
    primary key (id)
);



CREATE TABLE Casting(
    movie_tmdb_id int NOT NULL,
    actorId int NOT NULL,
    CONSTRAINT fk_movieId
        FOREIGN KEY(movie_tmdb_id)
            REFERENCES Movies(tmdb_id),
    CONSTRAINT fk_actorId
        FOREIGN KEY(actorId)
            REFERENCES Actors(id)
);




CREATE TABLE Directors(
    id int NOT NULL,
    name text,
    original_name text,
    gender int,
    popularity float,
    primary key (id)
);

CREATE TABLE Directed(
    movie_tmdb_id int NOT NULL,
    director_id int NOT NULL,
    CONSTRAINT fk_movieId
        FOREIGN KEY(movie_tmdb_id)
            REFERENCES Movies(tmdb_id),
    CONSTRAINT fk_directorId
        FOREIGN KEY(director_id)
            REFERENCES Directors(id)
);



CREATE TABLE Users(
    id int primary key
);

CREATE TABLE Ratings(
    user_id int NOT NULL,
    movie_id int NOT NULL,
    grade float NOT NULL,   
    CONSTRAINT fk_userId
        FOREIGN KEY(user_id)
            REFERENCES Users(id),
    CONSTRAINT fk_movieId
        FOREIGN KEY(movie_id)
            REFERENCES Movies(id)
);
