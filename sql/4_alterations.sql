USE Sistema_Biblioteca;

-- 1. Insertar un nuevo estudiante con datos propios asignado a una carrera válida
INSERT INTO ESTUDIANTES (RUT_EST, NOMBRES, APELLIDOS, EDAD, FONO, DIRECCION, ID_CARRERA)
VALUES ('24.888.999-7', 'Joaquín Ignacio', 'Vergara Morales', 21, '+56987654321', 'Los Álamos 430', 1);

-- 2. Actualizar a 'Excelente' el estado de salud de funcionarios con más de 50 años
UPDATE FUNCIONARIOS 
SET SALUD = 'Excelente' 
WHERE EDAD > 50;

-- 3. Eliminar un libro específico que no tenga préstamos registrados
DELETE FROM LIBROS 
WHERE COD_LIBRO = 207;

-- 4. Modificar la editorial del libro código 206 por cambio de derechos comerciales
UPDATE LIBROS 
SET ID_EDIT = 1 
WHERE COD_LIBRO = 206;