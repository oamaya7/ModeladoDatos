/****************************************************************
    Script de Creación de Base de Datos - Subsistema TRANSVERSALES - Última Actualización 03/12/2022 - V1.2.
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
    "T009IdCargo" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
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

ALTER TABLE ONLY public."T017Organigramas"
    ADD CONSTRAINT "PK_T017Organigramas" PRIMARY KEY ("T017IdOrganigrama");

ALTER TABLE ONLY public."T017Organigramas"
    ADD CONSTRAINT "T017Organigramas_T017nombre_UNQ" UNIQUE ("T017nombre")
        INCLUDE("T017nombre");

ALTER TABLE ONLY public."T017Organigramas"
    ADD CONSTRAINT "T017Organigramas_T017version_UNQ" UNIQUE ("T017version")
        INCLUDE("T017version");



CREATE TABLE public."T018NivelesOrganigrama" (
    "T018IdNivelOrganigrama" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T018Id_Organigrama" smallint NOT NULL,
    "T018ordenDelNivel" smallint NOT NULL,
    "T018nombre" character varying(50) NOT NULL
);


ALTER TABLE public."T018NivelesOrganigrama" OWNER TO postgres;

ALTER TABLE ONLY public."T018NivelesOrganigrama"
    ADD CONSTRAINT "PK_T018NivelesOrganigrama" PRIMARY KEY ("T018IdNivelOrganigrama");


ALTER TABLE ONLY public."T018NivelesOrganigrama"
    ADD CONSTRAINT "T018NivelesOrganigrama_T018Id_Organigrama_T018ordenDelNivel_UNQ" UNIQUE ("T018Id_Organigrama","T018ordenDelNivel")
        INCLUDE("T018Id_Organigrama","T018ordenDelNivel");

ALTER TABLE ONLY public."T018NivelesOrganigrama"
    ADD CONSTRAINT "T018NivelesOrganigrama_T018Id_Organigrama_T018nombre_UNQ" UNIQUE ("T018Id_Organigrama","T018nombre")
        INCLUDE("T018Id_Organigrama","T018nombre");


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

ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "PK_T019UnidadesOrganizacionales" PRIMARY KEY ("T019IdUnidadOrganizacional");

ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "T019UnidadesOrganizacionales_T019Id_Organigrama_T019nombre_UNQ" UNIQUE ("T019Id_Organigrama","T019nombre")
        INCLUDE("T019Id_Organigrama","T019nombre");

ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "T019UnidadesOrganizacionales_T019Id_Organigrama_T019codigo_UNQ" UNIQUE ("T019Id_Organigrama","T019codigo")
        INCLUDE("T019Id_Organigrama","T019codigo");


CREATE TABLE public."T020HistoricoUnidadesOrg_Persona" (
    "T020IdHistoUnidad_Persona" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T020Id_Persona" integer NOT NULL,
    "T020Id_UnidadOrganizativa" smallint NOT NULL,
    "T020justificacionDelCambio" character varying(255) NOT NULL,
    "T020fechaInicio" timestamp with time zone NOT NULL,
    "T020fechaFinal" timestamp with time zone NOT NULL
);

ALTER TABLE public."T020HistoricoUnidadesOrg_Persona" OWNER TO postgres;

ALTER TABLE ONLY public."T020HistoricoUnidadesOrg_Persona"
    ADD CONSTRAINT "PK_T020HistoricoUnidadesOrg_Persona" PRIMARY KEY ("T020IdHistoUnidad_Persona");


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
    ADD CONSTRAINT "FK_T019UnidadesOrganizacionales_T019Id_Organigrama" 
    FOREIGN KEY ("T019Id_Organigrama") 
    REFERENCES public."T017Organigramas"("T017IdOrganigrama") NOT VALID;


ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "FK_T019UnidadesOrganizacionales_T019Id_NivelOrganigrama" 
    FOREIGN KEY ("T019Id_NivelOrganigrama")
     REFERENCES public."T018NivelesOrganigrama"("T018IdNivelOrganigrama") NOT VALID;


ALTER TABLE ONLY public."T019UnidadesOrganizacionales"
    ADD CONSTRAINT "FK_T019UnidadesOrganizacionales_T019Id_UnidadOrgPadre" 
    FOREIGN KEY ("T019Id_UnidadOrgPadre") 
    REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional") NOT VALID;


ALTER TABLE ONLY public."T020HistoricoUnidadesOrg_Persona"
    ADD CONSTRAINT "FK_T020HistoricoUnidadesOrg_Persona_T020Id_Persona" 
    FOREIGN KEY ("T020Id_Persona") 
    REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T020HistoricoUnidadesOrg_Persona"
    ADD CONSTRAINT "FK_T020HistoricoUnidadesOrg_Persona_T020Id_UnidadOrganizativa" 
    FOREIGN KEY ("T020Id_UnidadOrganizativa") 
    REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional");


ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Id_Cargo" 
    FOREIGN KEY ("T010Id_Cargo") 
    REFERENCES public."T009Cargos"("T009IdCargo");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Id_UnidadOrganizacionalActual" 
    FOREIGN KEY ("T010Id_UnidadOrganizacionalActual") 
    REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional");


/****************************************************************
    INSERCIÓN DE DATOS INICIALES.
****************************************************************/