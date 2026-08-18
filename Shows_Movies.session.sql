CREATE TABLE shows_movies (
    id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(1000),
    release_year INT,
    age_certification VARCHAR(255),
    runtime INT,
    genre VARCHAR(255),
    production_countries VARCHAR(255),
    seasons FLOAT,
    imdb_id VARCHAR(255),
    imdb_score FLOAT,
    imdb_votes FLOAT,
    tmdb_popularity FLOAT,
    tmdb_score FLOAT
);

COPY shows_movies
FROM "D:\titles.csv"
DELIMITER ','
CSV HEADER;

SELECT * FROM shows_movies LIMIT 10;

SELECT * FROM shows_movies;