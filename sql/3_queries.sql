USE Sistema_Biblioteca;

-- 1. Título y año de todos los libros ordenados del más antiguo al más nuevo
SELECT TITULO, ANIO 
FROM LIBROS 
ORDER BY ANIO ASC;

-- 2. Estudiantes mayores de 25 años
SELECT NOMBRES, APELLIDOS, EDAD 
FROM ESTUDIANTES 
WHERE EDAD > 25;

-- 3. Título y año de libros pertenecientes a la editorial con ID_EDIT = 3
SELECT TITULO, ANIO 
FROM LIBROS 
WHERE ID_EDIT = 3;

-- 4. Datos completos de autores cuyo apellido empiece con 'M'
SELECT * 
FROM AUTORES 
WHERE APELLIDOS LIKE 'M%';

-- 5. Funcionarios cuya salud no sea 'Buena'
SELECT NOMBRES, APELLIDOS, SALUD 
FROM FUNCIONARIOS 
WHERE SALUD != 'Buena';

-- 6. Título del libro junto al nombre y apellido de su autor
SELECT 
    lb.TITULO, 
    au.NOMBRES AS NOMBRE_AUTOR, 
    au.APELLIDOS AS APELLIDO_AUTOR
FROM LIBROS lb
INNER JOIN AUTORES au ON lb.RUT_AUTOR = au.RUT_AUTOR;

-- 7. Detalle transaccional de préstamos
SELECT 
    pr.FECHA_P AS FECHA_PRESTAMO,
    CONCAT(est.NOMBRES, ' ', est.APELLIDOS) AS ESTUDIANTE,
    lb.TITULO AS LIBRO,
    CONCAT(func.NOMBRES, ' ', func.APELLIDOS) AS FUNCIONARIO
FROM PRESTAMO pr
INNER JOIN ESTUDIANTES est ON pr.RUT_EST = est.RUT_EST
INNER JOIN LIBROS lb ON pr.COD_LIBRO = lb.COD_LIBRO
INNER JOIN FUNCIONARIOS func ON pr.RUT_FUNC = func.RUT_FUNC;

-- 8. Estudiante, carrera y ciudad donde cursa sus estudios
SELECT 
    CONCAT(est.NOMBRES, ' ', est.APELLIDOS) AS ESTUDIANTE,
    car.NOMBRE AS CARRERA,
    ciu.NOMBRE AS CIUDAD_CAMPUS
FROM ESTUDIANTES est
INNER JOIN CARRERAS car ON est.ID_CARRERA = car.ID_CARRERA
INNER JOIN CAMPUS cam ON car.ID_CAMPUS = cam.ID_CAMPUS
INNER JOIN CIUDAD ciu ON cam.ID_CIUDAD = ciu.ID_CIUDAD;

-- 9. Títulos de libros con nombre de editorial y país de origen
SELECT 
    lb.TITULO, 
    ed.NOMBRE AS EDITORIAL, 
    ed.PAIS
FROM LIBROS lb
INNER JOIN EDITORIALES ed ON lb.ID_EDIT = ed.ID_EDIT;

-- 10. Título del libro y nombre físico de la biblioteca donde reside
SELECT 
    lb.TITULO, 
    bib.BIBLIOTECA AS NOMBRE_BIBLIOTECA
FROM LIBROS lb
INNER JOIN BIBLIOTECA bib ON lb.ID_BIBLIO = bib.ID_BIBLIO;

-- 11. Conteo de libros por cada clasificación temática
SELECT 
    tp.TIPO_P AS CATEGORIA, 
    COUNT(lb.COD_LIBRO) AS TOTAL_EJEMPLARES
FROM TIPO tp
LEFT JOIN LIBROS lb ON tp.ID_TIPO = lb.ID_TIPO
GROUP BY tp.ID_TIPO, tp.TIPO_P;

-- 12. Promedio de edad de los estudiantes desglosado por carrera
SELECT 
    car.NOMBRE AS CARRERA, 
    ROUND(AVG(est.EDAD), 1) AS EDAD_PROMEDIO
FROM CARRERAS car
INNER JOIN ESTUDIANTES est ON car.ID_CARRERA = est.ID_CARRERA
GROUP BY car.ID_CARRERA, car.NOMBRE;

-- 13. Cantidad de préstamos gestionados por cada funcionario (de mayor a menor)
SELECT 
    CONCAT(func.NOMBRES, ' ', func.APELLIDOS) AS FUNCIONARIO,
    COUNT(pr.COD_LIBRO) AS CANTIDAD_PRESTAMOS
FROM FUNCIONARIOS func
LEFT JOIN PRESTAMO pr ON func.RUT_FUNC = pr.RUT_FUNC
GROUP BY func.RUT_FUNC, func.NOMBRES, func.APELLIDOS
ORDER BY CANTIDAD_PRESTAMOS DESC;

-- 14. Autores con más de 1 obra registrada en el sistema
SELECT 
    au.RUT_AUTOR,
    CONCAT(au.NOMBRES, ' ', au.APELLIDOS) AS AUTOR, 
    COUNT(lb.COD_LIBRO) AS TOTAL_OBRAS
FROM AUTORES au
INNER JOIN LIBROS lb ON au.RUT_AUTOR = lb.RUT_AUTOR
GROUP BY au.RUT_AUTOR, au.NOMBRES, au.APELLIDOS
HAVING COUNT(lb.COD_LIBRO) > 1;

-- 15. Cantidad de estudiantes vinculados por sede/ciudad
SELECT 
    ciu.NOMBRE AS CIUDAD, 
    COUNT(est.RUT_EST) AS TOTAL_ESTUDIANTES
FROM CIUDAD ciu
INNER JOIN CAMPUS cam ON ciu.ID_CIUDAD = cam.ID_CIUDAD
INNER JOIN CARRERAS car ON cam.ID_CAMPUS = car.ID_CAMPUS
LEFT JOIN ESTUDIANTES est ON car.ID_CARRERA = est.ID_CARRERA
GROUP BY ciu.ID_CIUDAD, ciu.NOMBRE;

-- 16. Libro más antiguo de la biblioteca (soporta empates mediante subconsulta)
SELECT TITULO, ANIO 
FROM LIBROS 
WHERE ANIO = (SELECT MIN(ANIO) FROM LIBROS);

-- 17. Alumnos que nunca han solicitado un libro
SELECT est.* 
FROM ESTUDIANTES est
LEFT JOIN PRESTAMO pr ON est.RUT_EST = pr.RUT_EST
WHERE pr.RUT_EST IS NULL;

-- 18. Libros que nunca han sido prestados
SELECT lb.COD_LIBRO, lb.TITULO 
FROM LIBROS lb
LEFT JOIN PRESTAMO pr ON lb.COD_LIBRO = pr.COD_LIBRO
WHERE pr.COD_LIBRO IS NULL;

-- 19. Préstamos cursados durante el mes calendario anterior
SELECT * 
FROM PRESTAMO 
WHERE FECHA_P >= DATE_SUB(DATE_FORMAT(CURDATE(), '%Y-%m-01'), INTERVAL 1 MONTH)
  AND FECHA_P < DATE_FORMAT(CURDATE(), '%Y-%m-01');

-- 20. Los 3 libros más solicitados en préstamo
SELECT 
    lb.COD_LIBRO,
    lb.TITULO, 
    COUNT(pr.COD_LIBRO) AS VECES_PRESTADO
FROM LIBROS lb
INNER JOIN PRESTAMO pr ON lb.COD_LIBRO = pr.COD_LIBRO
GROUP BY lb.COD_LIBRO, lb.TITULO
ORDER BY VECES_PRESTADO DESC
LIMIT 3;