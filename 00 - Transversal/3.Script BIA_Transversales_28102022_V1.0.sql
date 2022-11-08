/****************************************************************
    Script de Creación de Base de Datos - Subsistema Transversales - Última Actualización 08/11/2022.
****************************************************************/

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


/****************************************************************
    CREACIÓN DE TABLAS
****************************************************************/
--Tabla Básica.
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

-- Módulo CAMBIO DE ORGANIGRAMA
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (44, 16, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (45, 16, 'CO');

-- Módulo CARGOS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (46, 17, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (47, 17, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (48, 17, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (49, 17, 'BO');