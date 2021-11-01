USE `Inmobiliaria`;

-- en las consultas donde piden nombre, devolver nombre y apellido o solo nombre?

-- Consulta a
SELECT nombre FROM Persona  
WHERE codigo IN (SELECT codigo_propietario FROM PoseeInmueble);

-- Consulta b
SELECT codigo FROM Inmueble
WHERE precio >= 600000 AND precio <= 700000;

-- Consulta c
SELECT nombre FROM Persona 
WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona
                 WHERE nombre_poblacion = 'Santa Fe' AND nombre_zona = 'Norte');

-- Consulta d
SELECT nombre FROM Persona
WHERE codigo IN (SELECT vendedor FROM Cliente
                 WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona
                                  WHERE nombre_poblacion = 'Rosario' AND nombre_zona = 'Centro'));

-- Consulta e
SELECT nombre_zona, COUNT(codigo), AVG(precio) FROM Inmueble
WHERE nombre_poblacion = 'Rosario' GROUP BY nombre_zona;

-- Consulta f
SELECT nombre FROM Persona 
WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona
                 WHERE nombre_poblacion = 'Santa Fe' 
                 GROUP BY codigo_cliente HAVING
                 COUNT(nombre_zona) = (SELECT COUNT(nombre_zona) FROM Zona
                                            WHERE nombre_poblacion = 'Santa Fe'));
