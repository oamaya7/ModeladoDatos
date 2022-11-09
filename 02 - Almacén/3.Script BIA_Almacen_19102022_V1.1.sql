--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén - Última Actualizacion 21/10/2022.
--****************************************************************

/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/

CREATE TYPE public."eTipoVehiculo" AS ENUM (
    'C',
    'A',
	'M'
);

ALTER TYPE public."eTipoVehiculo" OWNER TO postgres;


CREATE TYPE public."eTipoCombustible" AS ENUM (
    'GAS',
    'DIE',
	'GNV',
	'ELE'
);

ALTER TYPE public."eTipoCombustible" OWNER TO postgres;


CREATE TYPE public."eTipoMantenimiento" AS ENUM (
    'P',
    'C'
);

ALTER TYPE public."eTipoMantenimiento" OWNER TO postgres;


--****************************************************************
-- CREACIÓN DE TABLAS.
--****************************************************************
CREATE TABLE public."T051EstadosArticulo" (
    "T051Cod_Estado" character(1) NOT NULL,
    "T051nombre" character varying(20) NOT NULL
);

ALTER TABLE public."T051EstadosArticulo" OWNER TO postgres;

ALTER TABLE ONLY public."T051EstadosArticulo"
    ADD CONSTRAINT "PK_T051EstadosArticulo" PRIMARY KEY ("T051Cod_Estado");

ALTER TABLE ONLY public."T051EstadosArticulo"
    ADD CONSTRAINT "T051EstadosArticulo_T051nombre_UNQ" UNIQUE ("T051nombre")
        INCLUDE("T051nombre");


CREATE TABLE public."T052Marcas" (
    "T052IdMarca" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T052nombre" character varying(50) NOT NULL,
    "T052activo" boolean NOT NULL DEFAULT TRUE,
    "T052itemYaUsado" boolean NOT NULL DEFAULT FALSE  
);

ALTER TABLE public."T052Marcas" OWNER TO postgres;

ALTER TABLE ONLY public."T052Marcas"
    ADD CONSTRAINT "PK_T052Marcas" PRIMARY KEY ("T052IdMarca");

ALTER TABLE ONLY public."T052Marcas"
    ADD CONSTRAINT "T052Marcas_T052nombre_UNQ" UNIQUE ("T052nombre")
        INCLUDE("T052nombre");

CREATE TABLE public."T053PorcentajesIVA" (
    "T053IdPorcentajeIVA" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T053porcentaje" numeric(5,2) NOT NULL,
    "T053observacion" character varying(255),
    "T053registroPrecargado" boolean NOT NULL,
    "T053activo" boolean NOT NULL DEFAULT TRUE,
    "T053itemYaUsado" boolean NOT NULL DEFAULT FALSE    
);

ALTER TABLE public."T053PorcentajesIVA" OWNER TO postgres;

ALTER TABLE ONLY public."T053PorcentajesIVA"
    ADD CONSTRAINT "PK_T053PorcentajesIVA" PRIMARY KEY ("T053IdPorcentajeIVA");

ALTER TABLE ONLY public."T053PorcentajesIVA"
    ADD CONSTRAINT "T053PorcentajesIVA_T053porcentaje_UNQ" UNIQUE ("T053porcentaje")
        INCLUDE("T053porcentaje");


CREATE TABLE public."T054Magnitudes" (
    "T054IdMagnitud" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T054nombre" character varying(50) NOT NULL
);

ALTER TABLE public."T054Magnitudes" OWNER TO postgres;

ALTER TABLE ONLY public."T054Magnitudes"
    ADD CONSTRAINT "PK_T054Magnitudes" PRIMARY KEY ("T054IdMagnitud");

ALTER TABLE ONLY public."T054Magnitudes"
    ADD CONSTRAINT "T054Magnitudes_T054nombre_UNQ" UNIQUE ("T054nombre")
        INCLUDE("T054nombre");

CREATE TABLE public."T055UnidadesMedida" (
    "T055IdUnidadMedida" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T055nombre" character varying(50) NOT NULL,
    "T055abreviatura" character(5) NOT NULL,
    "T055Id_Magnitud" smallint NOT NULL,
    "T055registroPrecargado" boolean NOT NULL,
    "T055activo" boolean NOT NULL DEFAULT TRUE,
    "T055itemYaUsado" boolean NOT NULL DEFAULT FALSE    
);

ALTER TABLE public."T055UnidadesMedida" OWNER TO postgres;

ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "PK_T055UnidadesMedida" PRIMARY KEY ("T055IdUnidadMedida");

ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "T055UnidadesMedida_T055nombre_UNQ" UNIQUE ("T055nombre")
        INCLUDE("T055nombre");


CREATE TABLE public."T056Bodegas" (
    "T056IdBodega" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T056nombre" character varying(255),
    "T056Cod_Municipio" character(5) NOT NULL,
    "T056direccion" character varying(255) NOT NULL,
    "T056Id_Responsable" integer NOT NULL,
    "T056esPrincipal" boolean NOT NULL,
    "T056activo" boolean NOT NULL DEFAULT TRUE,
    "T056itemYaUsado" boolean NOT NULL DEFAULT FALSE    
);

ALTER TABLE public."T056Bodegas" OWNER TO postgres;

ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "PK_T056Bodegas" PRIMARY KEY ("T056IdBodega");

ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "T056Bodegas_T056nombre_UNQ" UNIQUE ("T056nombre")
        INCLUDE("T056nombre");

ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "T055UnidadesMedida_T055Id_Magnitud_T055abreviatura_UNQ" UNIQUE ("T055Id_Magnitud", "T055abreviatura")
        INCLUDE("T055Id_Magnitud", "T055abreviatura");

CREATE TABLE public."T064TiposActivoHV" (
    "T064CodTipoActivoHV" character(1) NOT NULL,
    "T064nombre" character varying(50) NOT NULL   
);

ALTER TABLE public."T064TiposActivoHV" OWNER TO postgres;

ALTER TABLE ONLY public."T064TiposActivoHV"
    ADD CONSTRAINT "PK_T064TiposActivoHV" PRIMARY KEY ("T064CodTipoActivoHV");


CREATE TABLE public."T065HojaDeVidaComputadores" (
    "T065IdHojaDeVida" integer NOT NULL,
    "T065Id_Articulo" integer NOT NULL,
	"T065sistemaOperativo" character varying(40),
	"T065suiteOfimatica" character varying(40),
	"T065antivirus" character varying(40),
	"T065otrasAplicaciones" character varying(255),
	"T065color" character varying(20),
	"T065tipoDeEquipo" character varying(20),
	"T065tipoAlmacenamiento" character varying(30),
	"T065procesador" character varying(20),
	"T065memoriaRAM" character varying(20),
    "T065observacionesAdicionales" character varying(255),
	"T065rutaImagenFoto" character varying(255)
);

ALTER TABLE public."T065HojaDeVidaComputadores" OWNER TO postgres;

ALTER TABLE ONLY public."T065HojaDeVidaComputadores"
    ADD CONSTRAINT "PK_T065HojaDeVidaComputadores" PRIMARY KEY ("T065IdHojaDeVida");

CREATE TABLE public."T066HojaDeVidaVehiculos" (
    "T066IdHojaDeVida" integer NOT NULL,
    "T066Id_Articulo" integer NOT NULL,
	"T066codTipoVehiculo" public."eTipoVehiculo",
	"T066capacidadPasajeros" smallint,
	"T066color" character varying(20),
	"T066linea" character varying(20),
	"T066tipoCombustible" public."eTipoCombustible",
	"T066esArrendado" boolean,
	"T066fechaAdquisicion" date,
	"T066fechaVigenciaGarantia" date,
	"T066numeroMotor" character varying(40),
	"T066numeroChasis" character varying(40),
	"T066cilindraje" smallint,
	"T066transmision" character varying(20),
	"T066dimensionLlantas" smallint,
	"T066Id_Proveedor" integer,
	"T066capacidadExtintor" smallint,
	"T066tarjetaOperacion" character varying(20),
	"T066observacionesAdicionales" character varying(255),
	"T066rutaImagenFoto" character varying(255)
);

ALTER TABLE public."T066HojaDeVidaVehiculos" OWNER TO postgres;

ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "PK_T066HojaDeVidaVehiculos" PRIMARY KEY ("T066IdHojaDeVida");
	

CREATE TABLE public."T067HojaDeVidaOtrosActivos" (
    "T067IdHojaDeVida" integer NOT NULL,
    "T067Id_Articulo" integer NOT NULL,
	"T067caracteristicas" text,
	"T067especificacionesTecnicas" text,
	"T067observacionesAdicionales" character varying(255),
	"T067rutaImagenFoto" character varying(255)
);

ALTER TABLE public."T067HojaDeVidaOtrosActivos" OWNER TO postgres;

ALTER TABLE ONLY public."T067HojaDeVidaOtrosActivos"
    ADD CONSTRAINT "PK_T067HojaDeVidaOtrosActivos" PRIMARY KEY ("T067IdHojaDeVida");

CREATE TABLE public."T068DocumentosVehiculo" (
    "T068IdDocumentosVehiculo" integer NOT NULL,
    "T068Id_Articulo" integer NOT NULL,
	"T068Id_TipoDocumento" smallint NOT NULL, 
	"T068nroDocumento" character varying(50),
	"T068fechaExpedicion" date,
	"T068fechaExpiracion" date,
	"T068Id_EmpresaProveedora" smallint
);

ALTER TABLE public."T068DocumentosVehiculo" OWNER TO postgres;

ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "PK_T068DocumentosVehiculo" PRIMARY KEY ("T068IdDocumentosVehiculo");

CREATE TABLE public."T069ProgramacionMantenimiento" (
    "T069IdProgramacionMtto" integer NOT NULL,
    "T069codTipoMantenimiento" public."eTipoMantenimiento" NOT NULL,
	"T069fechaGenerada" date NOT NULL, 
	"T069fechaProgramada" date NOT NULL,
	"T069mantenimientoARealizar" text NOT NULL,
	"T069observaciones" character varying(255) NOT NULL,
	"T069Id_PersonaSolicita" integer,
	"T069fechaSolicitud" date,
	"T069fechaAnulacion" timestamp with time zone,
	"T069justificacionAnulacion" character varying(255),
	"T069Id_PersonaAnula" integer
);

ALTER TABLE public."T069ProgramacionMantenimiento" OWNER TO postgres;

ALTER TABLE ONLY public."T069ProgramacionMantenimiento"
    ADD CONSTRAINT "PK_T069ProgramacionMantenimiento" PRIMARY KEY ("T069IdProgramacionMtto");

CREATE TABLE public."T070RegistroMantenimiento" (
    "T070IdRegistroMtto" integer NOT NULL,
    "T070Id_Articulo" public."eTipoMantenimiento" NOT NULL,
	"T070codTipoMantenimiento" public."eTipoMantenimiento" NOT NULL, 
	"T070accionesRealizadas" text NOT NULL,
	"T070diasEmpleados" smallint,
	"T070observaciones" character varying(255),
	"T070Cod_EstadoFinal" character(1),
	"T070Id_ProgramacionMtto" integer,
	"T070Id_PersonaRealiza" integer NOT NULL,
	"T070Id_PersonaDiligencia" integer NOT NULL,
	"T070valorMantenimiento" integer,
	"T070contratoMantenimiento" character varying(20)
);

ALTER TABLE public."T070RegistroMantenimiento" OWNER TO postgres;

ALTER TABLE ONLY public."T070RegistroMantenimiento"
    ADD CONSTRAINT "PK_T070RegistroMantenimiento" PRIMARY KEY ("T070IdRegistroMtto");

--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************
ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "FK_T055UnidadesMedida_T055Id_Magnitud" FOREIGN KEY ("T055Id_Magnitud") REFERENCES public."T054Magnitudes"("T054IdMagnitud");

ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "FK_T056Bodegas_T056Cod_Municipio" FOREIGN KEY ("T056Cod_Municipio") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "FK_T056Bodegas_T056Id_Responsable" FOREIGN KEY ("T056Id_Responsable") REFERENCES public."T010Personas"("T010IdPersona");



--****************************************************************
-- INSERCIÓN DE DATOS INICIALES.
--****************************************************************
-- ESTADOS.
INSERT INTO public."T051EstadosArticulo" ("T051Cod_Estado", "T051nombre") VALUES ('O', 'Óptimo');
INSERT INTO public."T051EstadosArticulo" ("T051Cod_Estado", "T051nombre") VALUES ('D', 'Defectuoso');
INSERT INTO public."T051EstadosArticulo" ("T051Cod_Estado", "T051nombre") VALUES ('A', 'Averiado');


-- PORCENTAJES DE IVA.
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (1, 0.00, 'Bienes exentos del IVA', true);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (2, 5.00, 'Tarifa del 5 %', true);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (3, 16.00, 'Tarifa general IVA antes del año 2017, IVA del 16 %', true);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (4, 19.00, 'Tarifa general del IVA artículo 468, IVA del 19 %', true);


-- MAGNITUDES DE UNIDADES DE MEDIDA.
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (1, 'Longitud');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (2, 'Volumen');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (3, 'Cantidad');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (4, 'Peso');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (5, 'Superficie');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (6, 'Temperatura');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (7, 'Tiempo');


-- UNIDADES DE MEDIDA.
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (1, 'metro', 'm', 1, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (2, 'kilómetro', 'km', 1, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (3, 'centímetro', 'cm', 1, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (4, 'litro', 'lt', 2, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (5, 'galón', 'gal', 2, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (6, 'centilitro', 'cl', 2, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (7, 'kilogramo', 'kg', 4, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (8, 'libra', 'lb', 4, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (9, 'gramo', 'g', 4, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (10, 'metro cuadrado', 'm2', 5, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (11, 'hectárea', 'ha', 5, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (12, 'unidad', 'und', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (13, 'caja', 'caja', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (14, 'decena', 'dec', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (15, 'paquete', 'paq', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (16, 'lote', 'lote', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (17, 'docena', 'doc', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (18, 'millar', 'mill', 3, true);

-- CLASES DE TERCERO
INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (4, 'Aseguradora');


-- PERMISOS
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('AN', 'Anular');

-- MÓDULOS
-- Marcas.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (11, 'Marcas', 'Permite administrar la información básica de las Marcas de artículos activos fijos','ALMA');
-- Bodegas
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (12, 'Bodegas', 'Permite administrar las bodegas del Almacén creadas en el sistema','ALMA');
-- Porcentajes IVA.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (13, 'Porcentajes de IVA', 'Permite administrar la información básica de los porcentajes de IVA que manejará el sistema','ALMA');
-- Unidades de Medida.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (14, 'Unidades de Medida', 'Permite administrar la información básica de las unidades de medida que manejará el sistema','ALMA');
-- Hoja de vida de computadores.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (15, 'Hoja de Vida Computadores', 'Permite administrar la información de las hojas de vidas de los computadores','ALMA');
-- Hoja de vida de vehículos.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (16, 'Hoja de Vida Vehículos', 'Permite administrar la información de las hojas de vidas de los vehículos','ALMA');
-- Hoja de vida de vehículos.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (17, 'Hoja de Vida Vehículos', 'Permite administrar la información de las hojas de vidas de los vehículos','ALMA');
-- Programación de Mantenimiento de Computadores
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (18, 'Programación de Mantenimiento de Computadores', 'Permite administrar la información de las programaciones de mantenimiento de computadores','ALMA');
-- Programación de Mantenimiento de Vehículos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (19, 'Programación de Mantenimiento de Vehículos', 'Permite administrar la información de las programaciones de mantenimiento de vehículos','ALMA');
-- Programación de Mantenimiento de Otros activos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (20, 'Programación de Mantenimiento de Otros activos', 'Permite administrar la información de las programaciones de mantenimiento de otros activos','ALMA');
-- Ejecución de Mantenimiento de computadores
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (21, 'Ejecución de Mantenimiento de Computadores', 'Permite administrar la información de las ejecuciones de mantenimiento de computadores','ALMA');
-- Ejecución de Mantenimiento de vehículos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (22, 'Ejecución de Mantenimiento de Vehículos', 'Permite administrar la información de las ejecuciones de mantenimiento de vehículos','ALMA');
-- Ejecución de Mantenimiento de otros activos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (23, 'Ejecución de Mantenimiento de Otros activos', 'Permite administrar la información de las ejecuciones de mantenimiento de otros activos','ALMA');



-- PERMISOS POR MODULO
-- Módulo MARCAS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (25, 11, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (26, 11, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (27, 11, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (28, 11, 'BO');
-- Módulo BODEGAS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (29, 12, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (30, 12, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (31, 12, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (32, 12, 'BO');
-- Módulo PORCENTAJES IVA
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (33, 13, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (34, 13, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (35, 13, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (36, 13, 'BO');
-- Módulo UNIDADES DE MEDIDA
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (37, 14, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (38, 14, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (39, 14, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (40, 14, 'BO');
-- Módulo Hoja de vida de computadores
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (41, 15, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (42, 15, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (43, 15, 'BO');
-- Módulo Hoja de vida de vehículos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (44, 16, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (45, 16, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (46, 16, 'BO');
-- Módulo Hoja de vida de otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (47, 17, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (48, 17, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (49, 17, 'BO');
-- Módulo de Programación de Mantenimiento de Computadores
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (50, 18, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (51, 18, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (52, 18, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (53, 18, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (54, 18, 'AN');
-- Módulo de Programación de Mantenimiento de Vehículos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (55, 19, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (56, 19, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (57, 19, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (58, 19, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (59, 19, 'AN');
-- Módulo de Programación de Mantenimiento de Otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (60, 20, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (61, 20, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (62, 20, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (63, 20, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (64, 20, 'AN');
-- Módulo de Ejecución de Mantenimiento de Computadores
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (65, 21, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (66, 21, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (67, 21, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (68, 21, 'CO');
-- Módulo de Ejecución de Mantenimiento de Vehículos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (69, 22, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (70, 22, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (71, 22, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (72, 22, 'CO');
-- Módulo de Ejecución de Mantenimiento de Otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (73, 23, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (74, 23, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (75, 23, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (76, 23, 'CO');
