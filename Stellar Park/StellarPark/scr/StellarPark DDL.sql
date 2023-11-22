DROP TABLE IF EXISTS tab_reserva;
DROP TABLE IF EXISTS tab_puestos;
DROP TABLE IF EXISTS tab_coment;
DROP TABLE IF EXISTS tab_clien;
DROP TABLE IF EXISTS tab_parq;
DROP TABLE IF EXISTS tab_vehi;
DROP TABLE IF EXISTS tab_precioxhora;
DROP TABLE IF EXISTS tab_mensualidad;
DROP TABLE IF EXISTS tab_gerente;
DROP TABLE IF EXISTS tab_login;
DROP TABLE IF EXISTS tab_rol;
DROP TABLE IF EXISTS tab_borrados;
DROP TABLE IF EXISTS tab_personas;


-- Tabla para definir roles

CREATE TABLE tab_rol(
    id_rol              SMALLINT NOT NULL,
    nombre_rol          VARCHAR NOT NULL,
    mensaje             VARCHAR,
    crud                BOOLEAN,
    ver_info_cliente    BOOLEAN,
    gestionar_info_parq BOOLEAN,
    actualizar_puestos  BOOLEAN,
PRIMARY KEY (id_rol)
);


-- Tabla para el registro del usuario

CREATE TABLE tab_login (
    correo              VARCHAR NOT NULL,
    contra              VARCHAR NOT NULL,
    id_rol              SMALLINT NOT NULL,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta     VARCHAR,
    fecha_inserta       TIMESTAMP,
PRIMARY KEY(correo),
FOREIGN KEY (id_rol) REFERENCES tab_rol(id_rol)
);

-- Tabla para guardar info de un humano


CREATE TABLE tab_personas(
    DNI                 VARCHAR NOT NULL,
    telefono            VARCHAR NOT NULL,
    nombre               VARCHAR NOT NULL,
    apellido             VARCHAR NOT NULL,
	fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta     VARCHAR,
    fecha_inserta       TIMESTAMP,
PRIMARY KEY (DNI)

);
-- Tabla para el registro de vehiculo

CREATE TABLE tab_vehi (
    placa               VARCHAR NOT NULL,
    modelo              VARCHAR,
    marca               VARCHAR NOT NULL,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta     VARCHAR,
    fecha_inserta       TIMESTAMP,
PRIMARY KEY (placa)
);

--Tabla de precio x vehiculo

CREATE TABLE tab_precioxhora(
    id_precioxhora      INT,
    precio_carro        INT,
    precio_moto         INT,
    precio_bici         INT,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta      VARCHAR,
    fecha_inserta        TIMESTAMP,
PRIMARY KEY(id_precioxhora)
);


--Tabla para precio * mes

CREATE TABLE tab_mensualidad(
    id_mensualidad      INT,
    mens_carro          INT,
    mens_moto           INT,
    mens_bici           INT,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta     VARCHAR,
    fecha_inserta       TIMESTAMP,
PRIMARY KEY (id_mensualidad)
);

-- Tabla Para Cliente

CREATE TABLE tab_clien (
    DNI                  VARCHAR NOT NULL,
    placa                VARCHAR NOT NULL,
    correo               VARCHAR,
    fecha_update         TIMESTAMP,
    usuario_update       VARCHAR,
    usuario_inserta      VARCHAR,
    fecha_inserta        TIMESTAMP,
PRIMARY KEY (DNI),
FOREIGN KEY (DNI) REFERENCES tab_personas(DNI),
FOREIGN KEY (placa) REFERENCES tab_vehi(placa),
FOREIGN KEY (correo) REFERENCES tab_login(correo)
);

-- Tabla para Gerentes

CREATE TABLE tab_gerente (
    DNI                     VARCHAR     NOT NULL,
    correo                  VARCHAR,
    fecha_update            TIMESTAMP,
    usuario_update          VARCHAR,
    usuario_inserta         VARCHAR,
    fecha_inserta           TIMESTAMP,
PRIMARY KEY (DNI),
FOREIGN KEY (DNI) REFERENCES tab_personas(DNI),
FOREIGN KEY (correo) REFERENCES tab_login (correo)
);

-- Tabla para Parqueaderos

CREATE TABLE tab_parq (
    NIT                     VARCHAR NOT NULL,
    Nombre                  VARCHAR,
    Direccion               VARCHAR NOT NULL,
    HorarioAtencion         VARCHAR NOT NULL,
    indicador_moto          BOOLEAN,
    camion_carga            BOOLEAN,
    CapacidadTotal          INT     NOT NULL,
    puestos_disponibles     INT,
    id_precioxhora          INT,
    id_mensualidad          INT,
	DNI			            VARCHAR,
    fecha_update            TIMESTAMP,
    usuario_update          VARCHAR,
    usuario_inserta         VARCHAR,
    fecha_inserta           TIMESTAMP,    
PRIMARY KEY (NIT),  
FOREIGN KEY (id_precioxhora) REFERENCES tab_precioxhora(id_precioxhora),  
FOREIGN KEY (id_mensualidad) REFERENCES tab_mensualidad(id_mensualidad),
FOREIGN KEY (DNI) REFERENCES tab_gerente(DNI)
);

-- Tabla para Reservas

CREATE TABLE tab_reserva (
    id_reserva          INT       NOT NULL,
    fecha_inicio        TIMESTAMP NOT NULL,
    fecha_fin           TIMESTAMP NOT NULL,
    DNI                 VARCHAR   NOT NULL,
    NIT                 VARCHAR       NOT NULL,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta     VARCHAR,
    fecha_inserta       TIMESTAMP,    
PRIMARY KEY (id_reserva ),
FOREIGN KEY (DNI) REFERENCES tab_clien(DNI),
FOREIGN KEY (NIT) REFERENCES tab_parq(NIT)
);

-- Tabla para Puestos en Tiempo Real

CREATE TABLE tab_puestos (
    id_puesto           INT     NOT NULL,
    NIT                 VARCHAR,
    puesto_disponible   BOOLEAN,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta      VARCHAR,
    fecha_inserta        TIMESTAMP,
PRIMARY KEY(NIT,id_puesto),
FOREIGN KEY (NIT) REFERENCES tab_parq(NIT)
);


-- Tabla para Comentarios
CREATE TABLE tab_coment (
    id_comentario       INT,
    Comentario          TEXT,
    Calificacion        INT,
    DNI                 VARCHAR ,
    NIT                 VARCHAR,
    fecha_update        TIMESTAMP,
    usuario_update      VARCHAR,
    usuario_inserta      VARCHAR,
    fecha_inserta        TIMESTAMP,
PRIMARY KEY (id_comentario),
FOREIGN KEY (DNI) REFERENCES tab_clien(DNI),
FOREIGN KEY (NIT) REFERENCES tab_parq(NIT)
);

-- Tabla de Auditoría para tab_login

CREATE TABLE tab_borrados
(
    id_consec                   INTEGER         NOT NULL, -- Codígo de la tabla Borrados (Llave Primaria)
    nombre_tabla                VARCHAR         NOT NULL, --
    usuario_inserta              VARCHAR         NOT NULL    DEFAULT CURRENT_USER,
    fecha_inserta                TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_consec)
);




-- Función de auditoría adaptada
CREATE OR REPLACE FUNCTION fun_act_tabla() RETURNS "trigger" AS
$$
   
    DECLARE id_consec tab_borrados.id_consec%TYPE;
    BEGIN
        IF TG_OP = 'INSERT' THEN
           NEW.usuario_inserta = CURRENT_USER;
           NEW.fecha_inserta = CURRENT_TIMESTAMP;
           RETURN NEW;
        END IF;
        IF TG_OP = 'UPDATE' THEN
           NEW.Usuario_Update = CURRENT_USER;
           NEW.Fecha_Update = CURRENT_TIMESTAMP;
           RETURN NEW;
        END IF;
        IF TG_OP = 'DELETE' THEN
            SELECT MAX(a.id_consec) INTO id_consec FROM tab_borrados a;
            IF id_consec IS NULL THEN
                id_consec = 1;
            ELSE
                id_consec = id_consec + 1;
            END IF;
            INSERT INTO tab_borrados VALUES(id_consec,TG_RELNAME,CURRENT_USER,CURRENT_TIMESTAMP);
            RETURN OLD;  
        END IF;
    END;
$$
LANGUAGE PLPGSQL;


-- Desencadenadores para tablas específicas

-- Ejemplo para la tabla tab_ciudades
CREATE OR REPLACE TRIGGER tri_del_tabla_login AFTER DELETE ON tab_login
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_login BEFORE INSERT OR UPDATE ON tab_login
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_personas  AFTER DELETE ON tab_personas
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_personas BEFORE INSERT OR UPDATE ON tab_personas
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_vehi AFTER DELETE ON tab_vehi
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_vehi BEFORE INSERT OR UPDATE ON tab_vehi
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_precioxhora AFTER DELETE ON tab_precioxhora
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_precioxhora BEFORE INSERT OR UPDATE ON tab_precioxhora
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_mensualida AFTER DELETE ON tab_mensualidad
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_mensualida BEFORE INSERT OR UPDATE ON tab_mensualidad
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_clien AFTER DELETE ON tab_clien
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_clien BEFORE INSERT OR UPDATE ON tab_clien
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_gerente AFTER DELETE ON tab_gerente
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_gerente BEFORE INSERT OR UPDATE ON tab_gerente
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_parq AFTER DELETE ON tab_parq
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_parq BEFORE INSERT OR UPDATE ON tab_parq
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_reserva AFTER DELETE ON tab_reserva
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_reserva BEFORE INSERT OR UPDATE ON tab_reserva
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_timereal AFTER DELETE ON tab_puestos
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_timereal BEFORE INSERT OR UPDATE ON tab_puestos
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_coment AFTER DELETE ON tab_coment
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_coment BEFORE INSERT OR UPDATE ON tab_coment
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

-- Repite el proceso para otras tablas según sea necesario









-- DROP TABLE IF EXISTS tab_admin;
-- Tabla para Administrador
-- CREATE TABLE tab_admin (
--     id_admi         int primary key,
--     Nombre          VARCHAR NOT NULL
-- );


-- DROP TABLE IF EXISTS tab_prhr;
-- --Tabla para precio x hora
-- CREATE TABLE tab_prhr(
-- id_prhr INT PRIMARY KEY,
-- cant_horas INT,
-- total_precio_hora DECIMAL,
-- id_prvh INT,
-- FOREIGN KEY (id_prvh) REFERENCES tab_precioxhora(id_prvh)
-- );
