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
    'DN' -- "Donación"
);

ALTER TYPE public."eCodOrigenRecursosVivero" OWNER TO postgres;

CREATE TYPE public."eCodEtapaLote" AS ENUM (
    'G', -- "Camas de Germinación"
    'P', -- "Producción"
    'D' -- "Distribución"
);

ALTER TYPE public."eCodEtapaLote" OWNER TO postgres;


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


CREATE TABLE public."T153DespachosEntrantes" (
    "T153IdDespachoEntrante" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T153Id_DespachoConsumoAlm" integer NOT NULL,
    "T153fechaIngreso" timestamp with time zone NOT NULL,
    "T153distribucionConfirmada" boolean NOT NULL,
    "T153fechaConfirmacionDistribucion" timestamp with time zone,
    "T153observacionDistribucion" character varying(255),
    "T153Id_PersonaDistribuye" integer
);

ALTER TABLE public."T153DespachosEntrantes" OWNER TO postgres;

ALTER TABLE ONLY public."T153DespachosEntrantes"
    ADD CONSTRAINT "PK_T153DespachosEntrantes" PRIMARY KEY ("T153IdDespachoEntrante");


CREATE TABLE public."T154Items_DespachoEntrante" (
    "T154IdItem_DespachoEntrante" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T154Id_DespachoEntrante" integer NOT NULL,
    "T154Id_Bien" integer NOT NULL,
    "T154Id_EntradaAlmDelBien" integer NOT NULL,
    "T154fechaIngreso" timestamp with time zone,
    "T154cantidadEntrante" integer,
    "T154cantidadDistribuida" integer,
    "T154observacion" character varying(50)
);

ALTER TABLE public."T154Items_DespachoEntrante" OWNER TO postgres;

ALTER TABLE ONLY public."T154Items_DespachoEntrante"
    ADD CONSTRAINT "PK_T154Items_DespachoEntrante" PRIMARY KEY ("T154IdItem_DespachoEntrante");

ALTER TABLE ONLY public."T154Items_DespachoEntrante"
    ADD CONSTRAINT "T154Items_DespachoEntrante_Key_UNQ" UNIQUE ("T154Id_DespachoEntrante", "T154Id_Bien", "T154Id_EntradaAlmDelBien")
        INCLUDE("T154Id_DespachoEntrante", "T154Id_Bien", "T154Id_EntradaAlmDelBien");


CREATE TABLE public."T155Distribuciones_Item_DespachoEntrante" (
    "T155IdDistribucion_ItemsDespachoEntrante" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T155IdItem_DespachoEntrante" integer NOT NULL,
    "T155Id_Vivero" smallint NOT NULL,
    "T155cantidadAsignada" integer NOT NULL,
    "T155etapaAIngresar" public."eCodEtapaLote",
    "T155fechaDistribucion" timestamp with time zone

);

ALTER TABLE public."T155Distribuciones_Item_DespachoEntrante" OWNER TO postgres;

ALTER TABLE ONLY public."T155Distribuciones_Item_DespachoEntrante"
    ADD CONSTRAINT "PK_T155Distribuciones_Item_DespachoEntrante" PRIMARY KEY ("T155IdDistribucion_ItemsDespachoEntrante");

ALTER TABLE ONLY public."T155Distribuciones_Item_DespachoEntrante"
    ADD CONSTRAINT "T155Distribuciones_Item_DespachoEntrante_Key_UNQ" UNIQUE ("T155IdItem_DespachoEntrante", "T155Id_Vivero")
        INCLUDE("T155IdItem_DespachoEntrante", "T155Id_Vivero");


CREATE TABLE public."T156InventarioViveros" (
    "T156IdInventarioViveros" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T156Id_Vivero" smallint NOT NULL,
    "T156Id_Bien" integer NOT NULL,
    "T156agnoLote" smallint,
    "T156nroLote" integer,
    "T156codEtapaLote" public."eCodEtapaLote",
    "T156esProduccionPropiaLote" boolean,
    "T156cod_TipoEntradaLote" smallint,
    "T156nroEntradaAlmLote" integer,
    "T156fechaIngresoAlLote" timestamp with time zone,
    "T156ultAlturaLote" smallint,
    "T156fechaUltAlturaLote" timestamp with time zone,
    "T156porcCuarentenaLoteGerminacion" smallint,
    "T156Id_SiembraLoteGerminacion" integer,
    "T156siembraLoteCerrada" boolean,
    "T156cantidadEntrante" integer,
    "T156cantidadBodegas" integer,
    "T156consumosInternos" smallint,
    "T156trasladosLoteProduccionADistribucion" integer,
    "T156salidas" integer,
    "T156cantidadLoteEnCuarentena"
);

ALTER TABLE public."T156InventarioViveros" OWNER TO postgres;

ALTER TABLE ONLY public."T156InventarioViveros"
    ADD CONSTRAINT "PK_T156InventarioViveros_ItemsDespachoEntrante" PRIMARY KEY ("T156IdInventarioViveros");

ALTER TABLE ONLY public."T156InventarioViveros"
    ADD CONSTRAINT "T156InventarioViveros_ItemsDespachoEntrante_Key_UNQ" UNIQUE ("T156Id_Vivero", "T156Id_Bien", "T156agnoLote", "T156nroLote", "T156codEtapaLote")
        INCLUDE("T156Id_Vivero", "T156Id_Bien", "T156agnoLote", "T156nroLote", "T156codEtapaLote");

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

-- T153DespachosEntrantes

ALTER TABLE ONLY public."T153DespachosEntrantes"
    ADD CONSTRAINT "FK_T153DespachosEntrantes_T153Id_DespConsAlm" FOREIGN KEY ("T153Id_DespachoConsumoAlm") REFERENCES public."T083DespachosConsumo"("T083IdDespachoConsumo");

ALTER TABLE ONLY public."T153DespachosEntrantes"
    ADD CONSTRAINT "FK_T153DespachosEntrantes_T153Id_PersEntr" FOREIGN KEY ("T153Id_PersonaDistribuye") REFERENCES public."T010Personas"("T010IdPersona");

-- T154Items_DespachoEntrante

ALTER TABLE ONLY public."T154Items_DespachoEntrante"
    ADD CONSTRAINT "FK_T154Items_DespachoEntrante_T154Id_DespEnt" FOREIGN KEY ("T154Id_DespachoEntrante") REFERENCES public."T153DespachosEntrantes"("T153IdDespachoEntrante");

ALTER TABLE ONLY public."T154Items_DespachoEntrante"
    ADD CONSTRAINT "FK_T154Items_DespachoEntrante_T154Id_Bien" FOREIGN KEY ("T154Id_Bien") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T154Items_DespachoEntrante"
    ADD CONSTRAINT "FK_T154Items_DespachoEntrante_T154Id_EntAlmBien" FOREIGN KEY ("T154Id_EntradaAlmDelBien") REFERENCES public."T063EntradasAlmacen"("T063IdEntradaAlmacen");

-- T155Distribuciones_Item_DespachoEntrante

ALTER TABLE ONLY public."T155Distribuciones_Item_DespachoEntrante"
    ADD CONSTRAINT "FK1_T155Distribuciones_Item_DespachoEntrante" FOREIGN KEY ("T155IdItem_DespachoEntrante") REFERENCES public."T154Items_DespachoEntrante"("T154IdItem_DespachoEntrante");

ALTER TABLE ONLY public."T155Distribuciones_Item_DespachoEntrante"
    ADD CONSTRAINT "FK2_T155Distribuciones_Item_DespachoEntrante" FOREIGN KEY ("T155Id_Vivero") REFERENCES public."T150Viveros"("T150IdVivero");

-- T156InventarioViveros
ALTER TABLE ONLY public."T156InventarioViveros"
    ADD CONSTRAINT "FK1_T156InventarioViveros" FOREIGN KEY ("T156Id_Bien") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T156InventarioViveros"
    ADD CONSTRAINT "FK2_T156InventarioViveros" FOREIGN KEY ("T156cod_TipoEntradaLote") REFERENCES public."T061TiposEntrada"("T061CodTipoEntrada");

-- ALTER TABLE ONLY public."T156InventarioViveros"
--     ADD CONSTRAINT "FK3_T156InventarioViveros" FOREIGN KEY ("T156Id_SiembraLoteGerminacion") REFERENCES public."TXXXLotesSiembraMaterialVegetal"("TXXXIdLotesSiembraMaterialVegetal");

/****************************************************************
 INSERCIÓN DE DATOS INICIALES.
****************************************************************/
