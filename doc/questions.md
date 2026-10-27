# Sección 8 — Respuestas teóricas
# Respuestas

**1. ¿Por qué PRESTAMO tiene una clave primaria compuesta?**
El modelo define la clave primaria combinando `RUT_EST`, `RUT_FUNC` y `COD_LIBRO`. Esto obliga a que esa terna exacta sea única y no se repita en la tabla. Si un estudiante quisiera pedir el mismo libro dos veces con el mismo funcionario, el motor no lo permitiría y arrojaría un error de clave duplicada. En la realidad, esto se soluciona usando un ID autoincremental propio para el préstamo (`ID_PRESTAMO`) o agregando la fecha a la clave, además de prestar ejemplares físicos específicos y no el código general del libro.

**2. ¿Qué pasa si borramos una CARRERA con estudiantes asociados?**
La base de datos cancela la operación y lanza un error de restricción de clave foránea (`RESTRICT` / `NO ACTION`). Esto se hace para cuidar la integridad referencial y evitar que queden estudiantes huérfanos asociados a un código de carrera inexistente. Para poder borrarla, primero habría que mover los alumnos a otra carrera o borrarlos.

**3. ¿Por qué AUTORES es una tabla separada?**
Porque un mismo autor puede escribir múltiples libros. Tener la tabla `AUTORES` normaliza el modelo, evita escribir el nombre y apellido en cada libro repetidamente, previene errores de tipeo y facilita cualquier cambio o corrección del autor en un solo lugar.

**4. Relación entre CAMPUS y CIUDAD.**
Es una relación de Uno a Muchos (1:N). En el esquema, cada `CAMPUS` tiene una clave foránea `ID_CIUDAD` que apunta a una única ciudad, mientras que una misma `CIUDAD` puede alojar múltiples sedes o campus universitarios.