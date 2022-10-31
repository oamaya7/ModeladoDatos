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