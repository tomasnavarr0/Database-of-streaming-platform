CREATE TABLE usuario(
NombreUsuario VARCHAR(20) PRIMARY KEY,
Contraseña VARCHAR(20))

CREATE TABLE planes(
PlanID INT IDENTITY(1,1) PRIMARY KEY,
NombrePlan VARCHAR(20),
Precio INT)

CREATE TABLE subscripcion(
NombreUsuario VARCHAR(20) PRIMARY KEY,
PlanID INT,
Estado BIT NOT NULL
FOREIGN KEY (PlanID) REFERENCES planes(PlanID),
FOREIGN KEY (NombreUsuario) REFERENCES usuario(NombreUsuario))

CREATE TABLE pelicula(
NombrePelicula VARCHAR(50) PRIMARY KEY,
Genero VARCHAR(50),
Subtitulada VARCHAR(20))

CREATE TABLE registro(
NombreUsuario VARCHAR(20),
PagoMes BIT NOT NULL,
FOREIGN KEY (NombreUsuario) REFERENCES usuario(NombreUsuario))

CREATE TABLE peliplan(
PlanID INT,
NombrePelicula VARCHAR(50),
FOREIGN KEY (PlanID) REFERENCES planes(PlanID),
FOREIGN KEY (NombrePelicula) REFERENCES pelicula(NombrePelicula))

INSERT INTO pelicula
VALUES 
('Argentina, 1985','Thriller/Drama','Subtitulada'),
('Star Wars IV','Ciencia Ficcion','Subtitulada'),
('IT','Terror','Doblada'),
('Harry Styles','Documental','Subtitulada'),
('Harry Potter y el Caliz de Fuego','Fantasia','Subtitulada'),
('Avengers: Infinity War', 'Accion', 'Subtitulada'),
('Avatar', 'Fantasia', 'Doblada'),
('Titanic', 'Drama', 'Doblada'), 
('Los Juegos del Hambre', 'Ciencia Ficcion', 'Subtitulada'), 
('Resident Evil', 'Accion', 'Doblada'), 
('El Conjuro', 'Terror', 'Subtitulada'), 
('Interestellar', 'Ciencia Ficcion', 'Subtitulada' )

INSERT INTO usuario
VALUES
('Mateo','Boca45'),
('Tomas','vamoseleccion'),
('Alejo','rugby2000'),
('Valentino','cAldao')

INSERT INTO planes
VALUES
('Gratuito',0),
('Premium',500),
('Familiar',700)

INSERT INTO subscripcion
VALUES
('Mateo',1,1),
('Tomas',3,1),
('Alejo',2,0),
('Valentino',2,1)

INSERT INTO registro
VALUES
('Mateo',1),
('Tomas',1),
('Alejo',0),
('Valentino',0)

INSERT INTO peliplan
VALUES 
(2,'Argentina, 1985'),
(1,'Star Wars IV'),
(1,'IT'),
(3,'Harry Styles'),
(1,'Harry Potter y el Caliz de Fuego'),
(2,'Avengers: Infinity War'),
(2,'Avatar'),
(3,'Titanic'), 
(1,'Los Juegos del Hambre'), 
(2,'Resident Evil'), 
(1,'El Conjuro'), 
(3,'Interestellar')


/*Ejercicio 3*/
SELECT * FROM registro
SELECT * FROM subscripcion




CREATE PROCEDURE comprobar
AS
DECLARE @plan INT
SELECT @plan=PlanID
FROM subscripcion

IF @plan>1
	UPDATE subscripcion
	SET Estado=registro.PagoMes
	FROM subscripcion INNER JOIN registro
	ON subscripcion.NombreUsuario=registro.NombreUsuario

UPDATE subscripcion
SET Estado=1
FROM subscripcion INNER JOIN registro
ON subscripcion.NombreUsuario=registro.NombreUsuario
WHERE PlanID=1


EXEC comprobar


DROP PROCEDURE comprobar


/*EJERCICIO 4*/

CREATE PROCEDURE iniciarSesion
  @USUARIO varchar(30),
  @CONTRASENIA varchar(20)
 AS
 BEGIN
	IF EXISTS (SELECT NombreUsuario,contraseña FROM usuario
	WHERE NombreUsuario=@USUARIO AND Contraseña=@CONTRASENIA
		)
	BEGIN
		IF EXISTS (SELECT NombreUsuario, Estado FROM subscripcion
		WHERE NombreUsuario=@USUARIO AND Estado=1
			)
			PRINT '1'
	END
	ELSE
		BEGIN
			PRINT '0'
		END
END

/*Ejecuta el procedimiento */

EXEC iniciarSesion 'Mateo','Boca45';
EXEC iniciarSesion 'Alejo','rugby200';
EXEC iniciarSesion 'Tomas','estudioRRII';
EXEC iniciarSesion 'Valentino','cAldao';

/* Elimina el procedimiento */
DROP PROCEDURE iniciarSesion





