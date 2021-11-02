USE `Inmobiliaria`;

-- Consulta a
SELECT nombre, apellido FROM Persona  
WHERE codigo IN (SELECT codigo_propietario FROM PoseeInmueble);

-- Consulta b
SELECT codigo FROM Inmueble
WHERE precio >= 600000 AND precio <= 700000;

-- Consulta c
SELECT nombre, apellido FROM Persona 
WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona
                 WHERE nombre_poblacion = 'Santa Fe' AND nombre_zona = 'Norte');

-- Consulta d
SELECT nombre, apellido FROM Persona
WHERE codigo IN (SELECT vendedor FROM Cliente
                 WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona
                                  WHERE nombre_poblacion = 'Rosario' AND nombre_zona = 'Centro'));

-- Consulta e
SELECT nombre_zona, COUNT(codigo), AVG(precio) FROM Inmueble
WHERE nombre_poblacion = 'Rosario' GROUP BY nombre_zona;

-- Consulta f
SELECT nombre, apellido FROM Persona 
WHERE codigo IN (SELECT codigo_cliente FROM PrefiereZona
                 WHERE nombre_poblacion = 'Santa Fe' 
                 GROUP BY codigo_cliente HAVING
                 COUNT(nombre_zona) = (SELECT COUNT(nombre_zona) FROM Zona
                                            WHERE nombre_poblacion = 'Santa Fe'));
