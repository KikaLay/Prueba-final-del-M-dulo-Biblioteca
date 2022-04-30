CREATE DATABASE biblioteca_db;

CREATE TABLE autores(
codigo_autor SERIAL PRIMARY KEY,
nombre_autor VARCHAR(50) NOT null,
apellido_autor VARCHAR(50) NOT null,
fecha_nacimiento DATE NOT null,
fecha_muerte DATE
);

-- drop table autores;
-- drop table socios;
-- drop table libros;
-- drop table prestamos;
-- drop table autor_libro;

CREATE TABLE socios(
rut VARCHAR(50) PRIMARY KEY,
nombre_socio VARCHAR(50) NOT null,
apellido_socio VARCHAR(50) NOT null,
direccion VARCHAR (255) NOT null,
telefono INT NOT null
);

CREATE TABLE libros(
ISBN VARCHAR(255) primary KEY,
titulo VARCHAR(255) NOT null,
numero_paginas INT NOT null,
stock INT check ((stock > 0 and stock <= 1)) NOT null 
);

CREATE TABLE prestamos(
id SERIAL PRIMARY KEY,
fecha_inicio DATE NOT null,
fecha_devolucion DATE,
rut_socio VARCHAR (50) references socios(rut),
ISBN_libro VARCHAR (255) references libros(ISBN)
);
 
CREATE TABLE autor_libro(
id SERIAL primary KEY,
tipo_autor VARCHAR(50) NOT null,
codigo_autor SERIAL REFERENCES autores (codigo_autor),
ISBN_libro VARCHAR(255) REFERENCES libros (ISBN)
);

-- INSERTAR DATOS tabla socio

INSERT INTO socios(rut, nombre_socio, apellido_socio, direccion, telefono) VALUES
('1111111-1','JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', 911111111 );
INSERT INTO socios(rut, nombre_socio, apellido_socio, direccion, telefono) VALUES
('2222222-2','ANA ', 'PÉREZ ', 'PASAJE 2, SANTIAGO ', 922222222 );
INSERT INTO socios(rut, nombre_socio, apellido_socio, direccion, telefono) VALUES
('3333333-3','SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO ', 933333333 );
INSERT INTO socios(rut, nombre_socio, apellido_socio, direccion, telefono) VALUES
('4444444-4','ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', 944444444 );
INSERT INTO socios(rut, nombre_socio, apellido_socio, direccion, telefono) VALUES
('5555555-5','SILVANA', 'MUÑOZ', 'PASAJE 3, SANTIAGO ', 955555555 );

-- select * from socio;

-- INSERTAR DATOS tabla autores
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES
(3,'JOSE', 'SALGADO', '1-1-1968', '1-1-2020');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento) VALUES
(4 ,'ANA', 'SALGADO', '1-1-1972');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento) VALUES
(1,'ANDRES', 'ULLOA', '1-1-1982');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento, fecha_muerte) VALUES
(2,'SERGIO', 'MARDONES', '1-1-1950', '1-1-2012');
INSERT INTO autores (codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento) VALUES
(5,'MARTIN', 'PORTA', '1-1-1976');

-- INSERTAR DATOS tabla libros

INSERT INTO libros (ISBN, titulo, numero_paginas, stock) VALUES
('111-111-1111-11-1','CUENTOS DE TERROR', 344, 1 );
INSERT INTO libros (ISBN, titulo, numero_paginas, stock) VALUES
('222-222-2222-22-2','POESÍAS CONTEMPO RANEAS', 167, 1 );
INSERT INTO libros (ISBN, titulo, numero_paginas, stock) VALUES
('333-333-3333-33-3','HISTORIA DE ASIA', 511, 1 );
INSERT INTO libros (ISBN, titulo, numero_paginas, stock) VALUES
('444-444-4444-44-4','MANUAL DE MECÁNICA', 298, 1 );

-- INSERTAR DATOS autor_libro

INSERT INTO autor_libro (id, tipo_autor, codigo_autor, ISBN_libro) VALUES
(1,'PRINCIPAL',3, '111-111-1111-11-1' );
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, ISBN_libro) VALUES
(2,'COAUTOR',4, '111-111-1111-11-1' );
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, ISBN_libro) VALUES
(3,'PRINCIPAL',1, '222-222-2222-22-2' );
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, ISBN_libro) VALUES
(4,'PRINCIPAL',2, '333-333-3333-33-3');
INSERT INTO autor_libro (id, tipo_autor, codigo_autor, ISBN_libro) VALUES
(5,'PRINCIPAL',5, '444-444-4444-44-4');

-- INSERTAR DATOS prestamos
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(1,'20-01-2020','27-01-2020','1111111-1','111-111-1111-11-1' );
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(2,'20-01-2020','30-01-2020','5555555-5','222-222-2222-22-2' );
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(3,'22-01-2020','30-01-2020','3333333-3','333-333-3333-33-3' );
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(4,'23-01-2020','30-01-2020','4444444-4','444-444-4444-44-4' );
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(5,'27-01-2020','04-02-2020','2222222-2','111-111-1111-11-1' );
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(6,'31-01-2020','12-02-2020','1111111-1', '444-444-4444-44-4' );
INSERT INTO prestamos (id, fecha_inicio, fecha_devolucion, rut_socio, ISBN_libro) VALUES
(7,'31-01-2020','12-02-2020','3333333-3','222-222-2222-22-2' );

select * from prestamos;

-- Mostrar todos los libros que posean menos de 300 páginas
select * from libros where numero_paginas < 300;

-- Mostrar todos los autores que hayan nacido después del 01-01-1970.
select * from autores where fecha_nacimiento > '01-01-1970' ;

-- ¿Cuál es el libro más solicitado?
select titulo as solicitado, count(ISBN_libro) from prestamos inner join libros on prestamos.ISBN_libro = libros.ISBN group by titulo order by count desc limit 1;

--Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
SELECT nombre_socio, apellido_socio, ((fecha_devolucion - fecha_inicio)-7)*100 as deuda
FROM socios INNER JOIN prestamos ON socios.rut = prestamos.rut_socio
where (fecha_devolucion - fecha_inicio) > 7;
