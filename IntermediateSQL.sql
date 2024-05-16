CREATE TABLE film (
    id INT NOT NULL PRIMARY KEY,
    title VARCHAR(300),
    release_year INT,
    country VARCHAR(50),
    duration INT,
    language VARCHAR(50),
    certification VARCHAR(40),
    gross BIGINT,
    budget BIGINT
);
select * from film;


CREATE TABLE people (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    birthdate DATE,
    deathdate DATE
);
select * from people;


CREATE TABLE roles (
    ID INT NOT NULL PRIMARY KEY,
    film_id INT,
    person_id INT,
    role VARCHAR(50)
);
select * from roles;

CREATE TABLE reviews (
    ID INT NOT NULL PRIMARY KEY,
    film_id INT,
    num_user INT,
    num_critic INT,
    imdb_score DECIMAL(5, 2),
    num_votes INT,
    facebook_likes INT
);

select * from reviews;


--COUNT()

-- Count the number of records in the people table
SELECT COUNT(id) AS count_records
FROM people;

-- Count the number of birthdates in the people table
SELECT COUNT(birthdate) AS count_birthdate
FROM people;

-- Count the records for languages and countries represented in the films table
SELECT COUNT(language) AS count_languages, COUNT(country) AS count_countries 
FROM film;



--SELECT DISTINCT

-- Return the unique countries from the films table
SELECT DISTINCT country
FROM film;

-- Count the distinct countries from the films table
SELECT COUNT (DISTINCT country) AS count_distinct_countries
FROM film;



--WHERE WITH NUMBERS

-- Select film_ids and imdb_score with an imdb_score over 7.0
SELECT film_id, imdb_score
FROM reviews
WHERE imdb_score > 7.0;

-- Select film_ids and facebook_likes for ten records with less than 1000 likes 
SELECT film_id, facebook_likes
FROM reviews
WHERE facebook_likes < 1000
LIMIT 10;

-- Count the records with at least 100,000 votes
SELECT COUNT(*) AS films_over_100K_votes
FROM reviews
WHERE num_votes >=100000;

--WHERE WITH TEXT

-- Count the Spanish-language films
SELECT COUNT(language) AS count_spanish
FROM film
WHERE language = 'Spanish';



--USING AND

-- Select the title and release_year for all German-language films released before 2000
SELECT title, release_year
FROM film
WHERE release_year < 2000
    AND language = 'German';

-- Update the query to see all German-language films released after 2000
SELECT title, release_year
FROM film
WHERE release_year > 2000
	AND language = 'German';

-- Select all records for German-language films released after 2000 and before 2010
SELECT *
FROM film
WHERE language = 'German'
    AND release_year > 2000
    AND release_year < 2010;
	
	
	
--USING OR

-- Find the title and year of films from the 1990 or 1999
SELECT title, release_year
FROM film
WHERE release_year = 1990 
	OR release_year = 1999
		
-- Add a filter to see only English or Spanish-language films
	AND (language= 'English' OR language= 'Spanish')
	
-- Filter films with more than $2,000,000 gross
	AND gross > 2000000;
	
	
	
--USING BETWEEN

-- Select the title and release_year for films released between 1990 and 2000
SELECT title, release_year
FROM film
WHERE release_year
    BETWEEN 1990 AND 2000
	
-- Narrow down your query to films with budgets > $100 million
	AND budget > 100000000
	
-- Restrict the query to only Spanish-language films
	AND language = 'Spanish'

-- Amend the query to include Spanish or French-language films
	AND (language = 'Spanish' OR language = 'French');
	


--LIKE and NOT LIKE

-- Select the names that start with B
SELECT name
FROM people
WHERE name LIKE 'B%';

-- Select the names that have r as the second letter
SELECT name
FROM people
WHERE name LIKE '_r%';

-- Select names that don't start with A
SELECT name
FROM people
WHERE name NOT LIKE 'A%';



--WHERE IN

-- Find the title and release_year for all films over two hours in length released in 1990 and 2000
SELECT title, release_year
FROM film
WHERE release_year IN (1990,2000) 
    AND duration > 120;
	
-- Find the title and language of all films in English, Spanish, and French
SELECT title, language
FROM film
WHERE language IN ('English', 'Spanish', 'French');

-- Find the title, certification, and language all films certified NC-17 or R that are in English, Italian, or Greek
SELECT title, certification, language
FROM film
WHERE certification IN ('NC-17', 'R')
    AND language IN ('English', 'Italian', 'Greek');
	
	
	
--COMBINING FILTERING AND SELECTING

-- Count the unique titles
SELECT COUNT(DISTINCT title) AS nineties_english_films_for_teens
FROM film
-- Filter to release_years to between 1990 and 1999
WHERE release_year
	BETWEEN 1990 AND 1999
-- Filter to English-language films
	AND language = 'English'
-- Narrow it down to G, PG, and PG-13 certifications
	AND certification IN ('G', 'PG', 'PG-13');
	


--NULL

-- List all film titles with missing budgets
SELECT title AS no_budget_info
FROM film
WHERE budget IS NULL;

-- Count the number of films we have language data for
SELECT COUNT(title) AS count_language_known
FROM film
WHERE language IS NOT NULL; 



--AGGREGATE FUNCTIONS 

-- Query the sum of film durations
SELECT SUM(duration) AS total_duration
FROM film;

-- Calculate the average duration of all films
SELECT AVG(duration) AS average_duration
FROM film;

-- Find the latest release_year
SELECT MAX(release_year) AS latest_year
FROM film;

-- Find the duration of the shortest film
SELECT MIN(duration) AS shortest_film
FROM film;



--AGGREGATE FUNCTIONS WITH WHERE

-- Calculate the sum of gross from the year 2000 or later
SELECT SUM(gross) as total_gross
FROM film
WHERE release_year>=2000;

-- Calculate the average gross of films that start with A
SELECT AVG(gross) AS avg_gross_A
FROM film
WHERE title LIKE 'A%';

-- Calculate the lowest gross film in 1994
SELECT MIN(gross) AS lowest_gross
FROM film
WHERE release_year = 1994;

-- Calculate the highest gross film released between 2000-2012
SELECT MAX(gross) AS highest_gross
FROM film
WHERE release_year
    BETWEEN 2000 AND 2012;
	
	

--ROUND()

-- Round the average number of facebook_likes to one decimal place
SELECT ROUND(AVG(facebook_likes),1) AS avg_facebook_likes
FROM reviews;

-- Round duration_hours to two decimal places
SELECT title, ROUND((duration / 60.0),2) AS duration_hours
FROM film;

--ROUND() with a negative parameter

-- Calculate the average budget rounded to the thousands
SELECT ROUND(AVG(budget),-3) AS avg_budget_thousands
FROM film;



--SORTING SINGLE FIELDS

-- Select name from people and sort alphabetically
SELECT name
FROM people
ORDER BY name;

-- Select the title and duration from longest to shortest film
SELECT title, duration
FROM film
ORDER BY duration DESC;

-- Select the release year, duration, and title sorted by release year and duration
SELECT release_year, duration, title
FROM film
ORDER BY release_year, duration;

-- Select the certification, release year, and title sorted by certification and release year
SELECT certification, release_year, title
FROM film
ORDER BY certification, release_year DESC;



--GROUP BY single fields

-- Find the release_year and film_count of each year
SELECT release_year, COUNT(*) AS film_count
FROM film
GROUP BY release_year;

-- Find the release_year and average duration of films for each year
SELECT release_year, AVG(duration) AS avg_duration
FROM film
GROUP BY release_year;



--GROUP BY multiple fields

-- Find the release_year, country, and max_budget, then group and order by release_year and country
SELECT release_year, country, MAX(budget) AS max_budget
FROM film
GROUP BY release_year, country;



--HAVING with filter

-- Select the country and distinct count of certification as certification_count
SELECT country, COUNT(DISTINCT certification) AS certification_count
FROM film
-- Group by country
GROUP BY country
-- Filter results to countries with more than 10 different certifications
HAVING COUNT(DISTINCT certification) > 10;



--HAVING with sorting

-- Select the country and average_budget from films
SELECT country, ROUND(AVG(budget),2) AS average_budget
FROM film
-- Group by country
GROUP BY country
-- Filter to countries with an average_budget of more than one billion
HAVING ROUND(AVG(budget),2) > 1000000000
-- Order by descending order of the aggregated budget
ORDER BY average_budget DESC;