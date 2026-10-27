# Trabajo Práctico 1 — Base de Datos (Sistema Biblioteca)

Entorno de ejecución: MySQL 8.x / MariaDB (vía phpMyAdmin o cliente CLI).

## Estructura del Proyecto
* `teoria.md`: Respuestas analíticas a la Sección 8 del trabajo práctico.
* `1_create.sql`: Creación de la base de datos `Sistema_Biblioteca` y definición de tablas con claves primarias y foráneas.
* `2_insert.sql`: Carga inicial de datos consistente para asegurar resultados en todas las consultas.
* `3_queries.sql`: Resolución de las 20 consultas SELECT requeridas.
* `4_alterations.sql`: Operaciones DML solicitadas (inserción, actualización y borrado).
* `5_indexes.sql`: Índices opcionales para optimización de tiempos de respuesta.
* `6_views.sql`: Definición de vistas de detalle y balances de inventario.
* `7_triggers.sql`: Tabla y disparadores de auditoría y validación de reglas de negocio.
* `8_procedures.sql`: Procedimiento almacenado para control y alta de préstamos.
* `9_users_grants.sql`: Administración de usuarios locales y asignación de privilegios.

## Secuencia Recomendada de Ejecución
Para garantizar la integridad referencial y evitar conflictos en la auditoría, ejecutar los archivos en el siguiente orden:

1. `1_create.sql`
2. `2_insert.sql`
3. `5_indexes.sql` (opcional)
4. `6_views.sql`
5. `7_triggers.sql`
6. `8_procedures.sql`
7. `3_queries.sql` (ejecutar antes del DML para evaluar el catálogo en su estado base)
8. `4_alterations.sql` (aplica modificaciones destructivas y actualizaciones de prueba)
9. `9_users_grants.sql` (correr desde una cuenta con privilegios administrativos como `root`)

> **Nota:** La carga de disparadores (`7_triggers.sql`) se realiza posterior al insertado de datos base (`2_insert.sql`) para que los registros iniciales no disparen inserciones automáticas en la tabla de auditoría.

## Verificación del Procedimiento Almacenado
Antes de correr `4_alterations.sql` (el cual elimina el libro con código 207), se puede testear la lógica de validación y auditoría con la siguiente llamada:

```sql
CALL SP_REGISTRAR_PRESTAMO('23.123.456-6', 207, '11.222.333-K', CURDATE());
SELECT * FROM AUDITORIA_PRESTAMOS;