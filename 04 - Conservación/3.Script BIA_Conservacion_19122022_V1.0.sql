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


CREATE TABLE public."T151HistorialAperturaViveros" (
    "T151IdHistorialAperturaVivero" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T151Id_Vivero" smallint NOT NULL,
    "T151fechaAperturaAnterior" timestamp with time zone NOT NULL,
    "T151fechaCierreCorrespondiente" timestamp with time zone NOT NULL,
    "T151Id_PersonaAperturaAnterior" integer NOT NULL,
    "T151Id_PersonaCierreAnterior" integer NOT NULL,
    "T151justificacionAperturaAnterior" character varying(255) NOT NULL,
    "T151justificacionCierreCorrespondiente" character varying(255) NOT NULL
);

ALTER TABLE public."T151HistorialAperturaViveros" OWNER TO postgres;

ALTER TABLE ONLY public."T151HistorialAperturaViveros"
    ADD CONSTRAINT "PK_T151HistorialAperturaViveros" PRIMARY KEY ("T151IdHistorialAperturaVivero");


CREATE TABLE public."T152HistorialCuarentenaViveros" (
    "T152IdHistorialCuarentenaVivero" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T152Id_Vivero" smallint NOT NULL,
    "T152fechaInicioCuarentena" timestamp with time zone NOT NULL,
    "T152Id_PersonaIniciaCuarentena" integer NOT NULL,
    "T152justificacionInicioCuarentena" character varying(255) NOT NULL,
    "T152fechaFinCuarentena" timestamp with time zone NOT NULL,
    "T152Id_PersonaFinalizaCuarentena" integer NOT NULL,
    "T152justificacionFinCuarentena" character varying(255)
);

ALTER TABLE public."T152HistorialCuarentenaViveros" OWNER TO postgres;

ALTER TABLE ONLY public."T152HistorialCuarentenaViveros"
    ADD CONSTRAINT "PK_T152HistorialCuarentenaViveros" PRIMARY KEY ("T152IdHistorialCuarentenaVivero");

--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************

-- T150Viveros

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "FK_T150Viveros_T150Cod_Municipio" FOREIGN KEY ("T150Cod_Municipio") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "FK_T150Viveros_T150Id_VivActual" FOREIGN KEY ("T150Id_ViveristaActual") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "FK_T150Viveros_T150Id_PersCrea" FOREIGN KEY ("T150Id_PersonaCrea") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "FK_T150Viveros_T150Id_PersAbre" FOREIGN KEY ("T150Id_PersonaAbre") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "FK_T150Viveros_T150Id_PersCierra" FOREIGN KEY ("T150Id_PersonaCierra") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T150Viveros"
    ADD CONSTRAINT "FK_T150Viveros_T150Id_PersCuarntna" FOREIGN KEY ("T150Id_PersonaCuarentena") REFERENCES public."T010Personas"("T010IdPersona");

-- T151HistorialAperturaViveros

ALTER TABLE ONLY public."T151HistorialAperturaViveros"
    ADD CONSTRAINT "FK_T151HistorialAperturaViveros_T151Id_Viv" FOREIGN KEY ("T151Id_Vivero") REFERENCES public."T150Viveros"("T150IdVivero");

ALTER TABLE ONLY public."T151HistorialAperturaViveros"
    ADD CONSTRAINT "FK_T151HistorialAperturaViveros_T151Id_PersApAnt" FOREIGN KEY ("T151Id_PersonaAperturaAnterior") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T151HistorialAperturaViveros"
    ADD CONSTRAINT "FK_T151HistorialAperturaViveros_T151Id_CierrCorrs" FOREIGN KEY ("T151Id_PersonaCierreCorrespondiente") REFERENCES public."T010Personas"("T010IdPersona");

-- T152HistorialCuarentenaViveros

ALTER TABLE ONLY public."T152HistorialCuarentenaViveros"
    ADD CONSTRAINT "FK_T152HistorialCuarentenaViveros_T152Id_Viv" FOREIGN KEY ("T152Id_Vivero") REFERENCES public."T150Viveros"("T150IdVivero");

ALTER TABLE ONLY public."T152HistorialCuarentenaViveros"
    ADD CONSTRAINT "FK_T152HistorialCuarentenaViveros_T152Id_PersIniCua" FOREIGN KEY ("T152Id_PersonaIniciaCuarentena") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T152HistorialCuarentenaViveros"
    ADD CONSTRAINT "FK_T152HistorialCuarentenaViveros_T152Id_PersFinCua" FOREIGN KEY ("T152Id_PersonaFinalizaCuarentena") REFERENCES public."T010Personas"("T010IdPersona");

/****************************************************************
 INSERCIÓN DE DATOS INICIALES.
****************************************************************/
