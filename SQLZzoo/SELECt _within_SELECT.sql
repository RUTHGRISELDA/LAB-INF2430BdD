-- 5. **SELECT within SELECT**

-- 1. List each country name where the population is larger than that of Russia.
SELECT name 
FROM world
WHERE population > (SELECT population 
                    FROM world
                    WHERE name = 'Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than United Kingdom's.
SELECT name 
FROM world
WHERE continent = 'Europe'
AND gdp/population > (SELECT gdp/population
                      FROM world
                      WHERE name = 'United Kingdom');

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. 
-- Order by name of the country.
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent 
                    FROM world 
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population
FROM world
WHERE population > (SELECT population 
                    FROM world 
                    WHERE name = 'Canada')
AND population < (SELECT population 
                  FROM world 
                  WHERE name = 'Poland');

-- 5. Alemania (con una población aproximada de 80 millones) es la mayor población de Europa. Austria (con una población de 8,5 millones) representa el 11% de la población de Alemania.
--Muestra el nombre y la población de cada país europeo. Muestra la población como porcentaje de la población de Alemania.
--El formato debe ser Nombre, Porcentaje por ejemplo

SELECT name, 
       CONCAT(CAST(ROUND(population/(SELECT population
                                     FROM world 
                                     WHERE name = 'Germany')
                         *100, 0) AS int), '%') AS percentage
FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? 
SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp) 
             FROM world 
             WHERE continent = 'Europe');

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area.
SELECT continent, name, area
FROM world
WHERE area IN (SELECT MAX(area) 
               FROM world 
               GROUP BY continent);

-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT continent, name
FROM world
WHERE name IN (SELECT MIN(name) 
               FROM world 
               GROUP BY continent);

-- 9. Find the continents where all countries have a population <= 25,000,000. 
-- Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population
FROM world AS x
WHERE 25000000 >= ALL(SELECT population 
                      FROM world AS y 
                      WHERE x.continent = y.continent 
                      AND population IS NOT NULL);

-- 10. Some countries have populations more than three times that of any of their neighbours (in the same continent). 
-- Give the countries and continents.
SELECT name, continent 
FROM world AS x 
WHERE population > ALL(SELECT population*3 
                       FROM world AS y 
                       WHERE y.continent = x.continent 
                       AND y.name <> x.name);
