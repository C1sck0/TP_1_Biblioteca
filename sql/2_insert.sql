USE Sistema_Biblioteca;

-- Ciudades y Campus
INSERT INTO CIUDAD (ID_CIUDAD, NOMBRE) VALUES 
(10, 'Valparaíso'),
(20, 'Santiago'),
(30, 'Concepción');

INSERT INTO CAMPUS (ID_CAMPUS, NOMBRE, ID_CIUDAD) VALUES 
(100, 'Campus Sausalito', 10),
(200, 'Campus San Joaquín', 20),
(300, 'Campus El Trébol', 30);

-- Carreras
INSERT INTO CARRERAS (ID_CARRERA, NOMBRE, ID_CAMPUS) VALUES 
(1, 'Ingeniería en Informática', 100),
(2, 'Contador Auditor', 200),
(3, 'Ingeniería Civil Industrial', 300);

-- Estudiantes (se incluye uno sin préstamos y edades variadas >25)
INSERT INTO ESTUDIANTES (RUT_EST, NOMBRES, APELLIDOS, EDAD, FONO, DIRECCION, ID_CARRERA) VALUES 
('18.111.222-1', 'Martín Andrés', 'Paredes Muñoz', 27, '+56911223344', 'Av. Libertad 450', 1),
('19.333.444-2', 'Camila Belén', 'Salazar Soto', 26, '+56922334455', 'Calle Uno 890', 1),
('20.555.666-3', 'Felipe Ignacio', 'Morales Silva', 22, '+56933445566', 'Pasaje Los Aromos 12', 2),
('21.777.888-4', 'Javiera Paz', 'Cárdenas Vera', 29, '+56944556677', 'Av. España 1230', 3),
('22.999.000-5', 'Gonzalo Esteban', 'Reyes Pinto', 20, '+56955667788', 'Av. Marina 200', 1),
('23.123.456-6', 'Daniela Ignacia', 'Navarro Ortiz', 19, '+56966778899', 'Calle Quillota 67', 2); -- Estudiante sin préstamos

-- Funcionarios (edades >50 y estados de salud variados)
INSERT INTO FUNCIONARIOS (RUT_FUNC, NOMBRES, APELLIDOS, EDAD, DIRECCION, SALUD, ID_CAMPUS) VALUES 
('11.222.333-K', 'Hernán Rodrigo', 'Gómez Castro', 56, 'Los Plátanos 144', 'Regular', 100),
('12.333.444-9', 'Beatriz Elena', 'Miranda Rojas', 42, 'Alvares 780', 'Buena', 200),
('10.444.555-8', 'Carlos Alberto', 'Monroy Vega', 61, 'Paicaví 1520', 'Crónica', 300);

-- Catálogo: Autores, Editoriales, Tipos y Bibliotecas
INSERT INTO AUTORES (RUT_AUTOR, NOMBRES, APELLIDOS) VALUES 
('AUT-01', 'Gabriela', 'Mistral'),
('AUT-02', 'Pablo', 'Neruda'),
('AUT-03', 'Isabel', 'Allende'),
('AUT-04', 'Roberto', 'Bolaño');

INSERT INTO EDITORIALES (ID_EDIT, NOMBRE, PAIS) VALUES 
(1, 'Editorial Universitaria', 'Chile'),
(2, 'Alfaguara', 'España'),
(3, 'Planeta', 'México'); -- Editorial ID=3 requerida

INSERT INTO TIPO (ID_TIPO, TIPO_P) VALUES 
(1, 'Poesía Lírica'),
(2, 'Novela Contemporánea'),
(3, 'Ensayo Histórico');

INSERT INTO BIBLIOTECA (ID_BIBLIO, BIBLIOTECA) VALUES 
(1, 'Biblioteca Mayor Sausalito'),
(2, 'Biblioteca Central San Joaquín'),
(3, 'Biblioteca Regional Bío-Bío');

-- Libros (varios por autor, libro más antiguo, libro sin préstamo y de ID_EDIT=3)
INSERT INTO LIBROS (COD_LIBRO, TITULO, ANIO, ID_BIBLIO, ID_TIPO, RUT_AUTOR, ID_EDIT) VALUES 
(201, 'Desolación', 1922, 1, 1, 'AUT-01', 3), -- Más antiguo, ID_EDIT=3
(202, 'Tala', 1938, 1, 1, 'AUT-01', 1), -- Autora con más de 1 libro
(203, 'Canto General', 1950, 2, 1, 'AUT-02', 2),
(204, 'La Casa de los Espíritus', 1982, 2, 2, 'AUT-03', 3), -- ID_EDIT=3
(205, 'Los Detectives Salvajes', 1998, 3, 2, 'AUT-04', 2),
(206, '2666', 2004, 3, 2, 'AUT-04', 3), -- ID_EDIT=3, autor con más de 1 libro
(207, 'Ejemplar de Reserva Sin Salida', 2021, 1, 3, 'AUT-03', 1); -- Libro nunca prestado

-- Préstamos (incluye mes anterior y múltiples préstamos por libro/funcionario)
INSERT INTO PRESTAMO (RUT_EST, RUT_FUNC, COD_LIBRO, FECHA_P, FECHA_E) VALUES 
-- Préstamos del mes anterior (dinámico con fechas del sistema)
('18.111.222-1', '11.222.333-K', 201, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), DATE_SUB(CURDATE(), INTERVAL 20 DAY)),
('19.333.444-2', '11.222.333-K', 202, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), DATE_SUB(CURDATE(), INTERVAL 15 DAY)),
-- Préstamos de este mes / activos
('20.555.666-3', '12.333.444-9', 201, CURDATE(), NULL),
('21.777.888-4', '11.222.333-K', 201, CURDATE(), NULL), -- 201 prestado 3 veces
('18.111.222-1', '12.333.444-9', 204, CURDATE(), NULL),
('22.999.000-5', '10.444.555-8', 204, CURDATE(), NULL), -- 204 prestado 2 veces
('20.555.666-3', '10.444.555-8', 205, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), NULL);