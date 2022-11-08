--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén Parte 2 - Última Actualizacion 08/11/2022.
--****************************************************************


/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/

CREATE TYPE public."eAgrupacionOrganizacional" AS ENUM (
    'SEC',
    'SUB'
);

ALTER TYPE public."eAgrupacionOrganizacional" OWNER TO postgres;

CREATE TYPE public."eTipoUnidadOrganizacional" AS ENUM (
    'LI',
    'AP',
    'AS'
);

ALTER TYPE public."eTipoUnidadOrganizacional" OWNER TO postgres;




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



CREATE TABLE public."T017Organigramas" (
    "T017IdOrganigrama" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T017nombre" character varying(50) NOT NULL,
    "T017fechaTerminado" timestamp with time zone,
    "T017descripcion" character varying(255) NOT NULL,
    "T017fechaPuestaEnProduccion" timestamp with time zone,
    "T017fechaRetiroDeProduccion" timestamp with time zone,
    "T017justificacionNuevaVersion" character varying(255),
    "T017version" character varying(10) NOT NULL,
    "T017actual" boolean NOT NULL,
    "T017rutaResolucion" character varying(255)
);

ALTER TABLE public."T017Organigramas" OWNER TO postgres;


CREATE TABLE public."T018NivelesOrganigrama" (
    "T018IdNivelOrganigrama" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T018Id_Organigrama" smallint NOT NULL,
    "T018ordenDelNivel" "char" NOT NULL,
    "T018nombre" character varying(50) NOT NULL
);


ALTER TABLE public."T018NivelesOrganigrama" OWNER TO postgres;


CREATE TABLE public."T019UnidadesOrganizacionales" (
    "T019IdUnidadOrganizacional" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T019Id_Organigrama" smallint NOT NULL,
    "T019Id_NivelOrganigrama" smallint NOT NULL,
    "T019nombre" character varying(50) NOT NULL,
    "T019codigo" character varying(10) NOT NULL,
    "T019codTipoUnidad" public."eTipoUnidadOrganizacional" NOT NULL,
    "T019codAgrupacionDocumental" public."eAgrupacionOrganizacional",
    "T019unidadRaiz" boolean NOT NULL,
    "T019Id_UnidadOrgPadre" smallint
);


ALTER TABLE public."T019UnidadesOrganizacionales" OWNER TO postgres;


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


--****************************************************************
-- AGREGAR CONSTRAINTS A LAS TABLAS.
--****************************************************************
-- Agregar  CONSTRAINTS UNIQUE

-- Tabla Estados articulos
ALTER TABLE ONLY public."T051EstadosArticulo"
    ADD CONSTRAINT "T051EstadosArticulo_T051nombre_UNQ" UNIQUE ("T051nombre")
        INCLUDE("T051nombre");

-- Tabla Marcas
ALTER TABLE ONLY public."T052Marcas"
    ADD CONSTRAINT "T052Marcas_T052nombre_UNQ" UNIQUE ("T052nombre")
        INCLUDE("T052nombre");

-- Tabla Porcentajes IVA
ALTER TABLE ONLY public."T053PorcentajesIVA"
    ADD CONSTRAINT "T053PorcentajesIVA_T053porcentaje_UNQ" UNIQUE ("T053porcentaje")
        INCLUDE("T053porcentaje");

-- Tabla Magnitudes
ALTER TABLE ONLY public."T054Magnitudes"
    ADD CONSTRAINT "T054Magnitudes_T054nombre_UNQ" UNIQUE ("T054nombre")
        INCLUDE("T054nombre");

-- Tabla Unidades de medida
ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "T055UnidadesMedida_T055nombre_UNQ" UNIQUE ("T055nombre")
        INCLUDE("T055nombre");

-- Tabla Bodegas
ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "T056Bodegas_T056nombre_UNQ" UNIQUE ("T056nombre")
        INCLUDE("T056nombre");

-- Tabla Articulos
ALTER TABLE ONLY public."T057Artículos"
    ADD CONSTRAINT "T057Artículos_T057docIdentidad_UNQ" UNIQUE ("T057docIdentidad")
        INCLUDE("T057docIdentidad");

-- Tabla Tipos entrada
ALTER TABLE ONLY public."T060TiposEntrada"
    ADD CONSTRAINT "T060TiposEntrada_T060nombre_UNQ" UNIQUE ("T060nombre")
        INCLUDE("T060nombre");

-- Tabla Metodos valoracion activos
ALTER TABLE ONLY public."T061MetodosValoracionActivos"
    ADD CONSTRAINT "T061MetodosValoracionActivos_T061nombre_UNQ" UNIQUE ("T061nombre")
        INCLUDE("T061nombre");

-- Tabla Tipos depreciacion
ALTER TABLE ONLY public."T062TiposDepreciacion"
    ADD CONSTRAINT "T062TiposDepreciacion_T062nombre_UNQ" UNIQUE ("T062nombre")
        INCLUDE("T062nombre");

-- Tabla Hojas de vida
ALTER TABLE ONLY public."T063TiposHojasDeVida"
    ADD CONSTRAINT "T063TiposHojasDeVida_T063nombre_UNQ" UNIQUE ("T063nombre")
        INCLUDE("T063nombre");

-- Tabla Tipos articulos
ALTER TABLE ONLY public."T064TiposArticulo"
    ADD CONSTRAINT "T064TiposArticulo_T064nombre_UNQ" UNIQUE ("T064nombre")
        INCLUDE("T064nombre");



--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************

-- Agregar  CONSTRAINTS FOREIGNS

-- Tabla Niveles Organigrama
ALTER TABLE ONLY public."T018NivelesOrganigrama"
    ADD CONSTRAINT "FK_T018NivelesOrganigrama_T018Id_Organigrama" 
    FOREIGN KEY ("T018Id_Organigrama") 
    REFERENCES public."T017Organigramas"("T017IdOrganigrama") NOT VALID;

-- Tabla Unidades Organizacionales
ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "FK_T019UnidadesOrganizacionales_T019Id_NivelOrganigrama" 
    FOREIGN KEY ("T019Id_NivelOrganigrama")
     REFERENCES public."T018NivelesOrganigrama"("T018IdNivelOrganigrama") NOT VALID;


ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "FK_T019UnidadesOrganizacionales_T019Id_Organigrama" 
    FOREIGN KEY ("T019Id_Organigrama") 
    REFERENCES public."T017Organigramas"("T017IdOrganigrama") NOT VALID;


ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "FK_T019UnidadesOrganizacionales_T019Id_UnidadOrgPadre" 
    FOREIGN KEY ("T019Id_UnidadOrgPadre") 
    REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional") NOT VALID;


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



