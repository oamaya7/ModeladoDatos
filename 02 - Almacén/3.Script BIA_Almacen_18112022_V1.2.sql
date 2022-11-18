--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén - Última Actualizacion 18/10/2022 - V1.2
--****************************************************************

/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/




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
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado", "T053activo", "T053itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (1, 0.00, 'Bienes exentos del IVA', true, true, false);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado", "T053activo", "T053itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (2, 5.00, 'Tarifa del 5 %', true, true, false);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado", "T053activo", "T053itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (3, 16.00, 'Tarifa general IVA antes del año 2017, IVA del 16 %', true, true, false);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observacion", "T053registroPrecargado", "T053activo", "T053itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (4, 19.00, 'Tarifa general del IVA artículo 468, IVA del 19 %', true, true, false);

-- MAGNITUDES DE UNIDADES DE MEDIDA.
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (1, 'Longitud');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (2, 'Volumen');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (3, 'Cantidad');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (4, 'Peso');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (5, 'Superficie');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (6, 'Temperatura');
INSERT INTO public."T054Magnitudes" ("T054IdMagnitud", "T054nombre") OVERRIDING SYSTEM VALUE VALUES (7, 'Tiempo');

-- UNIDADES DE MEDIDA.
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (1, 'metro', 'm', 1, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (2, 'kilómetro', 'km', 1, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (3, 'centímetro', 'cm', 1, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (4, 'litro', 'lt', 2, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (5, 'galón', 'gal', 2, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (6, 'centilitro', 'cl', 2, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (7, 'kilogramo', 'kg', 4, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (8, 'libra', 'lb', 4, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (9, 'gramo', 'g', 4, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (10, 'metro cuadrado', 'm2', 5, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (11, 'hectárea', 'ha', 5, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (12, 'unidad', 'und', 3, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (13, 'caja', 'caja', 3, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (14, 'decena', 'dec', 3, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (15, 'paquete', 'paq', 3, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (16, 'lote', 'lote', 3, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (17, 'docena', 'doc', 3, true, true, false);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado", "T055activo", "T055itemYaUsado") OVERRIDING SYSTEM VALUE VALUES (18, 'millar', 'mill', 3, true, true, false);



/************************************************************************************
    SECCIÓN OLIVER - HOJAS DE VIDA / MANTENIMIENTOS
*************************************************************************************/

/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/

CREATE TYPE public."eTipoVehiculo" AS ENUM (
    'C',
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

CREATE TYPE public."eTipoDocVehicular" AS ENUM (
    'SOAT',
    'RTM',
    'STR'
);

ALTER TYPE public."eTipoDocVehicular" OWNER TO postgres;
--****************************************************************
-- CREACIÓN DE TABLAS.
--****************************************************************

CREATE TABLE public."T065HojaDeVidaComputadores" (
    "T065IdHojaDeVida" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T065Id_Articulo" integer NOT NULL,
	"T065sistemaOperativo" character varying(40),
	"T065suiteOfimatica" character varying(40),
	"T065antivirus" character varying(40),
	"T065otrasAplicaciones" character varying(255),
	"T065color" character varying(20),
	"T065tipoDeEquipo" character varying(20),
	"T065tipoAlmacenamiento" character varying(30),
	"T065procesador" character varying(20),
	"T065memoriaRAM" smallint,
	"T065observacionesAdicionales" character varying(255),
	"T065rutaImagenFoto" character varying(255)
);

ALTER TABLE public."T065HojaDeVidaComputadores" OWNER TO postgres;

ALTER TABLE ONLY public."T065HojaDeVidaComputadores"
    ADD CONSTRAINT "PK_T065HojaDeVidaComputadores" PRIMARY KEY ("T065IdHojaDeVida");
    
ALTER TABLE ONLY public."T065HojaDeVidaComputadores"
    ADD CONSTRAINT "T065HojaDeVidaComputadores_Id_Art_UNQ" UNIQUE ("T065Id_Articulo")
        INCLUDE("T065Id_Articulo"); 
	

CREATE TABLE public."T066HojaDeVidaVehiculos" (
    "T066IdHojaDeVida" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T066Id_Articulo" integer,
    "T066Id_VehiculoArrendado" integer,
	"T066codTipoVehiculo" public."eTipoVehiculo",
    "T066tienePlaton" boolean,
	"T066capacidadPasajeros" smallint,
	"T066color" character varying(20),
	"T066linea" character varying(20),
	"T066tipoCombustible" public."eTipoCombustible",
	"T066esArrendado" boolean,
    "T066ultimoKilometraje" integer,
    "T066fechaUltimoKilometraje" date,
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
	"T066esAgendable" boolean,
	"T066enCirculacion" boolean,
	"T066fechaCirculacion" date,
    "T066rutaImagenFoto" character varying(255)
);

ALTER TABLE public."T066HojaDeVidaVehiculos" OWNER TO postgres;

ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "PK_T066HojaDeVidaVehiculos" PRIMARY KEY ("T066IdHojaDeVida");

ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "T066HojaDeVidaVehiculos_Id_Art_Id_VehArr_UNQ" UNIQUE ("T066Id_Articulo", "T066Id_VehiculoArrendado")
        INCLUDE("T066Id_Articulo", "T066Id_VehiculoArrendado"); 
	
	
CREATE TABLE public."T067HojaDeVidaOtrosActivos" (
    "T067IdHojaDeVida" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T067Id_Articulo" integer NOT NULL,
	"T067caracteristicasFisicas" text,
	"T067especificacionesTecnicas" text,
	"T067observacionesAdicionales" character varying(255),
	"T067rutaImagenFoto" character varying(255)
);

ALTER TABLE public."T067HojaDeVidaOtrosActivos" OWNER TO postgres;

ALTER TABLE ONLY public."T067HojaDeVidaOtrosActivos"
    ADD CONSTRAINT "PK_T067HojaDeVidaOtrosActivos" PRIMARY KEY ("T067IdHojaDeVida");
    
ALTER TABLE ONLY public."T067HojaDeVidaOtrosActivos"
    ADD CONSTRAINT "T067HojaDeVidaOtrosActivos_Id_Art_UNQ" UNIQUE ("T067Id_Articulo")
        INCLUDE("T067Id_Articulo"); 
        
        
CREATE TABLE public."T068DocumentosVehiculo" (
    "T068IdDocumentosVehiculo" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T068Id_Articulo" integer NOT NULL,
	"T068codTipoDocumento" public."eTipoDocVehicular" NOT NULL,
	"T068nroDocumento" character varying(20) NOT NULL,
	"T068fechaInicioVigencia" date NOT NULL,
	"T068fechaExpiracion" date NOT NULL,
	"T068Id_EmpresaProveedora" integer NOT NULL
);

ALTER TABLE public."T068DocumentosVehiculo" OWNER TO postgres;

ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "PK_T068DocumentosVehiculo" PRIMARY KEY ("T068IdDocumentosVehiculo");

ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "T068DocumentosVehiculo_Cod_TipoDoc_nroDoc_UNQ" UNIQUE ("T068Id_Articulo", "T068codTipoDocumento", "T068nroDocumento")
        INCLUDE("T068Id_Articulo", "T068codTipoDocumento", "T068nroDocumento"); 


CREATE TABLE public."T069ProgramacionMantenimientos" (
    "T069IdProgramacionMtto" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T069Id_Articulo" integer NOT NULL,
    "T069codTipoMantenimiento" public."eTipoMantenimiento" NOT NULL,
	"T069fechaGenerada" date NOT NULL, 
	"T069fechaProgramada" date NOT NULL,
	"T069motivoMantenimiento" character varying(255) NOT NULL,
	"T069observaciones" character varying(255),
	"T069Id_PersonaSolicita" integer,
	"T069fechaSolicitud" date,
	"T069fechaAnulacion" timestamp with time zone,
	"T069justificacionAnulacion" character varying(255),
	"T069Id_PersonaAnula" integer,
    "T069ejecutado" boolean NOT NULL
);

ALTER TABLE public."T069ProgramacionMantenimientos" OWNER TO postgres;

ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "PK_T069ProgramacionMantenimientos" PRIMARY KEY ("T069IdProgramacionMtto");


CREATE TABLE public."T070RegistroMantenimientos" (
    "T070IdRegistroMtto" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T070Id_Articulo" integer NOT NULL,
    "T070fechaRealizado" timestamp with time zone NOT NULL,
	"T070codTipoMantenimiento" public."eTipoMantenimiento" NOT NULL, 
	"T070accionesRealizadas" text NOT NULL,
	"T070diasEmpleados" smallint NOT NULL,
	"T070observaciones" character varying(255),
    "T070codEstadoAnterior" character(1),
    "T070fechaEstadoAnterior" timestamp with time zone,
	"T070Cod_EstadoFinal" character(1) NOT NULL,
	"T070Id_ProgramacionMtto" integer,
    "T070valorMantenimiento" numeric(12,2),
	"T070contratoMantenimiento" character varying(20),
	"T070Id_PersonaRealiza" integer NOT NULL,
	"T070Id_PersonaDiligencia" integer NOT NULL,
    "T070rutaDocumentoSoporte" character varying(255)
);

ALTER TABLE public."T070RegistroMantenimientos" OWNER TO postgres;

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "PK_T070RegistroMantenimientos" PRIMARY KEY ("T070IdRegistroMtto");

	
-- CLASES DE TERCERO
INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (4, 'Proveedor');
INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (5, 'Aseguradora');

-- PERMISOS
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('AN', 'Anular');

-- MODULOS
-- Hoja de vida de computadores.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (18, 'Hoja de Vida Computadores', 'Permite administrar la información de las hojas de vidas de los computadores','ALMA');
-- Hoja de vida de vehículos.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (19, 'Hoja de Vida Vehículos', 'Permite administrar la información de las hojas de vidas de los vehículos','ALMA');
-- Hoja de vida de otros activos.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (20, 'Hoja de Vida Otros Activos', 'Permite administrar la información de las hojas de vidas de otros activos','ALMA');
-- Programación de Mantenimiento de Computadores
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (21, 'Programación de Mantenimiento de Computadores', 'Permite administrar la información de las programaciones de mantenimiento de computadores','ALMA');
-- Programación de Mantenimiento de Vehículos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (22, 'Programación de Mantenimiento de Vehículos', 'Permite administrar la información de las programaciones de mantenimiento de vehículos','ALMA');
-- Programación de Mantenimiento de Otros activos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (23, 'Programación de Mantenimiento de Otros activos', 'Permite administrar la información de las programaciones de mantenimiento de otros activos','ALMA');
-- Ejecución de Mantenimiento de computadores
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (24, 'Ejecución de Mantenimiento de Computadores', 'Permite administrar la información de las ejecuciones de mantenimiento de computadores','ALMA');
-- Ejecución de Mantenimiento de vehículos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (25, 'Ejecución de Mantenimiento de Vehículos', 'Permite administrar la información de las ejecuciones de mantenimiento de vehículos','ALMA');
-- Ejecución de Mantenimiento de otros activos
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (26, 'Ejecución de Mantenimiento de Otros activos', 'Permite administrar la información de las ejecuciones de mantenimiento de otros activos','ALMA');

-- PERMISOS POR MÓDULO
-- Módulo Hoja de vida de computadores
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (50, 18, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (51, 18, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (52, 18, 'BO');
-- Módulo Hoja de vida de vehículos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (53, 19, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (54, 19, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (55, 19, 'BO');
-- Módulo Hoja de vida de otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (56, 20, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (57, 20, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (58, 20, 'BO');
-- Módulo de Programación de Mantenimiento de Computadores
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (59, 21, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (60, 21, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (61, 21, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (62, 21, 'AN');
-- Módulo de Programación de Mantenimiento de Vehículos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (63, 22, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (64, 22, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (65, 22, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (66, 22, 'AN');
-- Módulo de Programación de Mantenimiento de Otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (67, 23, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (68, 23, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (69, 23, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (70, 23, 'AN');
-- Módulo de Ejecución de Mantenimiento de Computadores
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (71, 24, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (72, 24, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (73, 24, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (74, 24, 'CO');
-- Módulo de Ejecución de Mantenimiento de Vehículo
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (75, 25, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (76, 25, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (77, 25, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (78, 25, 'CO');
-- Módulo de Ejecución de Mantenimiento de Otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (79, 26, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (80, 26, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (81, 26, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (82, 26, 'CO');


--****************************************************************
-- FOREIGN KEYS
--****************************************************************
ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "FK_T066HojaDeVidaVehiculos_T066Id_Proveedor" FOREIGN KEY ("T066Id_Proveedor") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "FK_T068DocumentosVehiculo_T068Id_EmpresaProveedora" FOREIGN KEY ("T068Id_EmpresaProveedora") REFERENCES public."T010Personas"("T010IdPersona");
	
ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "FK_T069ProgramacionMantenimientos_T069Id_PersonaSolicita" FOREIGN KEY ("T069Id_PersonaSolicita") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "FK_T069ProgramacionMantenimientos_T069Id_PersonaAnula" FOREIGN KEY ("T069Id_PersonaAnula") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_ProgramacionMtto" FOREIGN KEY ("T070Id_ProgramacionMtto") REFERENCES public."T069ProgramacionMantenimientos"("T069IdProgramacionMtto");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_PersonaRealiza" FOREIGN KEY ("T070Id_PersonaRealiza") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_PersonaDiligencia" FOREIGN KEY ("T070Id_PersonaDiligencia") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Cod_EstadoFinal" FOREIGN KEY ("T070Cod_EstadoFinal") REFERENCES public."T051EstadosArticulo"("T051Cod_Estado");

@@ Esta FK falla debido a que aún no está creada la tabla de Vehículos arrendados.   Una vez esté en firme la tabla, revisar nuevamente esta constraint, por ahora dejarla aquí tal como está.
ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "FK_T066HojaDeVidaVehiculos_T066Id_VehiculoArrendado" FOREIGN KEY ("T066Id_VehiculoArrendado") REFERENCES public."T071VehiculosArrendados"("T071IdVehiculoArrendado");

@@ Revisar esta FK cuando esté en firme la tabla Artículos.
ALTER TABLE ONLY public."T065HojaDeVidaComputadores"
    ADD CONSTRAINT "FK_T065HojaDeVidaComputadores_T065Id_Articulo" FOREIGN KEY ("T065Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");

@@ Revisar esta FK cuando esté en firme la tabla Artículos.
ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "FK_T066HojaDeVidaVehiculos_T066Id_Articulo" FOREIGN KEY ("T066Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");	    

@@ Revisar esta FK cuando esté en firme la tabla Artículos.
ALTER TABLE ONLY public."T067HojaDeVidaOtrosActivos"
    ADD CONSTRAINT "FK_T067HojaDeVidaOtrosActivos_T067Id_Articulo" FOREIGN KEY ("T067Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");

@@ Revisar esta FK cuando esté en firme la tabla Artículos.
ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "FK_T068DocumentosVehiculo_T068Id_Articulo" FOREIGN KEY ("T068Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");

@@ Revisar esta FK cuando esté en firme la tabla Artículos.
ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "FK_T069ProgramacionMantenimientos_T069Id_Articulo" FOREIGN KEY ("T069Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");

@@ Revisar esta FK cuando esté en firme la tabla Artículos.
ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_Articulo" FOREIGN KEY ("T070Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");

/************************************************************************************
    SECCIÓN  ARTICULOS
*************************************************************************************/

/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/
CREATE TYPE public."eTipoArticulo" AS ENUM (
    'A',
    'C'
);

ALTER TYPE public."eTipoArticulo" OWNER TO postgres;

CREATE TYPE public."eTipoActivo" AS ENUM (
    'C',
    'V',
    'O'
);

ALTER TYPE public."eTipoActivo" OWNER TO postgres;

--****************************************************************
-- CREACIÓN DE TABLAS.
--****************************************************************

CREATE TABLE public."T057Articulos" (
    "T057IdArticulo" integer NOT NULL,
    "T057codigo" character varying(15) NOT NULL,
	"T057consecActivoPorArticulo" smallint, 
	"T057codTipoArticulo" public."eTipoArticulo" NOT NULL,
	"T057nombre" character varying(100) NOT NULL,
	"T057nombreCientifico" character varying(255),
    "T057descripcion" character varying(255),
	"T057Cod_TipoActivo" public."eTipoActivo",
	"T057docIdentificadorNro" character varying(30),
	"T057Id_Marca" smallint,
	"T057Id_UnidadMedida" smallint NOT NULL,
	"T057Id_PorcentajeIVA" smallint NOT NULL,
	"T057Cod_MetodoValoracion" smallint,
	"T057Cod_TipoDepreciacion" smallint,
	"T057cantidadVidaUtil" smallint,
    "T057Id_UnidadMedidaVidaUtil" smallint,
	"T057valorResidual" integer,
	"T057stockMinimo" integer,
	"T057stockMaximo" integer,
	"T057solicitablePorVivero" boolean NOT NULL,
	"T057tieneHojaDeVida" boolean,
	"T057nroNivelJerarquico" smallint NOT NULL,
	"T057Id_ArticuloPadre" integer,
	"T057esItemFinal" boolean
);

ALTER TABLE public."T057Articulos" OWNER TO postgres;

ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "PK_T057Articulos" PRIMARY KEY ("T057IdArticulo");

ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "T057Articulos_T057codigo_T057consecActivoPorArticulo_UNQ" UNIQUE ("T057codigo", "T057consecActivoPorArticulo")
        INCLUDE("T057codigo", "T057consecActivoPorArticulo"); 
        
CREATE TABLE public."T058MetodosValoracionArticulos" (
    "T058CodMetodoValoracion" smallint NOT NULL,
    "T058nombre" character varying(50) NOT NULL,
    "T058descripcion" character varying(255) NOT NULL   
);

ALTER TABLE public."T058MetodosValoracionArticulos" OWNER TO postgres;

ALTER TABLE ONLY public."T058MetodosValoracionArticulos"
    ADD CONSTRAINT "PK_T058MetodosValoracionArticulos" PRIMARY KEY ("T058CodMetodoValoracion");

ALTER TABLE ONLY public."T058MetodosValoracionArticulos"
    ADD CONSTRAINT "T058MetodosValoracionArticulos_T058nombre_UNQ" UNIQUE ("T058nombre")
        INCLUDE("T058nombre");
        
CREATE TABLE public."T059TiposDepreciacionActivos" (
    "T059CodTipoDepreciacion" smallint NOT NULL,
    "T059nombre" character varying(50) NOT NULL
);

ALTER TABLE public."T059TiposDepreciacionActivos" OWNER TO postgres;

ALTER TABLE ONLY public."T059TiposDepreciacionActivos"
    ADD CONSTRAINT "PK_T059TiposDepreciacionActivos" PRIMARY KEY ("T059CodTipoDepreciacion");

ALTER TABLE ONLY public."T059TiposDepreciacionActivos"
    ADD CONSTRAINT "T059TiposDepreciacionActivos_T059nombre_UNQ" UNIQUE ("T059nombre")
        INCLUDE("T059nombre");  
        
CREATE TABLE public."T060TiposActivo" (
    "T060CodTipoActivo" public."eTipoActivo" NOT NULL,
    "T060nombre" character varying(15) NOT NULL   
);

ALTER TABLE public."T060TiposActivo" OWNER TO postgres;

ALTER TABLE ONLY public."T060TiposActivo"
    ADD CONSTRAINT "PK_T060TiposActivo" PRIMARY KEY ("T060CodTipoActivo"); 

ALTER TABLE ONLY public."T060TiposActivo"
    ADD CONSTRAINT "T060TiposActivo_T060nombre_UNQ" UNIQUE ("T060nombre")
        INCLUDE("T060nombre");  
    
CREATE TABLE public."T061TiposEntrada" (
    "T061CodTipoEntrada" smallint NOT NULL,
    "T061nombre" character varying(15) NOT NULL,
    "T061descripcion" character varying(255),
    "T061tituloPersonaOrigen" character varying(20) NOT NULL 
);

ALTER TABLE public."T061TiposEntrada" OWNER TO postgres;

ALTER TABLE ONLY public."T061TiposEntrada"
    ADD CONSTRAINT "PK_T061TiposEntrada" PRIMARY KEY ("T061CodTipoEntrada");

ALTER TABLE ONLY public."T061TiposEntrada"
    ADD CONSTRAINT "T061TiposEntrada_T061nombre_UNQ" UNIQUE ("T061nombre")
        INCLUDE("T061nombre");
        
CREATE TABLE public."T062Inventario" (
    "T062IdInventario" integer NOT NULL,
    "T062Id_Articulo" integer NOT NULL,
    "T062Id_Bodega" smallint NOT NULL,
    "T062Cod_TipoEntrada" smallint,
    "T062fechaIngreso" date,
    "T062Id_PersonaOrigen" integer,
    "T062numeroDocOrigen" character varying(30),
    "T062destinoBaja" boolean,
    "T062destinoSalida" boolean,
    "T062ubicacionEnBodega" boolean,
    "T062ubicacionAsignado" boolean,
    "T062ubicacionPrestado" boolean,
    "T062Id_PersonaResponsable" integer,
    "T062fechaUltimoMov" date,
    "T062valorAlIngreso" numeric(12,2),
    "T062cantidadEntranteConsumo" integer,
    "T062cantidadSalienteConsumo" integer,
    "T062Cod_EstadoDelActivo" character(1)
);

ALTER TABLE public."T062Inventario" OWNER TO postgres;

ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "PK_T062Inventario" PRIMARY KEY ("T062IdInventario"); 
    
ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "T062Inventario_T062Id_Articulo_T062Id_Bodega_UNQ" UNIQUE ("T062Id_Articulo", "T062Id_Bodega")
        INCLUDE("T062Id_Articulo", "T062Id_Bodega"); 

--****************************************************************
-- FOREIGN KEYS
--****************************************************************

ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Cod_TipoActivo" FOREIGN KEY ("T057Cod_TipoActivo") REFERENCES public."T060TiposActivo"("T060CodTipoActivo");
    
ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Id_Marca" FOREIGN KEY ("T057Id_Marca") REFERENCES public."T052Marcas"("T052IdMarca");
    
ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Id_UnidadMedida" FOREIGN KEY ("T057Id_UnidadMedida") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");

ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Id_PorcentajeIVA" FOREIGN KEY ("T057Id_PorcentajeIVA") REFERENCES public."T053PorcentajesIVA"("T053IdPorcentajeIVA");
    
ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Cod_MetodoValoracion" FOREIGN KEY ("T057Cod_MetodoValoracion") REFERENCES public."T058MetodosValoracionArticulos"("T058CodMetodoValoracion");
    
ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Cod_TipoDepreciacion" FOREIGN KEY ("T057Cod_TipoDepreciacion") REFERENCES public."T059TiposDepreciacionActivos"("T059CodTipoDepreciacion");
    
ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Id_UnidadMedidaVidaUtil" FOREIGN KEY ("T057Id_UnidadMedidaVidaUtil") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");

ALTER TABLE ONLY public."T057Articulos"
    ADD CONSTRAINT "FK_T057Articulos_T057Id_ArticuloPadre" FOREIGN KEY ("T057Id_ArticuloPadre") REFERENCES public."T057Articulos"("T057IdArticulo");

ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Id_Articulo" FOREIGN KEY ("T062Id_Articulo") REFERENCES public."T057Articulos"("T057IdArticulo");
    
ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Id_Bodega" FOREIGN KEY ("T062Id_Bodega") REFERENCES public."T056Bodegas"("T056IdBodega");
    
ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Cod_TipoEntrada" FOREIGN KEY ("T062Cod_TipoEntrada") REFERENCES public."T061TiposEntrada"("T061CodTipoEntrada");
    
ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Id_PersonaOrigen" FOREIGN KEY ("T062Id_PersonaOrigen") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Id_PersonaResponsable" FOREIGN KEY ("T062Id_PersonaResponsable") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Cod_EstadoDelActivo" FOREIGN KEY ("T062Cod_EstadoDelActivo") REFERENCES public."T051EstadosArticulo"("T051Cod_Estado");

--************************************************************************************
--FIN SECCIÓN OLIVER - HOJAS DE VIDA / MANTENIMIENTOS
--************************************************************************************

/************************************************************************************
    SECCIÓN LEYBER - ARTICULO / INVENTARIOS
*************************************************************************************/
-- MÉTODOS DE VALORACIÓN DE ARTICULOS
INSERT INTO public."T058MetodosValoracionArticulos" ("T058CodMetodoValoracion", "T058nombre", "T058descripcion") VALUES (1, 'Promedio Ponderado', 'Promedio Ponderado');
INSERT INTO public."T058MetodosValoracionArticulos" ("T058CodMetodoValoracion", "T058nombre", "T058descripcion") VALUES (2, 'PEPS', 'Primeros en Entrar, primeros en salir');
INSERT INTO public."T058MetodosValoracionArticulos" ("T058CodMetodoValoracion", "T058nombre", "T058descripcion") VALUES (3, 'UEPS', 'Últimos en entrar, primeros en salir');

-- TIPOS DE DEPRECIACIÓN DE ACTIVOS
--Línea Recta, --Unidades de Producción.
INSERT INTO public."T059TiposDepreciacionActivos" ("T059CodTipoDepreciacion", "T059nombre") VALUES (1, 'Línea Recta');

-- TIPOS DE ACTIVOS FIJOS
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('C', 'Computador');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('V', 'Vehículo');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('O', 'Otros Activos');

-- TIPOS DE ENTRADA DE ARTICULOS
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (1, 'Compra', 'Ingreso de artículos por motivo de una compra', 'proveedor');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (2, 'Donación', 'Ingreso de articulos por motivo de una donación', 'Donante');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (3, 'Resarcimiento', 'Ingreso de articulos por motivo de un resarcimiento de una persona o entidad', 'Quien Resarce');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (4, 'Compensación', 'Ingreso de articulos por motivo de una compensación', 'Compensante');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (5, 'Comodato', 'Ingreso de articulos por motivo de un comodato', 'Comodante');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (6, 'Convenio', 'Ingreso de articulos por motivo de un convenio', 'Tercero');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (7, 'Embargo', 'Ingreso de articulos por motivo de un embargo', 'Embargado');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (8, 'Incautación', 'Ingreso de articulos por motivo de una incautación', 'Incautado');
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen") VALUES (9, 'Apropiación', 'Ingreso de articulos por motivo de una apropiación que se hace producto de una orden de embargo o incautación definitiva', 'Tercero');
/************************************************************************************
FINNNNNNNNNNNNN    SECCIÓN LEYBER - ARTICULO / INVENTARIOS
*************************************************************************************/