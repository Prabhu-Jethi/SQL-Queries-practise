SELECT * FROM shows_movies;


---- Data Cleaning ----

-- SELECT 
--   COUNT(*) - COUNT(id) AS id_nulls,
--   COUNT(*) - COUNT(title) AS title_nulls,
--   COUNT(*) - COUNT(type) AS type_nulls,
--   COUNT(*) - COUNT(description) AS description_nulls,
--   COUNT(*) - COUNT(release_year) AS release_year_nulls,
--   COUNT(*) - COUNT(age_certification) AS age_certification_nulls,
--   COUNT(*) - COUNT(runtime) AS runtime_nulls,
--   COUNT(*) - COUNT(genres) AS genres_nulls,
--   COUNT(*) - COUNT(production_countries) AS production_countries_nulls,
--   COUNT(*) - COUNT(seasons) AS seasons_nulls,
--   COUNT(*) - COUNT(imdb_id) AS imdb_id_nulls,
--   COUNT(*) - COUNT(imdb_score) AS imdb_score_nulls,
--   COUNT(*) - COUNT(imdb_votes) AS imdb_votes_nulls,
--   COUNT(*) - COUNT(tmdb_popularity) AS tmdb_popularity_nulls,
--   COUNT(*) - COUNT(tmdb_score) AS tmdb_score_nulls
-- FROM shows_movies;

-- UPDATE shows_movies SET seasons = 0 WHERE seasons IS NULL;
-- UPDATE shows_movies SET imdb_score = 0 WHERE imdb_score IS NULL;
-- UPDATE shows_movies SET imdb_votes = 0 WHERE imdb_votes IS NULL;
-- UPDATE shows_movies SET tmdb_popularity = 0 WHERE tmdb_popularity IS NULL;
-- UPDATE shows_movies SET tmdb_score = 0 WHERE tmdb_score IS NULL;
-- UPDATE shows_movies SET title = 'Unknown' WHERE title IS NULL;
-- UPDATE shows_movies SET description = 'Unknown' WHERE description IS NULL;
-- UPDATE shows_movies SET age_certification = 'Unknown' WHERE age_certification IS NULL;
-- UPDATE shows_movies SET imdb_id = 'Unknown' WHERE imdb_id IS NULL;

-- SELECT title, COUNT(*)
-- FROM shows_movies
-- GROUP BY title
-- HAVING COUNT(*) > 1;

-- DELETE FROM shows_movies
-- WHERE id NOT IN (
--     SELECT MIN(id)
--     FROM shows_movies
--     GROUP BY title
-- );


-------- Top 10 Movies 
-- SELECT title, type, imdb_score
-- FROM shows_movies
-- where imdb_score >= 8.0 AND type = 'MOVIE'
-- ORDER BY imdb_score DESC
-- LIMIT 10;

-- ---------Bottom 10 Movies
-- SELECT title, type, imdb_score
-- FROM shows_movies
-- where imdb_score > 0 AND type = 'MOVIE'
-- ORDER BY imdb_score ASC
-- LIMIT 10;

-- --------Top 10 Shows
-- SELECT title, type, imdb_score
-- FROM shows_movies
-- WHERE imdb_score >= 8.0 AND type = 'SHOW'
-- ORDER BY imdb_score DESC
-- LIMIT 10;

-- ---------Bottom 10 Shows
-- SELECT title, type, imdb_score
-- FROM shows_movies
-- WHERE imdb_score > 0 AND type = 'SHOW'
-- ORDER BY imdb_score ASC
-- LIMIT 10;


----------- How many shows and movies fall in each decade in netflix's library ?

-- SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS DECADE,
--     COUNT(*) AS movies_shows_count
-- FROM shows_movies
-- WHERE release_year >= 1940
-- GROUP BY DECADE
-- ORDER BY DECADE;


------------ How did age certifications impact dataset

-- SELECT DISTINCT age_certification,
--     ROUND(CAST(AVG(imdb_score) AS NUMERIC), 2) AS avg_imdb_score
-- FROM shows_movies
-- GROUP BY age_certification
-- ORDER BY avg_imdb_score DESC;


------------ Age certication count in shows and movies
-- SELECT age_certification,
--     COUNT(*) AS certification_count
-- FROM shows_movies
-- WHERE type = 'SHOW' AND age_certification != 'Unknown'
-- GROUP BY age_certification
-- ORDER BY certification_count DESC;

-- SELECT age_certification,
--     COUNT(*) AS certification_count
-- FROM shows_movies
-- WHERE type = 'MOVIE' AND age_certification != 'Unknown'
-- GROUP BY age_certification
-- ORDER BY certification_count DESC;



----------- Which genre are the most common ?

-- SELECT DISTINCT genres, COUNT(*) AS genre_counts
-- FROM shows_movies
-- WHERE type = 'SHOW'
-- GROUP BY genres
-- ORDER BY genre_counts DESC
-- LIMIT 10;

-- SELECT DISTINCT genres, COUNT(*) AS genre_counts
-- FROM shows_movies
-- WHERE type = 'MOVIE'
-- GROUP BY genres
-- ORDER BY genre_counts DESC
-- LIMIT 10;


-- ------Top 3 most common genres OVERALL
-- SELECT sm.genres, COUNT(*) AS genre_count
-- FROM shows_movies sm
-- WHERE type = 'MOVIE'
-- GROUP BY genres
-- ORDER BY genre_count DESC
-- LIMIT 3;


