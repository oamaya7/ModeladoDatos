/****************************************************************
 Script de Creación de Base de Datos - Subsistema Gestión Documental - Última Actualizacion XX/12/2022 - V1.0.
****************************************************************/


/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/

CREATE TYPE public."eCodTipoVivero" AS ENUM (
    'MV', -- "Mega Vivero"
    'VS' -- "Vivero Satélite"
);

ALTER TYPE public."eCodTipoVivero" OWNER TO postgres;

CREATE TYPE public."eCodOrigenRecursosVivero" AS ENUM (
    'RP', -- "Recursos Propios"
    'CP', -- "Compensación"
    'DN' -- Donación
);

ALTER TYPE public."eCodOrigenRecursosVivero" OWNER TO postgres;


/****************************************************************
 CREACIÓN DE TABLAS.
****************************************************************/




--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************



/****************************************************************
 INSERCIÓN DE DATOS INICIALES.
****************************************************************/
