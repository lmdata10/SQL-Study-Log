--- QUESTIONS ---

SELECT * FROM imdb_top_movies;

/*
1) Fetch all data from imdb table 
2) Fetch only the name and release year for all movies.
3) Fetch the name, release year and imdb rating of movies which are UA certified.
4) Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.
5) Find out how many movies are of Drama genre.
6) How many movies are directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".
7) What is the highest imdb rating given so far?
8) What is the highest and lowest imdb rating given so far?
8a) Solve the above problem but display the results in different rows.
8b) Solve the above problem but display the results in different rows. And have a column which indicates the value as lowest and highest.
9) Find out the total business done by movies staring "Aamir Khan".
10) Find out the average imdb rating of movies which are neither directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and are not acted by any of these stars "Christian Bale", "Liam Neeson", "Heath Ledger", "Leonardo DiCaprio", "Anne Hathaway".

11) Mention the movies involving both "Steven Spielberg" and "Tom Cruise".
12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.
13) What is the average imdb rating of movies which are released in the last 10 years and have less than 2 hrs of runtime.
14) Identify the Batman movie which is not directed by "Christopher Nolan".
15) Display all the A and UA certified movies which are either directed by "Steven Spielberg", "Christopher Nolan" or which are directed by other directors but have a rating of over 8.
16) What are the different certificates given to movies?
17) Display all the movies acted by Tom Cruise in the order of their release. Consider only movies which have a meta score.
18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. Movies shorter than 1 hour should be termed as short film. Movies longer than 2 hrs should be termed as longer movies. All others can be termed as Good watch time.
19) Write a query to display the "Christian Bale" movies which released in odd year and even year. Sort the data as per Odd year at the top.
20) Re-write problem #18 without using case statement.
*/

/*
Extra Assignment:
1) Split the value '1234_1234' into 2 seperate columns having 1234 each.

2) We see a string value 'PG' in released_year and we hardcoaded it, can we make a query dynamic to identify string value incase if we have multiple string values in-order to ignore those string values
Write a query to identify non numeric values in a column.
*/

--- SOLUTIONS ---

-- 1) Fetch all data from imdb table

SELECT * FROM imdb_top_movies;

-- 2) Fetch only the name and release year for all movies.

SELECT 
	series_title
	,released_year 
FROM imdb_top_movies;

-- 3) Fetch the name, release year and imdb rating of movies which are UA certified.

SELECT
    series_title
	,released_year
	,imdb_rating
FROM imdb_top_movies
WHERE certificate = 'UA';

-- 4) Fetch the name and genre of movies which are UA certified and have a Imdb rating of over 8.

SELECT 
	series_title
	,genre
	,imdb_rating
FROM imdb_top_movies
WHERE certificate = 'UA' AND imdb_rating > 8;

-- 5) Find out how many movies are of Drama genre.

SELECT * FROM imdb_top_movies;

SELECT count(*)
FROM imdb_top_movies
WHERE genre LIKE '%Drama%' -- 724

-- 6) How many movies are directed by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" and "Rajkumar Hirani".

SELECT count(1)
FROM imdb_top_movies
WHERE
    director IN (
        'Quentin Tarantino'
		,'Steven Spielberg'
        ,'Christopher Nolan'
        ,'Rajkumar Hirani'
)

-- 7) What is the highest imdb rating given so far?

SELECT max(imdb_rating) AS max_rating 
FROM imdb_top_movies movies

-- 8) What is the highest and lowest imdb rating given so far?

SELECT
    max(imdb_rating) AS highest_rating,
    min(imdb_rating) AS lowest_rating
FROM imdb_top_movies

-- 8a) Solve the above problem but display the results in different rows.

SELECT max(imdb_rating) AS highest_rating
FROM imdb_top_movies
UNION
SELECT min(imdb_rating) AS lowest_rating
FROM imdb_top_movies

-- 8b) Solve the above problem but display the results in different rows. And have a column which indicates the value as lowest and highest.

SELECT max(imdb_rating) AS movie_rating, 'Highest rating' AS high_low
FROM imdb_top_movies
UNION
SELECT min(imdb_rating), 'Lowest rating' AS high_low
FROM imdb_top_movies

-- 9) Find out the total business done by movies staring "Aamir Khan".

SELECT sum(gross)
FROM imdb_top_movies
WHERE star1 = 'Aamir Khan'
OR star2 = 'Aamir Khan'
OR star3 = 'Aamir Khan'
OR star4 = 'Aamir Khan';

SELECT sum(gross)
FROM imdb_top_movies
WHERE 'Aamir Khan' IN (star1, star2, star3, star4);

/* 10) Find out the average imdb rating of movies which are neither directed
by "Quentin Tarantino", "Steven Spielberg", "Christopher Nolan" 
	and are not acted by any of these stars "Christian Bale", "Liam Neeson"
		, "Heath Ledger", "Leonardo DiCaprio", "Anne Hathaway".
*/

SELECT avg(imdb_rating) AS avg_rating
FROM imdb_top_movies
WHERE
    director NOT IN (
        'Quentin Tarantino',
        'Steven Spielberg',
        'Christopher Nolan'
    )
    AND (
        star1 NOT IN (
            'Christian Bale',
            'Liam Neeson',
            'Heath Ledger',
            'Leonardo DiCaprio',
            'Anne Hathaway'
        )
        AND star2 NOT IN (
            'Christian Bale',
            'Liam Neeson',
            'Heath Ledger',
            'Leonardo DiCaprio',
            'Anne Hathaway'
        )
        AND star3 NOT IN (
            'Christian Bale',
            'Liam Neeson',
            'Heath Ledger',
            'Leonardo DiCaprio',
            'Anne Hathaway'
        )
        AND star4 NOT IN (
            'Christian Bale',
            'Liam Neeson',
            'Heath Ledger',
            'Leonardo DiCaprio',
            'Anne Hathaway'
        )
);

-- 11) Mention the movies involving both "Steven Spielberg" and "Tom Cruise".

SELECT *
FROM imdb_top_movies
WHERE
    director = 'Steven Spielberg'
    AND (
        star1 = 'Tom Cruise'
        OR star2 = 'Tom Cruise'
        OR star3 = 'Tom Cruise'
        OR star4 = 'Tom Cruise'
);

-- 12) Display the movie name and watch time (in both mins and hours) which have over 9 imdb rating.

SELECT
    series_title,
    runtime AS runtime_mins,
    cast(replace(runtime, ' min', '') AS decimal) / 60 AS runtime_hrs,
    round(replace(runtime, ' min', '')::decimal / 60, 2) AS runtime_hrs
FROM imdb_top_movies
WHERE imdb_rating > 9;

-- 13) What is the average imdb rating of movies which are released in the last 10 years and have less than 2 hrs of runtime.

SELECT round(avg(imdb_rating), 2) AS avg_rating
FROM imdb_top_movies
WHERE
    released_year <> 'PG'
    AND extract(YEAR FROM CURRENT_DATE) - released_year::int <= 10
    AND round(replace(runtime, ' min', '') :: decimal / 60, 2) < 2;

-- 14) Identify the Batman movie which is not directed by "Christopher Nolan".

SELECT *
FROM imdb_top_movies
WHERE upper(series_title) LIKE '%BATMAN%'
    AND director <> 'Christopher Nolan';

-- 15) Display all the A and UA certified movies which are either directed by "Steven Spielberg", "Christopher Nolan" or which are directed by other directors but have a rating of over 8.

SELECT *
FROM imdb_top_movies
WHERE
    certificate IN ('A', 'UA')
    AND (
        director IN (
            'Steven Spielberg',
            'Christopher Nolan'
        )
        OR (
            director NOT IN (
                'Steven Spielberg',
                'Christopher Nolan'
            )
            AND imdb_rating > 8
        )
    );

-- 16) What are the different certificates given to movies?

SELECT
    DISTINCT certificate 
FROM imdb_top_movies 
ORDER BY 1;

SELECT 
    DISTINCT certificate
FROM imdb_top_movies
ORDER BY certificate;

-- 17) Display all the movies acted by Tom Cruise in the order of their release. Consider only movies which have a meta score.

SELECT *
FROM imdb_top_movies
WHERE
    meta_score IS NOT NULL
    AND (
        star1 = 'Tom Cruise'
        OR star2 = 'Tom Cruise'
        OR star3 = 'Tom Cruise'
        OR star4 = 'Tom Cruise'
    )
ORDER BY released_year;

/* 18) Segregate all the Drama and Comedy movies released in the last 10 years as per their runtime. 
Movies shorter than 1 hour should be termed as short film. 
Movies longer than 2 hrs should be termed as longer movies. 
All others can be termed as Good watch time.
*/

SELECT * FROM imdb_top_movies WHERE released_year = 'PG'

SELECT
    series_title AS movie_name,
    CASE
        WHEN round(replace(runtime, ' min', '')::decimal / 60, 2) < 1 THEN 'Short film'
        WHEN round(replace(runtime, ' min', '')::decimal / 60, 2) > 2 THEN 'Longer Movies'
        ELSE 'Good watch time'
    END AS category
FROM imdb_top_movies
WHERE
    released_year <> 'PG'
    AND extract(YEAR FROM CURRENT_DATE) - released_year::int <= 10
    AND (upper(genre) LIKE '%DRAMA%'OR lower(genre) LIKE '%comedy%')
ORDER BY category;

-- 19) Write a query to display the "Christian Bale" movies which released in odd year and even year. Sort the data as per Odd year at the top.

SELECT
    series_title AS movie_name,
    released_year,
    CASE
        WHEN released_year::int % 2 = 0 THEN 'Even year'
        ELSE 'Odd year'
    END AS odd_or_even
FROM imdb_top_movies
WHERE
    released_year <> 'PG'
    AND (
        star1 = 'Christian Bale'
        OR star2 = 'Christian Bale'
        OR star3 = 'Christian Bale'
        OR star4 = 'Christian Bale'
    )
ORDER BY odd_or_even DESC;

-- 20) Re-write problem #18 without using case statement.

SELECT
    series_title AS movie_name,
    'Short film' AS category,
    round(replace(runtime, ' min', '')::decimal / 60, 2) AS runtime
FROM imdb_top_movies
WHERE
    released_year <> 'PG'
    AND extract(YEAR FROM CURRENT_DATE) - released_year::int <= 10
    AND (
        upper(genre) LIKE '%DRAMA%'
        OR lower(genre) LIKE '%comedy%'
    )
    AND round(replace(runtime, ' min', '')::decimal / 60, 2) < 1
UNION ALL
SELECT
    series_title AS movie_name,
    'Longer Movies' AS category,
    round(replace(runtime, ' min', '')::decimal / 60, 2) AS runtime
FROM imdb_top_movies
WHERE
    released_year <> 'PG'
    AND extract(YEAR FROM CURRENT_DATE) - released_year::int <= 10
    AND (
        upper(genre) LIKE '%DRAMA%'
        OR lower(genre) LIKE '%comedy%'
    )
    AND round(replace(runtime, ' min', '')::decimal / 60, 2) > 2
UNION ALL
SELECT
    series_title AS movie_name,
    'Good watch time' AS category,
    round(replace(runtime, ' min', '')::decimal / 60,2) AS runtime
FROM imdb_top_movies
WHERE
    released_year <> 'PG'
    AND extract(YEAR FROM CURRENT_DATE) - released_year::int <= 10
    AND (
        upper(genre) LIKE '%DRAMA%'
        OR lower(genre) LIKE '%comedy%'
    )
    AND round(replace(runtime, ' min', '')::decimal / 60, 2) BETWEEN 1 AND 2
ORDER BY category;

-- Extra Assignment:
-- 1) Split the value '1234_1234' into 2 seperate columns having 1234 each.

-- PostgreSQL
SELECT 
    substring(
        '1234_5678', 1, position('_' IN '1234_5678') -1
    ) AS part1
    , substring(
        '1234_5678', position('_' IN '1234_5678') + 1
    ) AS part2

-- Oracle & other RDBMS
SELECT substr(
        '1234_5678', 1, instr ('1234_5678', '_', 1, 1) -1
    ) AS part1, substr(
        '1234_5678', instr ('1234_5678', '_', 1, 1) + 1
    ) AS part2

/* 2) We see a string value 'PG' in released_year and we hardcoaded it, can we make a query dynamic to identify string value incase if we have multiple string values in-order to ignore those string values
Write a query to identify non numeric values in a column.
*/

-- PostgreSQL
SELECT * FROM imdb_top_movies WHERE released_year !~ '[0-9]';

-- Oracle & other RDBMS
SELECT *
FROM imdb_top_movies
WHERE
    released_year NOT REGEXP_LIKE (released_year, '[0-9]');