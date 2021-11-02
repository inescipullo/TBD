/*
Inés Cipullo C-6867/5
Katherine Sullivan S-5436/4
Ezequiel Bisiach B-6199/9
*/

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
  ISBN      VARCHAR(13)   NOT NULL,
  título    VARCHAR(60)   NOT NULL,
  editorial VARCHAR(20)   NOT NULL,
  precio    DECIMAL(16,2) NOT NULL,
  PRIMARY KEY (ISBN)
);

CREATE TABLE Escribe (
  id    INT         NOT NULL,
  ISBN  VARCHAR(13) NOT NULL,
  año   YEAR        NOT NULL,
  PRIMARY KEY (id, ISBN),
  FOREIGN KEY (id) REFERENCES Autor(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (ISBN) REFERENCES Libro(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

/* 
  Decidimos restringir la eliminación en Autor porque si bien podríamos reflejar este cambio en Escribe,
  en la tabla Libro nos podría quedar un libro cuyo autor haya sido eliminado. Esto implicaría que este libro no va a aparecer
  en la tabla Escribe y por consiguiente, quedaría excluído de cualquier consulta que se haga en base a esta tabla.
  Podremos eliminar a un autor una vez que hayamos eliminado todos sus libros (es decir, que no tenemos ninguna fila en Escribe 
  correspondiente al autor).
  Todas las otras modificaciones decidimos propagarlas.
*/

/* EJERCICIO 2 */

CREATE INDEX apellido_autor_index ON Autor(apellido);

CREATE INDEX título_libro_index ON Libro(título);

/* EJERCICIO 3 */

INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Abelardo', 'Castillo', 'Argentina', 'Córdoba');
INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Stephen', 'Hawking', 'Inglaterra', 'Oxford');
INSERT INTO Autor (nombre, apellido, nacionalidad) VALUES ('Jorge Luis', 'Borges', 'Argentina');
INSERT INTO Autor (nombre, apellido, nacionalidad) VALUES ('María Elena', 'Walsh', 'Argentina');
INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Isabel', 'Castilla', 'España', 'Córdoba');
INSERT INTO Autor (nombre, apellido, nacionalidad, residencia) VALUES ('Joanne Kathleen', 'Rowling', 'Inglaterra', 'Yate');
INSERT INTO Autor (nombre, apellido, nacionalidad) VALUES ('Pablo', 'Neruda', 'Chile');

INSERT INTO Libro VALUES ("9780857501004", 'A brief history of time', 'Bantam Books', 2000);
INSERT INTO Libro VALUES ("0130183806", 'Redes Globales de Información con Internet y TCP/IP', 'UNR', 180);
INSERT INTO Libro VALUES ("9789505116362", 'El reino del revés', 'Alfaguara', 1350);
INSERT INTO Libro VALUES ("9789878319063", 'Las otras puertas', 'UNR', 350);
INSERT INTO Libro VALUES ("9789878000114", 'Harry Potter y la cámara de los secretos', 'Salamanca', 1899);

INSERT INTO Escribe VALUES ((SELECT id FROM Autor WHERE nombre = 'Stephen' AND apellido = 'Hawking'), "9780857501004", 2016);
INSERT INTO Escribe VALUES ((SELECT id FROM Autor WHERE nombre = 'María Elena' AND apellido = 'Walsh'), "9789505116362", 1965);
INSERT INTO Escribe VALUES ((SELECT id FROM Autor WHERE nombre = 'Abelardo' AND apellido = 'Castillo'), "9789878319063", 1961);
INSERT INTO Escribe VALUES ((SELECT id FROM Autor WHERE nombre = 'Joanne Kathleen' AND apellido = 'Rowling'), "9789878000114", 1998);
INSERT INTO Escribe VALUES ((SELECT id FROM Autor WHERE nombre = 'Pablo' AND apellido = 'Neruda'), "0130183806", 1980);

/* EJERCICIO 4 */

UPDATE Autor SET residencia = 'Buenos Aires'
WHERE nombre = 'Abelardo' AND apellido = 'Castillo';

UPDATE Libro SET precio = precio*1.1
WHERE editorial = 'UNR';

UPDATE Libro
SET precio = precio*1.1
WHERE precio > 200 AND
ISBN IN (SELECT ISBN FROM Escribe, Autor WHERE 
         nacionalidad <> 'Argentina' AND Escribe.id = Autor.id);
UPDATE Libro
SET precio = precio*1.2
WHERE precio <= 200 AND
ISBN IN (SELECT ISBN FROM Escribe, Autor WHERE 
         nacionalidad <> 'Argentina' AND Escribe.id = Autor.id);

DELETE FROM Libro
WHERE ISBN IN (SELECT ISBN FROM Escribe WHERE año = 1998);
