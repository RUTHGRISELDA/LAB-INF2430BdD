--SELECT basics 
--1.-El ejemplo utiliza una cláusula WHERE para mostrar la población de Francia. Tenga en cuenta que las cadenas deben estar entre comillas simples.
SELECT  population 
FROM world
WHERE name= 'Germany'
--2.Comprobación de una lista. La palabra IN permite comprobar si un elemento está en una lista. El ejemplo muestra el nombre y la población de los países «Brasil», «Rusia», «India» y «China».
--Mostrar el nombre y la población de 'Suecia', 'Noruega' y 'Dinamarca'.
SELECT name, population
FROM world
WHERE name IN ('Sweden','Norway','Denmark');
--3.Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). The example below shows countries with an area of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000