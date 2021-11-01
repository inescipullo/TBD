CREATE DATABASE IF NOT EXISTS Biblioteca;

USE Biblioteca;

/* EJERCICIO 1 */

DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;
DROP TABLE IF EXISTS Escribe;

CREATE TABLE Autor (
  id            INT         NOT NULL    AUTO_INCREMENT,
  nombre        VARCHAR(30) NOT NULL,
  apellido      VARCHAR(30) NOT NULL,
  nacionalidad  VARCHAR(30) NOT NULL,
  residencia    VARCHAR(30),
  PRIMARY KEY (id)
);

CREATE TABLE Libro (
  ISBN      VARCHAR(13)     NOT NULL,
  título    VARCHAR(50)     NOT NULL,
  editorial VARCHAR(20)     NOT NULL,
  precio    DOUBLE UNSIGNED NOT NULL, -- existe MONEY tambien
  PRIMARY KEY (ISBN)
);

CREATE TABLE Escribe (
  id    INT     NOT NULL,
  ISBN  INT     NOT NULL,
  año   YEAR    NOT NULL, -- is this ok? (sino INT)
  PRIMARY KEY (id, ISBN),
  FOREIGN KEY (id) REFERENCES Autor(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (ISBN) REFERENCES Libro(ISBN) ON UPDATE CASCADE ON DELETE CASCADE,
);

/* EJERCICIO 2 */

CREATE INDEX apellido_autor_index ON Autor(apellido);

CREATE INDEX título_libre_index ON Libro(título);

/* EJERCICIO 3 */

-- En general, por una cuestion de funcionalidad, tendria sentido que cada libro cargado aparezca al menos una vez en la tabla escribe, eso significa que su autor/es deberia/n estar cargado/s en la tabla Autor, importa que esto se respete en la carga de datos a las tablas?

INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Abelardo', 'Castillo', 'Argentina', 'Córdoba');
INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Stephen', 'Hawking', 'Inglaterra', 'Oxford');
INSERT INTO Autor (nombre, apellido, nacionalidad) VALUES ('Jorge Luis', 'Borges', 'Argentina');
INSERT INTO Autor (nombre, apellido, nacionalidad) VALUES ('María Elena', 'Walsh', 'Argentina');
INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Isabel', 'Castilla', 'España', 'Córdoba');
INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Pablo', 'Neruda', 'Chile', 'Cañete');

INSERT INTO Libro VALUES ("9780857501004", 'A brief history of time', 'Bantam Books', 2000);
INSERT INTO Libro VALUES ("0130183806", 'Redes Globales de Información con Internet y TCP/IP', 'Prentice Hall', 4195);
INSERT INTO Libro VALUES ("9789505116362", 'El reino del revés', 'Alfaguara', 1350);

INSERT INTO Escribe VALUES ((SLECT id FROM Empleado WHERE nombre = 'Stephen' AND apellido = 'Hawking'), 9780857501004, 2016);
INSERT INTO Escribe VALUES ((SLECT id FROM Empleado WHERE nombre = 'María Elena' AND apellido = 'Walsh'), 9789505116362, 1965);


/* EJERCICIO 4 */

UPDATE Autor SET residencia = 'Buenos Aires'
WHERE nombre = 'Abelardo' AND apellido = 'Castillo';

UPDATE Libro SET precio = precio*1.1
WHERE editorial = 'UNR';

UPDATE Libro
SET precio = precio*1.1
WHERE precio > 200 AND
ISBN IN (SELECT ISBN FROM Escribe, Autor WHERE nacionalidad <> 'Argentina')
UPDATE Libro
SET precio = precio*1.2
WHERE precio < 200 AND
ISBN IN (SELECT ISBN FROM Escribe, Autor WHERE nacionalidad <> 'Argentina')

DELETE FROM Libro
WHERE año = 1998;
