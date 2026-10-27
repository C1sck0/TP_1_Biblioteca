USE Sistema_Biblioteca;

DELIMITER $$

CREATE PROCEDURE SP_REGISTRAR_PRESTAMO (
    IN p_RUT_EST VARCHAR(20),
    IN p_COD_LIBRO INT,
    IN p_RUT_FUNC VARCHAR(20),
    IN p_FECHA_P DATE
)
BEGIN
    DECLARE v_prestado INT DEFAULT 0;

    -- Validar si el ejemplar ya cuenta con un préstamo sin devolver
    SELECT COUNT(*) INTO v_prestado
    FROM PRESTAMO
    WHERE COD_LIBRO = p_COD_LIBRO 
      AND FECHA_E IS NULL;

    IF v_prestado > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Operación denegada: El ejemplar indicado ya posee un préstamo activo sin devolver.';
    ELSE
        -- Registro del préstamo con fecha de devolución estipulada a 7 días
        INSERT INTO PRESTAMO (RUT_EST, RUT_FUNC, COD_LIBRO, FECHA_P, FECHA_E)
        VALUES (p_RUT_EST, p_RUT_FUNC, p_COD_LIBRO, p_FECHA_P, DATE_ADD(p_FECHA_P, INTERVAL 7 DAY));

        SELECT 'Préstamo registrado correctamente' AS RESULTADO;
    END IF;
END$$

DELIMITER ;