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

CREATE TABLE public."T150Viveros" (
    "T150IdVivero" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T150nombre" character varying(30) NOT NULL,
    "T150Cod_Municipio" character(5) NOT NULL,
    "T150direccion" character varying(255) NOT NULL,
    "T150areaMt2" integer NOT NULL,
    "T150areaPropagacionMt2" integer NOT NULL,
    "T150tieneAreaProduccion" boolean NOT NULL,
    "T150tieneAreaPrepSustrato" boolean NOT NULL,
    "T150tieneAreaEmbolsado" boolean NOT NULL,
    "T150codTipoVivero" public."eCodTipoVivero" NOT NULL,
    "T150Id_ViveristaActual" integer,
    "T150fechaInicioViveristaActual" timestamp with time zone,
    "T150codOrigenRecursosVivero" public."eCodOrigenRecursosVivero" NOT NULL,
    "T150fechaCreacion" timestamp with time zone NOT NULL,
    "T150Id_PersonaCrea" integer NOT NULL,
    "T150enFuncionamiento" boolean,
    "T150fechaUltimaApertura" timestamp with time zone,
    "T150Id_PersonaAbre" integer,
    "T150justificacionApertura" character varying(255),
    "T150fechaCierreActual" timestamp with time zone,
    "T150Id_PersonaCierra" integer,
    "T150justificacionCierre" character varying(255),
    "T150viveroEnCuarentena" boolean,
    "T150fechaInicioCuarentena" timestamp with time zone,
    "T150Id_PersonaCuarentena" integer,
    "T150justificacionCuarentena" character varying(255),
    "T150rutaArchivoCreacion" character varying(255) NOT NULL,
    "T150activo" boolean NOT NULL,
    "T150itemYaUsado" boolean NOT NULL

);

ALTER TABLE public."T150Viveros" OWNER TO postgres;

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "PK_T150IdVivero" PRIMARY KEY ("T150IdVivero");

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "T150Viveros_T150nombre_UNQ" UNIQUE ("T150nombre")
        INCLUDE("T150nombre");



--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************



/****************************************************************
 INSERCIÓN DE DATOS INICIALES.
****************************************************************/
