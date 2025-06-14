--1.You can use WHERE name LIKE 'B%' to find the countries that start with "B".
--The % is a wild-card it can match any characters
-- Find the country that start with "Y".
SELECT name
FROM world
WHERE name LIKE 'Y%';

--2 Find the countries that end with "y".
SELECT name 
FROM world
WHERE name LIKE '%y';

-- 3.Luxembourg has an x - so does one other country. List them both.
-- Find the countries that contain the letter "x".
SELECT name 
FROM world
WHERE name LIKE '%x%';

-- 4.Iceland, Switzerland end with land - but are there others?
 --Find the countries that end with "land".
SELECT name 
FROM world
WHERE name LIKE '%land';

-- 5.Columbia starts with a C and ends with ia - there are two more like this.
-- Find the countries that start with "C" and end with "ia".
SELECT name 
FROM world
WHERE name LIKE 'C%' AND name LIKE '%ia';

-- 6.Greece has a double e - who has a double o?
-- Find the country that has "oo" in the name.
SELECT name 
FROM world
WHERE name LIKE '%oo%';

-- 7.Bahamas has three a - who else?
-- Find the countries that have three or more "a" in the name.
SELECT name 
FROM world
WHERE name LIKE '%a%a%a%';

-- 8. India and Angola have an n as the second character. 
--You can use the underscore as a single character wildcard.
---Find the countries that have "t" as the second character.
SELECT name 
FROM world
WHERE name LIKE '_t%';

-- 9. Lesotho and Moldova both have two o characters separated by two other characters.
--Find the countries that have two "o" characters separated by two others.
SELECT name 
FROM world
WHERE name LIKE '%o__o%';

-- 10. Cuba and Togo have four characters names.
--Find the countries that have exactly four characters.
SELECT name 
FROM world
WHERE name LIKE '____';

-- 11. The capital of Luxembourg is Luxembourg. Show all the countries where the capital
-- is the same as the name of the country
--Find the country where the name is the capital city.
SELECT name
FROM world
WHERE name = capital;

-- 12.The capital of Mexico is Mexico City. Show all the countries where the capital has 
--the country together with the word "City".
-- Find the country where the capital is the country plus "City".
SELECT name
FROM world
WHERE capital = CONCAT(name, ' City');

-- 13. Find the capital and the name where the capital includes the name of the country.
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%');

-- 14. Find the capital and the name where the capital is an extension of name of the country.
--You should include Mexico City as it is longer than Mexico. You should not include Luxembourg
-- as the capital is the same as the country.
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT(name, '_%');

-- 15. Show the name and the extension where the capital is an extension of name of the country. 
-- (For Monaco-Ville the name is Monaco and the extension is -Ville.)
SELECT name, REPLACE(capital, name, '')
FROM world
WHERE capital LIKE CONCAT(name,'_%');
-- 13. Find the country that has all the vowels and no spaces in its name.
--Guinea Ecuatorial y República Dominicana tienen todas las vocales (aeiou) en el nombre. No cuentan porque tienen más de una palabra.
--Encuentra el país que tiene todas las vocales y ningún espacio en su nombre.
--Puede utilizar la frase name NOT LIKE '%a%'para excluir caracteres de sus resultados.
--La consulta mostrada no incluye países como Bahamas y Bielorrusia porque contienen al menos una "a".
SELECT name
FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %';
