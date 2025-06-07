--1.El ejemplo utiliza una cláusula WHERE para mostrar los casos en 'Italia' en marzo de 2020.
--Modificar la consulta para mostrar datos de España
SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn
--1 solucion
SELECT
  name,
  DAY(whn) AS día,
  confirmed,
  deaths,
  recovered
FROM covid
WHERE
  name = 'Spain'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY whn;
--2.La función LAG se utiliza para mostrar datos de la fila anterior o de la tabla. Al alinear las filas, los datos se dividen por nombre de país y se ordenan según el dato whn . Esto significa que solo se consideran los datos de Italia.
--Modificar la consulta para mostrar la confirmada del día anterior.
SELECT name, DAY(whn), confirmed,
   LAG(whn, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

--2  SOLUCION
SELECT
  name,
  DAY(whn) AS día,
  confirmed,
  LAG(confirmed, 1) OVER (
    PARTITION BY name
    ORDER BY whn
  ) AS "base de datos"
FROM covid
WHERE
  name = 'Italy'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY whn;

--3 El número de casos confirmados es acumulativo , pero podemos utilizar LAG para recuperar la cantidad de casos nuevos informados cada día.
--Muestra el número de casos nuevos para cada día, para Italia, para marzo.
  SELECT name,
  DAY(whn) AS dia,
  confirmed - LAG(confirmed) OVER (PARTITION BY name ORDER BY whn) AS casos_nuevos
FROM covid
WHERE name = 'Italy'
  AND whn BETWEEN '2020-03-01' AND '2020-03-31'
ORDER BY whn;
--3 solucion
SELECT name, whn,confirmed - LAG(confirmed) OVER (PARTITION BY name ORDER BY whn) AS casos_nuevos_lunes
FROM covid
WHERE name = 'Italy'
  AND whn BETWEEN '2020-03-01' AND '2020-03-31'
  AND WEEKDAY(whn) = 0  -- lunes = 0 en SQL
ORDER BY whn;
--4.Los datos recopilados son necesariamente estimaciones e inexactos. Sin embargo, al considerar un período más largo, podemos mitigar algunos de los efectos.
--Puede filtrar los datos para ver solo las cifras del lunes WHERE WEEKDAY(whn) = 0 .
--Muestra el número de casos nuevos en Italia para cada semana en 2020 - muestra solo el lunes.
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), confirmed
 FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0 AND YEAR(whn) = 2020
ORDER BY whn
--4 SOLUCION
SELECT name,DATE_FORMAT(whn, '%Y-%m-%d') AS semana,confirmed - LAG(confirmed) OVER (PARTITION BY name ORDER BY whn) AS nuevo_esta_semana
FROM covid
WHERE name = 'Italy'
  AND YEAR(whn) = 2020
  AND WEEKDAY(whn) = 0
ORDER BY whn;
--5 LAG usando una UNIÓN
--Puedes unir una tabla mediante la función de fecha. Esto generará resultados diferentes si faltan datos.
--Mostrar el número de casos nuevos en Italia para cada semana (mostrar solo el lunes).
--En la consulta de muestra UNIMOS esta semana tw con la semana pasada lw usando la función DATE_ADD.

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
 tw.confirmed, lw.confirmed
 FROM covid tw LEFT JOIN covid lw ON 
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
   AND tw.name=lw.name
WHERE tw.name = 'Italy'
ORDER BY tw.whn

--5.Solucion
