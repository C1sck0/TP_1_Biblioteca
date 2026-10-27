USE Sistema_Biblioteca;

-- Tabla receptora de auditoría exigida por la consigna
CREATE TABLE IF NOT EXISTS AUDITORIA_PRESTAMOS (
    ID_AUDITORIA INT AUTO_INCREMENT,
    RUT_EST VARCHAR(20) NOT NULL,
    COD_LIBRO INT NOT NULL,
    FECHA_REGISTRO DATETIME NOT NULL,
    ACCION VARCHAR(50) NOT NULL,
    CONSTRAINT PK_AUDITORIA PRIMARY KEY (ID_AUDITORIA)
);

DELIMITER $$

-- Trigger 1: Auditoría posterior a la inserción de préstamos
CREATE TRIGGER TR_AUDITAR_PRESTAMO
AFTER INSERT ON PRESTAMO
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_PRESTAMOS (RUT_EST, COD_LIBRO, FECHA_REGISTRO, ACCION)
    VALUES (NEW.RUT_EST, NEW.COD_LIBRO, NOW(), 'NUEVO PRÉSTAMO');
END$$

-- Trigger 2A: Validación de edad mínima previa a la inserción
CREATE TRIGGER TR_VALIDAR_EDAD_ESTUDIANTE_INSERT
BEFORE INSERT ON ESTUDIANTES
FOR EACH ROW
BEGIN
    IF NEW.EDAD < 17 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de validación: El estudiante debe ser mayor de edad para registrarse (mínimo 17 años).';
    END IF;
END$$

-- Trigger 2B: Validación de edad mínima previa a la modificación
CREATE TRIGGER TR_VALIDAR_EDAD_ESTUDIANTE_UPDATE
BEFORE UPDATE ON ESTUDIANTES
FOR EACH ROW
BEGIN
    IF NEW.EDAD < 17 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error de validación: La edad del estudiante no puede actualizarse a un valor inferior a 17 años.';
    END IF;
END$$

DELIMITER ;