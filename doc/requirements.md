# Análisis de Requerimientos y Limitaciones del Modelo

## 1. Alcance General
El sistema implementa el modelo de datos para el control bibliotecario universitario. El esquema gestiona la estructura académica e institucional (ciudades, sedes, carreras), los usuarios (alumnos y personal), el catálogo bibliográfico (autores, sellos editoriales, clasificaciones, inventario físico) y las operaciones de circulación (préstamos).

---

## 2. Mapa de Cardinalidad entre Entidades
* **CIUDAD a CAMPUS ($1:N$):** Una ciudad puede albergar múltiples sedes, pero cada campus pertenece a una única jurisdicción.
* **CAMPUS a CARRERAS y FUNCIONARIOS ($1:N$):** Cada sede agrupa distintas carreras y asigna personal administrativo propio.
* **CARRERAS a ESTUDIANTES ($1:N$):** La matrícula de un alumno está vinculada a una carrera principal.
* **AUTORES, EDITORIALES, TIPO y BIBLIOTECA a LIBROS ($1:N$):** Cada obra posee un único autor, pertenece a un sello editorial, tiene una sola clasificación temática y está asignada físicamente a una biblioteca específica.
* **ESTUDIANTES, FUNCIONARIOS y LIBROS a PRESTAMO ($1:N$):** La tabla transaccional vincula una tupla de alumno, empleado y libro
---

## 3. Requerimientos Funcionales Cubiertos
* **Gestión de Entidades y Transacciones:** Altas, modificaciones y bajas en tablas maestras asegurando la integridad referencial.
* **Explotación de Datos (Consultas):** Filtros avanzados por autor, editorial, antigüedad, categorización temática y sede. Cálculos agregados de promedios de edad, rankings de retiro y volúmenes por categoría.
* **Vistas de Información:** Consolidación desnormalizada de transacciones (`VW_PRESTAMOS_DETALLE`) y balance de stock por sede física (`VW_LIBROS_POR_BIBLIOTECA`).
* **Reglas de Negocio Automatizadas:** Disparador para auditar préstamos en tabla histórica y validación preventiva que impide el registro de menores de 17 años.
* **Lógica Encapsulada y Seguridad:** Procedimiento almacenado para controlar y registrar retiros, acompañado por esquemas de permisos diferenciados entre bibliotecario y administrador.

---

## 4. Requerimientos No Funcionales
* **Consistencia e Integridad:** Claves primarias y foráneas explícitas con restricciones de integridad referencial.
* **Rendimiento:** Optimización de búsquedas recurrentes (fechas, años y apellidos) mediante índices secundarios.
* **Seguridad Basada en Roles:** Separación estricta de privilegios (DML limitado y lectura para operación; control total para mantenimiento).
* **Portabilidad y Reproducibilidad:** Scripts SQL modulares y secuenciales compatibles con motores MySQL 8 / MariaDB.

---

## 5. Limitaciones Técnicas y Supuestos de Diseño
* **Desconexión entre BIBLIOTECA y CIUDAD:** En el diagrama original no existe clave foránea que vincule la tabla `BIBLIOTECA` con `CAMPUS` o `CIUDAD`. Por esta razón, la vista de inventario no fuerza una ciudad ficticia y se enfoca en el conteo de obras por recinto.
* **Falta de Localidad en ESTUDIANTES:** La entidad `ESTUDIANTES` solo almacena `DIRECCION`. Para resolver las consultas geográficas (consultas 8 y 15), se asume como criterio técnico la ciudad donde se ubica el campus de su carrera.
* **Restricción de la Clave Compuesta en PRESTAMO:** La clave primaria `(RUT_EST, RUT_FUNC, COD_LIBRO)` imposibilita que un mismo alumno vuelva a retirar el mismo libro con el mismo funcionario. Para un entorno de producción, la solución estándar requeriría un `ID_PRESTAMO` autoincremental.
* **Semántica del campo FECHA_E:** Se modela como la fecha real o pactada de devolución/entrega del ejemplar, marcando `NULL` mientras el préstamo continúe abierto.
* **Criterio de Validación de Edad:** Se tomó como regla estricta el límite numérico menor a 17 años en el disparador, independientemente de la definición legal de mayoría de edad.