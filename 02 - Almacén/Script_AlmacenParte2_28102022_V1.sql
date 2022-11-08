--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén Parte 2 - Última Actualizacion 28/10/2022.
--****************************************************************

--****************************************************************
-- CREACIÓN DE TABLAS
--****************************************************************

CREATE TABLE public."T009Cargos" (
    "T009IdCargo" smallint NOT NULL,
    "T009nombre" character varying(50) NOT NULL,
    "T009activo" boolean NOT NULL,
    "T009itemYaUsado" boolean NOT NULL
);

ALTER TABLE public."T009Cargos" OWNER TO postgres;

ALTER TABLE ONLY public."T009Cargos"
    ADD CONSTRAINT "PK_T009Cargos" PRIMARY KEY ("T009IdCargo");

ALTER TABLE ONLY public."T009Cargos"
    ADD CONSTRAINT "T009Cargos_T009nombre_UNQ" UNIQUE ("T009nombre")
        INCLUDE("T009nombre");

--****************************************************************
-- MODIFICACIÓN DE TABLAS.
--****************************************************************


ALTER TABLE IF EXISTS public."T005EstadoCivil"
    ADD COLUMN "T005activo" boolean NOT NULL DEFAULT TRUE,
    ADD COLUMN "T005itemYaUsado" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE IF EXISTS public."T006TiposDocumentoID"
    ADD COLUMN "T006activo" boolean NOT NULL DEFAULT TRUE,
    ADD COLUMN "T006itemYaUsado" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE IF EXISTS public."T052Marcas"
    ADD COLUMN "T052activo" boolean NOT NULL DEFAULT TRUE,
    ADD COLUMN "T052itemYaUsado" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE IF EXISTS public."T053PorcentajesIVA"
    ADD COLUMN "T053activo" boolean NOT NULL DEFAULT TRUE,
    ADD COLUMN "T053itemYaUsado" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE IF EXISTS public."T055UnidadesMedida"
    ADD COLUMN "T055activo" boolean NOT NULL DEFAULT TRUE,
    ADD COLUMN "T055itemYaUsado" boolean NOT NULL DEFAULT FALSE;

ALTER TABLE IF EXISTS public."T056Bodegas"
    ADD COLUMN "T056activo" boolean NOT NULL DEFAULT TRUE,
    ADD COLUMN "T056itemYaUsado" boolean NOT NULL DEFAULT FALSE;


-- MODULOS
-- Módulo para administrar los ORGANIGRAMAS del sistema, implica organigrama, sus niveles y sus unidades organizacionales.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (15, 'Organigramas', 'Permite administrar los organigramas del sistema','TRSV');

-- Módulo para cambiar de ORGANIGRAMA vigente de la entidad en el sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (16, 'Cambio de Organigrama Actual', 'Permite adoptar un nuevo organigrama de la entidad en el sistema','TRSV');

-- Módulo para administrar los CARGOS del sistema. 
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (17, 'Cargos', 'Permite administrar los cargos disponibles en el sistema','TRSV');


-- PERMISOS POR MODULO
-- Módulo ORGANIGRAMAS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (41, 15, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (42, 15, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (43, 15, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (46, 17, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (47, 17, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (48, 17, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (49, 17, 'BO');

-- Módulo CAMBIO DE ORGANIGRAMA
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (44, 16, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (45, 16, 'CO');

/****************************************************************
    INSERCIÓN DE DATOS INICIALES.
****************************************************************/

-- CLASES DE TERCERO
INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (4, 'Conductor');
INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (5, 'Conductor Externo');

