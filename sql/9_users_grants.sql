USE Sistema_Biblioteca;

-- 1. Crear usuario bibliotecario con contraseña segura
CREATE USER IF NOT EXISTS 'bibliotecario_user'@'localhost' 
IDENTIFIED BY 'BiblioPass_Segura_2026!';

-- 2. Permisos de solo lectura en catálogo de libros, autores y editoriales
GRANT SELECT ON Sistema_Biblioteca.LIBROS TO 'bibliotecario_user'@'localhost';
GRANT SELECT ON Sistema_Biblioteca.AUTORES TO 'bibliotecario_user'@'localhost';
GRANT SELECT ON Sistema_Biblioteca.EDITORIALES TO 'bibliotecario_user'@'localhost';

-- 3. Permisos de lectura y escritura sobre préstamos
GRANT SELECT, INSERT, UPDATE, DELETE ON Sistema_Biblioteca.PRESTAMO TO 'bibliotecario_user'@'localhost';

-- 4. Crear administrador con control total sobre la base de datos
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' 
IDENTIFIED BY 'RootAdmin_SuperKey_2026!';

GRANT ALL PRIVILEGES ON Sistema_Biblioteca.* TO 'admin_user'@'localhost' WITH GRANT OPTION;

-- 5. Revocar permiso DELETE sobre préstamos al bibliotecario
REVOKE DELETE ON Sistema_Biblioteca.PRESTAMO FROM 'bibliotecario_user'@'localhost';

FLUSH PRIVILEGES;