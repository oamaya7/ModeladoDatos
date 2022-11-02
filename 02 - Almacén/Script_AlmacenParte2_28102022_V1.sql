--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén Parte 2 - Última Actualizacion 28/10/2022.
--****************************************************************

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


-- PERMISOS POR MODULO
-- Módulo ORGANIGRAMAS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (41, 15, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (42, 15, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (43, 15, 'CO');

-- Módulo CAMBIO DE ORGANIGRAMA
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (44, 16, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (45, 16, 'CO');