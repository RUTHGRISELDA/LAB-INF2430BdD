-- ******3. SELECT from world****

-- 1.Lea las notas sobre esta tabla. Observe el resultado de ejecutar este comando SQL 
--para mostrar el nombre, el continente y la población de todos los países.Show the name,
 --continent and population of all countries.
SELECT name, continent, population 
FROM world;

-- 2.Cómo usar WHERE para filtrar registros. Muestra el nombre de los países con una población 
--de al menos 200 millones. 200 millones es 200000000, con ocho ceros.Show the name for the countries
-- that have a population of at least 200 million.
SELECT name 
FROM world
WHERE population >= 200000000;

-- 3.Proporcione el namePIB per cápita para aquellos países con una población populationde al menos
--- 200 millones.
-- Show the name and per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population
FROM world
WHERE population >= 200000000;

-- 4.Muestra la namepoblación populationen millones para los países de continentSudamérica. 
--Divide la población entre 1000000 para obtener la población en millones. Show the name and 
--population in millions for the countries of the continent South America. 
SELECT name, population/1000000
FROM world
WHERE continent = 'South America';

-- 5. Show the name and population for France, Germany, Italy.
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Show the countries which have a name that includes the word "United".
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7. Dos maneras de ser grande: Un país es grande si tiene una
-- superficie de más de 3 millones de kilómetros cuadrados o tiene una población de más
-- de 250 millones.Show the countries that are big by area (more than 3 million) or big by population
-- (more than 250 million). 
-- Show name, population and area.
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

-- 8. OR exclusivo (XOR). Muestra los países con mayor superficie (más de 3 millones)
-- o mayor población (más de 250 millones), pero no ambos. Muestra el nombre, la población y la superficie.
--Australia tiene una gran superficie pero una población pequeña, por lo que debería estar incluida .
--Indonesia tiene una gran población pero una superficie pequeña, por lo que debería ser incluida .
--China tiene una gran población y una gran superficie, debería ser excluida .
--El Reino Unido tiene una población pequeña y una superficie pequeña, por lo que debería ser excluido .
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population <250000000) 
OR (area < 3000000 AND population > 250000000);

-- 9.Muestra el " namey population" en millones y el PIB en miles de millones de los
-- países de continentSudamérica. Usa la función REDONDEAR para mostrar los valores con dos decimales.
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- 10. PIB de al menos un billón (1000000000000; es decir, 12 ceros). 
--Redondee este valor al millar más cercano.
--Show per-capita GDP for the trillion dollar countries to the nearest 1000.
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;

-- 11. Grecia tiene como capital Atenas.
--Cada una de las cadenas 'Grecia' y 'Atenas' tiene 6 caracteres.
--Mostrar el nombre y la mayúscula donde el nombre y la mayúscula tienen el mismo número de caracteres.
--Puede utilizar la función LENGTH para encontrar el número de caracteres en una cadena
--Para Microsoft SQL Server la función LENGTH es LEN

SELECT name, capital 
FROM world 
WHERE LEN(name) = LEN(capital);

-- 12. La capital de Suecia es Estocolmo. Ambas palabras empiezan con la letra "S".
--Muestra el nombre y la capital donde las primeras letras de cada palabra coinciden.
-- No incluyas países donde el nombre y la capital son la misma palabra.
--Puede utilizar la función IZQUIERDA para aislar el primer carácter.
--Puedes utilizarlo <>como operador NO IGUAL .

SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)) 
AND name <> capital;