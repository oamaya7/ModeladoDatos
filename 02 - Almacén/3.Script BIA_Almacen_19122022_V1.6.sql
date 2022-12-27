/****************************************************************
 Script de Creación de Base de Datos - Subsistema Almacén - Última Actualizacion 19/12/2022 - V1.6.
****************************************************************/


/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/
CREATE TYPE public."eTipoBien" AS ENUM (
    'A',
    'C'
);

ALTER TYPE public."eTipoBien" OWNER TO postgres;



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



CREATE TYPE public."eTipoDocUltimoMov" AS ENUM (
    'E_CPR',        --"ENTRADA_COMPRA"
    'E_DON',        --"ENTRADA_DONACIÓN"
    'E_RES',        --"ENTRADA_RESARCIMIENTO" 
    'E_CPS',        --"ENTRADA_COMPENSACION" 
    'E_CMD',        --"ENTRADA_COMODATO" 
    'E_CNV',        --"ENTRADA_CONVENIO" 
    'E_EMB',        --"ENTRADA_EMBARGO" 
    'E_INC',        --"ENTRADA_INCAUTACION" 
    'E_APR',        --"ENTRADA_APROPIACION"
    'ASIG',         --"ASIGNACIÓN" 
    'REAS',         --"REASIGNACIÓN" 
    'DEV_A',        --"DEVOLUCIÓN DE ASIGNADO" 
    'PRES',         --"PRESTAMO" 
    'DEV_P',        --"DEVOLUCIÓN DE PRESTADO" 
    'MANT',         --"MANTENIMIENTO" 
    'BAJA',         --"BAJA" 
    'SAL_E'        --"SALIDA ESPECIAL"
);

ALTER TYPE public."eTipoDocUltimoMov" OWNER TO postgres;



CREATE TYPE public."eEstadoAprobacionSolicitud" AS ENUM (
    'A',        --"Aprobado"
    'R'         --"Rechazado"
);

ALTER TYPE public."eEstadoAprobacionSolicitud" OWNER TO postgres;

CREATE TYPE public."eCodTipoElementoVivero" AS ENUM (
    'MV',        --"Material Vegetal"
    'IN'         --"Insumos"
    'HE'         --"Herramientas"
);

ALTER TYPE public."eCodTipoElementoVivero" OWNER TO postgres;


/****************************************************************
 CREACIÓN DE TABLAS.
****************************************************************/
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

ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "T055UnidadesMedida_T055Id_Magnitud_T055abreviatura_UNQ" UNIQUE ("T055Id_Magnitud", "T055abreviatura")
        INCLUDE("T055Id_Magnitud", "T055abreviatura");


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


CREATE TABLE public."T057CatalogoBienes" (
    "T057IdBien" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T057codigoBien" character varying(12) NOT NULL,
    "T057nroElementoEnElBien" smallint,
    "T057nombre" character varying(100) NOT NULL,
    "T057codTipoBien" public."eTipoBien" NOT NULL,
    "T057Cod_TipoActivo" character(3),
    "T057nivelJerarquico" smallint NOT NULL,
    "T057nombreCientifico" character varying(255),
    "T057descripcion" character varying(255),
    "T057docIdentificadorNro" character varying(30),
    "T057Id_Marca" smallint,
    "T057Id_UnidadMedida" smallint NOT NULL,
	"T057Id_PorcentajeIVA" smallint NOT NULL,
	"T057Cod_MetodoValoracion" smallint,
	"T057Cod_TipoDepreciacion" smallint,
    "T057cantidadVidaUtil" smallint,
    "T057Id_UnidadMedidaVidaUtil" smallint,
    "T057valorResidual" numeric(10,0),
	"T057stockMinimo" smallint,
	"T057stockMaximo" integer,
	"T057solicitablePorVivero" boolean NOT NULL,
    "T057esSemillaMVVivero" boolean,
    "T057codTipoElementoVivero" public."eCodTipoElementoVivero",
    "T057tieneHojaDeVida" boolean,
    "T057Id_BienPadre" integer,
    "T057manejaHojaDeVida" boolean NOT NULL,
    "T057visibleEnSolicitudes" boolean NOT NULL
);

ALTER TABLE public."T057CatalogoBienes" OWNER TO postgres;

ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "PK_T057CatalogoBienes" PRIMARY KEY ("T057IdBien");

ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "T057CatalogoBienes_codBien_nroElementoEnElBien_UNQ" UNIQUE ("T057codigoBien", "T057nroElementoEnElBien")
        INCLUDE("T057codigoBien", "T057nroElementoEnElBien"); 




CREATE TABLE public."T058MetodosValoracionArticulos" (
    "T058CodMetodoValoracion" smallint NOT NULL,
    "T058nombre" character varying(50) NOT NULL,
    "T058descripcion" character varying(255)   
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
    "T060CodTipoActivo" character(3) NOT NULL,
    "T060nombre" character varying(30) NOT NULL   
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
    "T061descripcion" character varying(255) NOT NULL,
    "T061tituloPersonaOrigen" character varying(20) NOT NULL,
    "T061constituyePropiedad" boolean NOT NULL
);


ALTER TABLE public."T061TiposEntrada" OWNER TO postgres;

ALTER TABLE ONLY public."T061TiposEntrada"
    ADD CONSTRAINT "PK_T061TiposEntrada" PRIMARY KEY ("T061CodTipoEntrada");

ALTER TABLE ONLY public."T061TiposEntrada"
    ADD CONSTRAINT "T061TiposEntrada_nombre_UNQ" UNIQUE ("T061nombre")
        INCLUDE("T061nombre");



CREATE TABLE public."T062Inventario" (
    "T062IdInventario" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T062Id_Bien" integer NOT NULL,
    "T062Id_Bodega" smallint NOT NULL,
    "T062Cod_TipoEntrada" smallint,
    "T062fechaIngreso" date,
    "T062Id_PersonaOrigen" integer,
    "T062numeroDocOrigen" character varying(30),
    "T062valorAlIngreso" numeric(12,2),
    "T062realizoBaja" boolean,
    "T062realizoSalida" boolean,
    "T062ubicacionEnBodega" boolean,
    "T062ubicacionAsignado" boolean,
    "T062ubicacionPrestado" boolean,
    "T062Id_PersonaResponsable" integer,
    "T062Cod_EstadoDelActivo" character(1),
   	"T062fechaUltimoMov" timestamp with time zone,
    "T062tipoDocUltimoMov" public."eTipoDocUltimoMov", 
    "T062IdRegEnDocUltimoMov" integer,
    "T062cantidadEntranteConsumo" integer,
    "T062cantidadSalienteConsumo" integer
);

ALTER TABLE public."T062Inventario" OWNER TO postgres;

ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "PK_T062Inventario" PRIMARY KEY ("T062IdInventario"); 
    
ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "T062Inventario_Id_Bien_Id_Bodega_UNQ" UNIQUE ("T062Id_Bien", "T062Id_Bodega")
        INCLUDE("T062Id_Bien", "T062Id_Bodega"); 


CREATE TABLE public."T063EntradasAlmacen" (
    "T063IdEntradaAlmacen" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T063nroEntradaAlmacen" integer NOT NULL,
    "T063fechaEntrada" timestamp with time zone NOT NULL,
    "T063fechaRealRegistro" timestamp with time zone NOT NULL,
    "T063motivo" character varying(255) NOT NULL,
    "T063observacion" character varying(255),
    "T063Id_Proveedor" integer NOT NULL,
    "T063Cod_TipoEntrada" smallint NOT NULL,
    "T063Id_BodegaGral" smallint NOT NULL,
    "T063Id_ArchivoSoporte" integer,
    "T063valorTotalEntrada" numeric(12,2) NOT NULL,
    "T063Id_PersonaCrea" integer NOT NULL,
    "T063Id_PersonaUltActualizacionDifACrea" integer,
    "T063fechaUltActualizacionDifACrea" timestamp with time zone,
    "T063entradaAnulada" boolean,
    "T063justificacionAnulacion" character varying(255),
    "T063fechaAnulacion" timestamp with time zone,
    "T063Id_PersonaAnula" integer
);

ALTER TABLE public."T063EntradasAlmacen" OWNER TO postgres;

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "PK_T063EntradasAlmacen" PRIMARY KEY ("T063IdEntradaAlmacen");

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "T063EntradasAlmacen_nroEntradaAlm_UNQ" UNIQUE ("T063nroEntradaAlmacen")
        INCLUDE("T063nroEntradaAlmacen"); 


CREATE TABLE public."T064Items_EntradaAlmacen" (
    "T064IdItem_EntradaAlmacen" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T064Id_EntradaAlmacen" integer NOT NULL,
    "T064Id_Bien" integer NOT NULL,
    "T064cantidad" integer NOT NULL,
    "T064valorUnitario" numeric(11,2) NOT NULL,
    "T064Id_PorcentajeIVA" numeric(5,2) NOT NULL,
    "T064valorIVA" numeric(11,2) NOT NULL,
    "T064valorTotalItem" numeric(11,2) NOT NULL,
    "T064Id_Bodega" smallint NOT NULL,
    "T064Cod_Estado" character(1),
    "T064docIdentificadorBien" character varying(30),
    "T064cantidadVidaUtil" smallint,
    "T064Id_UnidadMedidaVidaUtil" smallint,
    "T064valorResidual" numeric(10,0),
    "T064nroPosicion" smallint NOT NULL
);

ALTER TABLE public."T064Items_EntradaAlmacen" OWNER TO postgres;

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "PK_T64Items_EntradaAlmacen" PRIMARY KEY ("T064IdItem_EntradaAlmacen");

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "T064Items_EntradaAlma_IdEntAlma_IdBien_UNQ" UNIQUE ("T064Id_EntradaAlmacen", "T064Id_Bien")
        INCLUDE("T064Id_EntradaAlmacen", "T064Id_Bien");


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
	"T069fechaGenerada" timestamp with time zone NOT NULL, 
	"T069fechaProgramada" date NOT NULL,
    "T069kilometrajeProgramado" integer,
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
    "T070fechaRegistrado" timestamp with time zone NOT NULL,
    "T070fechaEjecutado" timestamp with time zone NOT NULL,
	"T070codTipoMantenimiento" public."eTipoMantenimiento" NOT NULL, 
	"T070accionesRealizadas" text NOT NULL,
	"T070diasEmpleados" smallint NOT NULL,
	"T070observaciones" character varying(255),
	"T070Cod_EstadoFinal" character(1) NOT NULL,
	"T070Id_ProgramacionMtto" integer,
    "T070valorMantenimiento" numeric(12,2),
	"T070contratoMantenimiento" character varying(20),
	"T070Id_PersonaRealiza" integer NOT NULL,
	"T070Id_PersonaDiligencia" integer NOT NULL,
    "T070rutaDocumentoSoporte" character varying(255)
    "T070codEstadoAnterior" character(1) NOT NULL,
    "T070fechaAnteriorMov" timestamp with time zone NOT NULL,
    "T070tipoDocAnteriorMov" public."eTipoDocUltimoMov" NOT NULL,
    "T070IdRegEnDocAnteriorMov" integer NOT NULL
);

ALTER TABLE public."T070RegistroMantenimientos" OWNER TO postgres;

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "PK_T070RegistroMantenimientos" PRIMARY KEY ("T070IdRegistroMtto");


CREATE TABLE public."T081SolicitudesConsumibles" (
    "T081IdSolicitudConsumibles" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T081esSolicitudDeConservacion" boolean NOT NULL,
    "T081nroSolicitudPorTipo" integer NOT NULL,
    "T081fechaSolicitud" timestamp with time zone NOT NULL,
    "T081motivo" character varying(255) NOT NULL,
    "T081observacion" character varying(255),
    "T081Id_PersonaSolicita" integer NOT NULL,
    "T081Id_UnidadOrgDelSolicitante" smallint NOT NULL,
    "T081Id_UnidadParaLaQueSolicita" smallint NOT NULL,
    "T081Id_FuncionarioResponsableUnidad" integer NOT NULL,
    "T081Id_UnidadOrgDelResponsable" smallint NOT NULL,
    "T081solicitudAbierta" boolean NOT NULL,
    "T081fechaCierreSolicitud" timestamp with time zone,
    "T081revisadaResponsable" boolean NOT NULL,
    "T081estadoAprobacionResponsable" public."eEstadoAprobacionSolicitud",
    "T081justificacionRechazoResponsable" character varying(255),
    "T081fechaAprobacionResponsable" timestamp with time zone,
    "T081gestionadaAlmacen" boolean NOT NULL,
    "T081Id_DespachoConsumo" integer,
    "T081ObservCierreNoDispoAlm" character varying(255),
    "T081fechaCierreNoDispoAlm" timestamp with time zone,
    "T081Id_PersonaCierreNoDispoAlm" integer,
    "T081rechazadaAlmacen" boolean,
    "T081fechaRechazoAlmacen" timestamp with time zone,
    "T081justificacionRechazoAlmacen" character varying(255),
    "T081Id_PersonaAlmacenRechaza" integer,
    "T081solicitudAnuladaSolicitante" boolean,
    "T081justificacionAnulacionSolicitante" character varying(255),
    "T081fechaAnulacionSolicitante" timestamp with time zone
);

ALTER TABLE public."T081SolicitudesConsumibles" OWNER TO postgres;

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "PK_T081SolicitudesConsumibles" PRIMARY KEY ("T081IdSolicitudConsumibles");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "T081SolicitudesConsum_esSolCons_nroSolXTipo_UNQ" UNIQUE ("T081esSolicitudDeConservacion", "T081nroSolicitudPorTipo")
        INCLUDE("T081esSolicitudDeConservacion", "T081nroSolicitudPorTipo"); 


CREATE TABLE public."T082Items_SolicitudConsumible" (
    "T082IdItem_SolicitudConsumible" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T082Id_SolicitudConsumibles" integer NOT NULL,
    "T082Id_Bien" integer NOT NULL,
    "T082cantidad" smallint NOT NULL,
    "T082Id_UnidadMedida" smallint NOT NULL,
    "T082observaciones" character varying(30),
    "T082nroPosicion" smallint NOT NULL
);

ALTER TABLE public."T082Items_SolicitudConsumible" OWNER TO postgres;

ALTER TABLE ONLY public."T082Items_SolicitudConsumible"
    ADD CONSTRAINT "PK_T082Items_SolicitudConsumible" PRIMARY KEY ("T082IdItem_SolicitudConsumible");

ALTER TABLE ONLY public."T082Items_SolicitudConsumible"
    ADD CONSTRAINT "T082Items_SolicitudConsumible_IdSolCon_IdBien_UNQ" UNIQUE ("T082Id_SolicitudConsumible", "T082Id_Bien")
        INCLUDE("T082Id_SolicitudConsumible", "T082Id_Bien");


CREATE TABLE public."T083DespachosConsumo" (
    "T083IdDespachoConsumo" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T083nroDespachoConsumo" integer NOT NULL,
    "T083Id_SolicitudConsumo" integer,
    "T083nroSolicitudPorTipo" integer,
    "T083fechaSolicitud" timestamp with time zone,
    "T083fechaDespacho" timestamp with time zone NOT NULL,
    "T083fechaRegistro" timestamp with time zone NOT NULL,
    "T083Id_PersonaDespacha" integer NOT NULL,
    "T083motivo" character varying(255),
    "T083Id_PersonaSolicita" integer,
    "T083Id_UnidadParaLaQueSolicita" smallint,
    "T083Id_FuncionarioResponsableUnidad" integer,
    "T083esDespachoDeConservacion" boolean NOT NULL,
    "T083Id_EntradaAlmacenCV" integer,
    "T083Id_BodegaGral" smallint,
    "T083despachoAnulado" boolean,
    "T083justificacionAnulacion" character varying(255),
    "T083fechaAnulacion" timestamp with time zone,
    "T083Id_PersonaAnula" integer,
    "T083rutaArchivoDocConRecibido" character varying(255)
);

ALTER TABLE public."T083DespachosConsumo" OWNER TO postgres;

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "PK_T083DespachosConsumo" PRIMARY KEY ("T083IdDespachoConsumo");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "T083DespachosConsumo_nroDespCons_UNQ" UNIQUE ("T083nroDespachoConsumo")
        INCLUDE("T083nroDespachoConsumo");


CREATE TABLE public."T084Items_DespachoConsumo" (
    "T084IdItem_DespachoConsumo" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T084Id_DespachoConsumo" integer NOT NULL,
    "T084Id_BienDespachado" integer,
    "T084Id_BienSolicitado" integer,
    "T084Id_EntradaAlmacenDelBien" integer,
    "T084Id_Bodega" smallint,
    "T084cantidadSolicitada" integer,
    "T084Id_UnidadMedidaSolicitada" smallint,
    "T084cantidadDespachada" integer NOT NULL,
    "T084observacion" character varying(50),
    "T084nroPosicionEnDespacho" smallint NOT NULL
);

ALTER TABLE public."T084Items_DespachoConsumo" OWNER TO postgres;

ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "PK_T084Items_DespachoConsumo" PRIMARY KEY ("T084IdItem_DespachoConsumo");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "T083DespachosConsumo_nroDespCons_UNQ" UNIQUE ("T084Id_DespachoConsumo", "T084Id_BienDespachado", "T084Id_BienSolicitado", "T084Id_EntradaAlmacenDelBien", "T084Id_Bodega")
        INCLUDE("T084Id_DespachoConsumo", "T084Id_BienDespachado", "T084Id_BienSolicitado", "T084Id_EntradaAlmacenDelBien", "T084Id_Bodega");

--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************
ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "FK_T055UnidadesMedida_T055Id_Magnitud" FOREIGN KEY ("T055Id_Magnitud") REFERENCES public."T054Magnitudes"("T054IdMagnitud");

ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "FK_T056Bodegas_T056Cod_Municipio" FOREIGN KEY ("T056Cod_Municipio") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "FK_T056Bodegas_T056Id_Responsable" FOREIGN KEY ("T056Id_Responsable") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Cod_TipoActivo" FOREIGN KEY ("T057Cod_TipoActivo") REFERENCES public."T060TiposActivo"("T060CodTipoActivo");
    
ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Id_Marca" FOREIGN KEY ("T057Id_Marca") REFERENCES public."T052Marcas"("T052IdMarca");
    
ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Id_UnidadMedida" FOREIGN KEY ("T057Id_UnidadMedida") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");

ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Id_PorcentajeIVA" FOREIGN KEY ("T057Id_PorcentajeIVA") REFERENCES public."T053PorcentajesIVA"("T053IdPorcentajeIVA");
    
ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Cod_MetodoValoracion" FOREIGN KEY ("T057Cod_MetodoValoracion") REFERENCES public."T058MetodosValoracionArticulos"("T058CodMetodoValoracion");
    
ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Cod_TipoDepreciacion" FOREIGN KEY ("T057Cod_TipoDepreciacion") REFERENCES public."T059TiposDepreciacionActivos"("T059CodTipoDepreciacion");
    
ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Id_UnidadMedidaVidaUtil" FOREIGN KEY ("T057Id_UnidadMedidaVidaUtil") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");

ALTER TABLE ONLY public."T057CatalogoBienes"
    ADD CONSTRAINT "FK_T057CatalogoBienes_T057Id_BienPadre" FOREIGN KEY ("T057Id_BienPadre") REFERENCES public."T057CatalogoBienes"("T057IdBien");


ALTER TABLE ONLY public."T062Inventario"
    ADD CONSTRAINT "FK_T062Inventario_T062Id_Bien" FOREIGN KEY ("T062Id_Bien") REFERENCES public."T057CatalogoBienes"("T057IdBien");
    
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


ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "FK_T063EntradasAlmacen_Id_Prov" FOREIGN KEY ("T063Id_Proveedor") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "FK_T063EntradasAlmacen_Cod_TipoEnt" FOREIGN KEY ("T063Cod_TipoEntrada") REFERENCES public."T061TiposEntrada"("T061CodTipoEntrada");

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "FK_T063EntradasAlmacen_Id_BodGral" FOREIGN KEY ("T063Id_BodegaGral") REFERENCES public."T056Bodegas"("T056IdBodega");

-- ALTER TABLE ONLY public."T063EntradasAlmacen"
--     ADD CONSTRAINT "FK_T063EntradasAlmacen_T063Id_ArchSoporte" FOREIGN KEY ("T063Id_ArchivoSoporte") REFERENCES public."TXXXArchivosSoporte"("TXXXIdArchivoSoporte");

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "FK_T063EntradasAlmacen_Id_PersCrea" FOREIGN KEY ("T063Id_PersonaCrea") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "FK_T063EntradasAlmacen_Id_PersUltActDif" FOREIGN KEY ("T063Id_PersonaUltActualizacionDifACrea") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T063EntradasAlmacen"
    ADD CONSTRAINT "FK_T063EntradasAlmacen_T063Id_PersAnula" FOREIGN KEY ("T063Id_PersonaAnula") REFERENCES public."T010Personas"("T010IdPersona");

-- TABLA T064Items_EntradaAlmacen
ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "FK_T064Items_EntradaAlmacen_EntAlma" FOREIGN KEY ("T064Id_EntradaAlmacen") REFERENCES public."T063EntradasAlmacen"("T063IdEntradaAlmacen");

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "FK_T064Items_EntradaAlmacen_Id_Bien" FOREIGN KEY ("T064Id_Bien") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "FK_T064Items_EntradaAlmacen_Id_PorcIVA" FOREIGN KEY ("T064Id_PorcentajeIVA") REFERENCES public."T053PorcentajesIVA"("T053IdPorcentajeIVA");

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "FK_T064Items_EntradaAlmacen_Id_Bodega" FOREIGN KEY ("T064Id_Bodega") REFERENCES public."T056Bodegas"("T056IdBodega");

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "FK_T064Items_EntradaAlmacen_Cod_Estado" FOREIGN KEY ("T064Cod_Estado") REFERENCES public."T051EstadosArticulo"("T051CodEstado");

ALTER TABLE ONLY public."T064Items_EntradaAlmacen"
    ADD CONSTRAINT "FK_T064Items_EntradaAlmacen_UndMedidaVidaUtil" FOREIGN KEY ("T064Id_UnidadMedidaVidaUtil") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");


ALTER TABLE ONLY public."T065HojaDeVidaComputadores"
    ADD CONSTRAINT "FK_T065HojaDeVidaComputadores_T065Id_Articulo" FOREIGN KEY ("T065Id_Articulo") REFERENCES public."T057CatalogoBienes"("T057IdBien");


ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "FK_T066HojaDeVidaVehiculos_T066Id_Articulo" FOREIGN KEY ("T066Id_Articulo") REFERENCES public."T057CatalogoBienes"("T057IdBien");	    

ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
    ADD CONSTRAINT "FK_T066HojaDeVidaVehiculos_T066Id_Proveedor" FOREIGN KEY ("T066Id_Proveedor") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."T067HojaDeVidaOtrosActivos"
    ADD CONSTRAINT "FK_T067HojaDeVidaOtrosActivos_T067Id_Articulo" FOREIGN KEY ("T067Id_Articulo") REFERENCES public."T057CatalogoBienes"("T057IdBien");


ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "FK_T068DocumentosVehiculo_T068Id_Articulo" FOREIGN KEY ("T068Id_Articulo") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T068DocumentosVehiculo"
    ADD CONSTRAINT "FK_T068DocumentosVehiculo_T068Id_EmpresaProveedora" FOREIGN KEY ("T068Id_EmpresaProveedora") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "FK_T069ProgramacionMantenimientos_T069Id_Articulo" FOREIGN KEY ("T069Id_Articulo") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "FK_T069ProgramacionMantenimientos_T069Id_PersonaSolicita" FOREIGN KEY ("T069Id_PersonaSolicita") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T069ProgramacionMantenimientos"
    ADD CONSTRAINT "FK_T069ProgramacionMantenimientos_T069Id_PersonaAnula" FOREIGN KEY ("T069Id_PersonaAnula") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_Articulo" FOREIGN KEY ("T070Id_Articulo") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_ProgramacionMtto" FOREIGN KEY ("T070Id_ProgramacionMtto") REFERENCES public."T069ProgramacionMantenimientos"("T069IdProgramacionMtto");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_PersonaRealiza" FOREIGN KEY ("T070Id_PersonaRealiza") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Id_PersonaDiligencia" FOREIGN KEY ("T070Id_PersonaDiligencia") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T070RegistroMantenimientos"
    ADD CONSTRAINT "FK_T070RegistroMantenimientos_T070Cod_EstadoFinal" FOREIGN KEY ("T070Cod_EstadoFinal") REFERENCES public."T051EstadosArticulo"("T051Cod_Estado");

--@@LS: Aún no está la tabla de Vehículos arrendados, tan prontoo esté, habilitar esta FK.
--ALTER TABLE ONLY public."T066HojaDeVidaVehiculos"
--    ADD CONSTRAINT "FK_T066HojaDeVidaVehiculos_T066Id_VehiculoArrendado" FOREIGN KEY ("T066Id_VehiculoArrendado") REFERENCES public."T071VehiculosArrendados"("T071IdVehiculoArrendado");



-- TABLA T081SolicitudesConsumibles
ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_PersSolic" FOREIGN KEY ("T081Id_PersonaSolicita") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_UndOrgSolitante" FOREIGN KEY ("T081Id_UnidadOrgDelSolicitante") REFERENCES public."T010Personas"("T010IdUnidadOrgActual");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_UndParaSolicita" FOREIGN KEY ("T081Id_UnidadParaLaQueSolicita") REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_FuncRespUnd" FOREIGN KEY ("T081Id_FuncionarioResponsableUnidad") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_UndOrgResp" FOREIGN KEY ("T081Id_UnidadOrgDelResponsable") REFERENCES public."T010Personas"("T010IdUnidadOrgActual");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_DespCons" FOREIGN KEY ("T081Id_DespachoConsumo") REFERENCES public."T083IdDespachoConsumo"("T083DespachosConsumo");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_PerCieNoDisp" FOREIGN KEY ("T081Id_PersonaCierreNoDispoAlm") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T081SolicitudesConsumibles"
    ADD CONSTRAINT "FK_T081SolicitudesConsumibles_Id_PersAlmRech" FOREIGN KEY ("T081Id_PersonaAlmacenRechaza") REFERENCES public."T010Personas"("T010IdPersona");

-- TABLA T082Items_SolicitudConsumible
ALTER TABLE ONLY public."T082Items_SolicitudConsumible"
    ADD CONSTRAINT "FK_T082Items_SolicitudConsumible_Id_SolCons" FOREIGN KEY ("T082Id_SolicitudConsumibles") REFERENCES public."T081SolicitudesConsumibles"("T081IdSolicitudConsumibles");

ALTER TABLE ONLY public."T082Items_SolicitudConsumible"
    ADD CONSTRAINT "FK_T082Items_SolicitudConsumible_Id_Bien" FOREIGN KEY ("T082Id_Bien") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T082Items_SolicitudConsumible"
    ADD CONSTRAINT "FK_T082Items_SolicitudConsumible_Id_UndMedVidaUtil" FOREIGN KEY ("T082Id_UnidadMedida") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");

-- TABLA T083DespachosConsumo
ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_SolCons" FOREIGN KEY ("T083Id_SolicitudConsumo") REFERENCES public."T081SolicitudesConsumibles"("T081IdSolicitudConsumibles");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_PersDesp" FOREIGN KEY ("T083Id_PersonaDespacha") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_PersSol" FOREIGN KEY ("T083Id_PersonaSolicita") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_UndSol" FOREIGN KEY ("T083Id_UnidadParaLaQueSolicita") REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_FuncRespUnd" FOREIGN KEY ("T083Id_FuncionarioResponsableUnidad") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_EntrAlmCV" FOREIGN KEY ("T083Id_EntradaAlmacenCV") REFERENCES public."T063EntradasAlmacen"("T063IdEntradaAlmacen");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_BodGral" FOREIGN KEY ("T083Id_BodegaGral") REFERENCES public."T056Bodegas"("T056IdBodega");

ALTER TABLE ONLY public."T083DespachosConsumo"
    ADD CONSTRAINT "FK_T083DespachosConsumo_T083Id_PersAnl" FOREIGN KEY ("T083Id_PersonaAnula") REFERENCES public."T010Personas"("T010IdPersona");


-- TABLA T084Items_DespachoConsumo
ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "FK_T084Items_DespachoConsumo_T084Id_DespCons" FOREIGN KEY ("T084Id_DespachoConsumo") REFERENCES public."T083DespachosConsumo"("T083IdDespachoConsumo");

ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "FK_T084Items_DespachoConsumo_T084Id_BienDsp" FOREIGN KEY ("T084Id_BienDespachado") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "FK_T084Items_DespachoConsumo_T084Id_BienSol" FOREIGN KEY ("T084Id_BienSolicitado") REFERENCES public."T057CatalogoBienes"("T057IdBien");

ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "FK_T084Items_DespachoConsumo_T084Id_BienSol" FOREIGN KEY ("T084Id_EntradaAlmacenDelBien") REFERENCES public."T063EntradasAlmacen"("T063IdEntradaAlmacen");

ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "FK_T084Items_DespachoConsumo_T084Id_BodEsp" FOREIGN KEY ("T084Id_Bodega") REFERENCES public."T056Bodegas"("T056IdBodega");

ALTER TABLE ONLY public."T084Items_DespachoConsumo"
    ADD CONSTRAINT "FK_T084Items_DespachoConsumo_T084Id_UndMedSol" FOREIGN KEY ("T084Id_UnidadMedidaSolicitada") REFERENCES public."T055UnidadesMedida"("T055IdUnidadMedida");


/****************************************************************
 INSERCIÓN DE DATOS INICIALES.
****************************************************************/
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

-- MÉTODOS DE VALORACIÓN DE ARTICULOS
INSERT INTO public."T058MetodosValoracionArticulos" ("T058CodMetodoValoracion", "T058nombre", "T058descripcion") VALUES (1, 'Promedio Ponderado', 'Promedio Ponderado');
INSERT INTO public."T058MetodosValoracionArticulos" ("T058CodMetodoValoracion", "T058nombre", "T058descripcion") VALUES (2, 'PEPS', 'Primeros en Entrar, primeros en salir');
INSERT INTO public."T058MetodosValoracionArticulos" ("T058CodMetodoValoracion", "T058nombre", "T058descripcion") VALUES (3, 'UEPS', 'Últimos en entrar, primeros en salir');

-- TIPOS DE DEPRECIACIÓN DE ACTIVOS
--Línea Recta, --Unidades de Producción.
INSERT INTO public."T059TiposDepreciacionActivos" ("T059CodTipoDepreciacion", "T059nombre") VALUES (1, 'Línea Recta');

-- TIPOS DE ACTIVOS FIJOS
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('Com', 'Computador');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('Veh', 'Vehículo');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('OAc', 'Otros Activos');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('Ter', 'Terrenos');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('CyE', 'Construcciones y Edificaciones');
INSERT INTO public."T060TiposActivo" ("T060CodTipoActivo", "T060nombre") VALUES ('Int', 'Intangibles');

-- TIPOS DE ENTRADA DE ARTICULOS
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (1, 'Compra', 'Ingreso de bienes por motivo de una compra', 'proveedor', true);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (2, 'Donación', 'Ingreso de bienes por motivo de una donación', 'Donante', true);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (3, 'Resarcimiento', 'Ingreso de bienes por motivo de un resarcimiento de una persona o entidad', 'Quien Resarce', true);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (4, 'Compensación', 'Ingreso de bienes por motivo de una compensación', 'Compensante', true);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (5, 'Comodato', 'Ingreso de bienes por motivo de un comodato', 'Comodante', false);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (6, 'Convenio', 'Ingreso de bienes por motivo de un convenio', 'Tercero', false);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (7, 'Embargo', 'Ingreso de bienes por motivo de un embargo', 'Embargado', false);
INSERT INTO public."T061TiposEntrada" ("T061CodTipoEntrada", "T061nombre", "T061descripcion", "T061tituloPersonaOrigen", "T061constituyePropiedad") VALUES (8, 'Incautación', 'Ingreso de bienes por motivo de una incautación', 'Incautado', false);





/************************************************************************************
    SECCIÓN LEYBER - ENTRADAS / SOLICITUDES
*************************************************************************************/


/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/
--****************************************************************
-- CREACIÓN DE TABLAS.
--****************************************************************

--****************************************************************
-- FOREIGN KEYS
--****************************************************************
/************************************************************************************
FINNNNNNNNNNNNN    SECCIÓN LEYBER - ARTICULO / INVENTARIOS
*************************************************************************************/




/************************************************************************************
    SECCIÓN Miguel Guevara - VEHICULOS_ARRENDADOS / ASIGNACIÓN_VEHICULOCONDUCTOR / 
*************************************************************************************/
CREATE TYPE public."eEstadoAprobacion" AS ENUM (
    'P',    --Pendiente
    'A',    --Aprobado
    'R'     --Rechazado
);

ALTER TYPE public."eEstadoAprobacion" OWNER TO postgres;

CREATE TYPE public."eEstadoSolicitudViaje" AS ENUM (
    'Sin Aprobar',
    'En Espera',
    'Asignado',
    'Autorizado',
    'Finalizado',
    'Completado'
);

ALTER TYPE public."eEstadoSolicitudViaje" OWNER TO postgres;

CREATE TYPE public."eTipoCierreViaje" AS ENUM (
    'V', --'Vencimiento',
    'I', --'Incumplimiento',
    'D' --'Disponibilidad(No)',
    'A' --Aprobación (No)
);

ALTER TYPE public."eTipoCierreViaje" OWNER TO postgres;


CREATE TABLE public."T071VehiculosArrendados" (
    "T071IdVehiculoArrendado" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T071nombre" character varying(50) NOT NULL,
    "T071descripcion" character varying(255) NOT NULL,
    "T071placa" character varying(10) NOT NULL,
    "T071Id_Marca" smallint NOT NULL,
    "T071fechaInicio" date NOT NULL,
    "T071fechaFin" date NOT NULL,
    "T071empresaContratista" character varying(50) NOT NULL,
    "T071tieneHojaDeVida" boolean NOT NULL
);


ALTER TABLE public."T071VehiculosArrendados" OWNER TO postgres;


CREATE TABLE public."T072VehiculosAgendables_Conductor" (
    "T072IdVehiculoConductor" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T072Id_HojaDeVidaVehiculo" integer NOT NULL,
    "T072Id_PersonaConductor" integer NOT NULL,
    "T072fechaIniciaAsignacion" DATE NOT NULL,
    "T072fechaFinalizaAsignacion" DATE NOT NULL,
    "T072Id_PersonaQueAsigna" integer NOT NULL,
    "T072fechaRegistro" timestamp with time zone NOT NULL,
    "T072Id_PersonaUltActualizacionDifCrea" integer ,
    "T072fechaUltActualizacionDifCrea" timestamp with time zone
);


ALTER TABLE public."T072VehiculosAgendables_Conductor" OWNER TO postgres;


CREATE TABLE public."T073InspeccionesVehiculoDia" (
    "T073IdInspeccionVehiculoDia" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T073Id_HojaDeVidaVehiculo" integer NOT NULL,
    "T073Id_PersonaQueInspecciona" integer NOT NULL,
    "T073diaInspeccion" date NOT NULL,
    "T073fechaRegistro" timestamp with time zone NOT NULL,
    "T073kilometraje" integer NOT NULL,
    "T073dirDelanterasBuenas" boolean NOT NULL,
    "T073dirTraserasBuenas" BOOLEAN not null,
    "T073limpiabrisasDelanterosBuenos" boolean NOT NULL,
    "T073limpiabrisasTraseroBueno" BOOLEAN not null,
    "T073nivelAceiteBueno" boolean NOT NULL,
    "T073nivelFrenosBueno" BOOLEAN not null,
    "T073nivelRegrigeranteBueno" boolean NOT NULL,
    "T073apoyaCabezasPilotoBueno" BOOLEAN not null,
    "T073apoyaCabezasCopilotoBueno" boolean NOT NULL,
    "T073apoyaCabezasTraserosBuenos" BOOLEAN not null,
    "T073frenosGeneralesBuenos" boolean NOT NULL,
    "T073frenoEmergenciaBueno" BOOLEAN not null,
    "T073llantasDelanterasBuenas" boolean NOT NULL,
    "T073LlantasTraserasBuenas" BOOLEAN not null,
    "T073llantaRespuestoBuena" boolean NOT NULL,
    "T073espejosLateralesBuenos" BOOLEAN not null,
    "T073espejoRetrovisorBueno" boolean NOT NULL,
    "T073cinturonesDelanterosBuenos" BOOLEAN not null,
    "T073cinturonesTraserosBuenos" boolean NOT NULL,
    "T073lucesAltasBuenas" BOOLEAN not null,
    "T073lucesMediasBuenas" boolean NOT NULL,
    "T073lucesBajasBuenas" BOOLEAN not null,
    "T073lucesParadaBuenas" boolean NOT NULL,
    "T073lucesParqueoBuenas" BOOLEAN not null,
    "T073lucesReversaBuenas" boolean NOT NULL,
    "T073kitHerramientasAlDia" BOOLEAN not null,
    "T073botiquinCompleto" boolean NOT NULL,
    "T073pitoBueno" BOOLEAN not null,
    "T073observaciones" character varying(255),
    "T073requiereVerificacionSuperior" BOOLEAN not null,
    "T073verificacionSuperiorRealizada" boolean NOT NULL,
    "T073Id_PersonaQueVerifica" INTEGER 
);

ALTER TABLE public."T073InspeccionesVehiculoDia" OWNER TO postgres;

CREATE TABLE public."T074VehiculosAgendados_DiaDisponible" (
    "T074IdVehAgendaDia" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T074Id_HojaDeVidaVehiculo" INTEGER NOT NULL,
    "T074diaDisponibilidad" DATE  NOT NULL,
    "T074consecutivoDia" SMALLINT NOT NULL,
    "T074Id_ViajeAgendado" integer NULL,
    "T074viajeEjecutado" BOOLEAN NOT NULL,
    "T074Id_PersonaQueRegistra" integer NOT NULL
);

ALTER TABLE public."T074VehiculosAgendados_DiaDisponible" OWNER TO postgres;


CREATE TABLE public."T075SolicitudesViaje" (
    "T075IdSolicitudViaje" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T075Id_PersonaSolicita" integer NOT NULL,
    "T075Id_UnidadOrgSolicitante" integer NOT NULL,
    "T075fechaSolicitud" timestamp with time zone NOT NULL,
    "T075expedienteAsociado" CHARACTER VARYING(90) NOT NULL,
    "T075motivoViajeSolicitado" CHARACTER VARYING(255) NOT NULL,
    "T075direccion" CHARACTER VARYING(255) NOT NULL,
    "T075Cod_MunicipioDestino" CHARACTER (5) NOT NULL,
    "T075indicacionesDestino" CHARACTER VARYING(255) NOT NULL,
    "T075nroPasajeros" SMALLINT NOT NULL,
    "T075requiereCarga" BOOLEAN NOT NULL,
    "T075fechaPartida" date NOT NULL,
    "T075horaPartida"  time NULL,
    "T075fechaRetorno" date not null,
    "T075horaRetorno" time null,
    "T075reqCompagniaMilitar" BOOLEAN NOT NULL,
    "T075consideracionesAdicionales" CHARACTER VARYING(255) NULL,
    "T075Id_FuncionarioResponsable" INTEGER NOT NULL,
    "T075Id_UnidadOrgResponsable" INTEGER NOT NULL,
    "T075estadoAprobacionResponsable" public."eEstadoAprobacion" NOT NULL,
    "T075justificacionAprobacionResponsable" CHARACTER varying(255),
    "T075fechaAprobacionResponsable" TIMESTAMP with time zone,
    "T075solicitudRechazadaAreaTrans" BOOLEAN not null,
    "T075Id_PersonaRechazaSolicitud" INTEGER ,
    "T075justificacionRechazoSolicitud" CHARACTER VARYING(255),
    "T075fechaRechazoSolicitud" TIMESTAMP with time zone,
    "T075solicitudAnuladaSolicitante" BOOLEAN NOT NULL,
    "T075justificacionAnulacionSolicitante" CHARACTER varying(255),
    "T075fechaAnulacionSolicitante" TIMESTAMP with time zone,    
    "T075Id_PersonaCierraViaje" INTEGER,
    "T075codTipoCierreViaje" public."eTipoCierreViaje" NOT NULL,--[Vencimiento, Incumplimiento, NoDisponible]
    "T075justificacionCierreViaje" character varying(255),
    "T075fechaCierreViaje" TIMESTAMP with TIME ZONE ,
    "T075estadoSolicitud" public."eEstadoSolicitudViaje" NOT NULL,
    "T075solicitudAbierta" BOOLEAN NOT NULL
);


ALTER TABLE public."T075SolicitudesViaje" OWNER TO postgres;

CREATE TABLE public."T076Asignaciones_ViajeAgendado" (
    "T076IdAsignacion_ViajeAgendado" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T076Id_ViajeAgendado" INTEGER NOT NULL,
    "T076Id_SolicitudViaje" INTEGER NOT NULL,
    "T076fechaAsignacion" TIMESTAMP with time zone NOT NULL,
    "T076esAsignacionAutomatica" BOOLEAN not NULL,
    "T076Id_PersonaAsigna" INTEGER,
    "T076observacioensAsignacion" character varying(255),
    "T076rechazadoSolicitante" BOOLEAN NOT NULL,
    "T076Id_PersonaRechaza" integer,
    "T076justificacionRechazo" character varying(255),
    "T076fechaRechazo" TIMESTAMP WITH TIME ZONE ,
    "T076asignacionAnulada" BOOLEAN NOT NULL,
    "T076Id_PersonaAnula" INTEGER,
    "T076justificacionAnulacion" character varying(255),
    "T076fechaAnulacion" TIMESTAMP WITH TIME ZONE ,
    "T076solicitudReprogramada" BOOLEAN NOT NULL,
    "T076asignacionAbierta" BOOLEAN not null
);


ALTER TABLE public."T076Asignaciones_ViajeAgendado" OWNER TO postgres;


CREATE TABLE public."T077ViajesAgendados" (
    "T077IdViajeAgendado" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T077Id_HojaDeVidaVehiculo" INTEGER NOT NULL,
    "T077direccion" CHARACTER VARYING not null,
    "T077Cod_MunicipioDestino" CHARACTER (5) not null,
    "T077indicacionesDestino" CHARACTER varying(255),
    "T077nroTotalPasajerosReq" SMALLINT,
    "T077requiereCapacidadCarga" BOOLEAN not null,
    "T077fechaPartidaAsignada" date NOT NULL,
    "T077horaPartida" TIME NULL,
    "T077fechaRetornoAsignada" date not null,
    "T077horaRetorno" time NULL,
    "T077requiereCompagniaMilitar" BOOLEAN not null,
    "T077observacionUnion" character varying(255),
    "T077viajeAutorizado" BOOLEAN,
    "T077Id_PersonaAutoriza" INTEGER ,
    "T077observacionAutorizacion" character varying(255),
    "T077fechaAutorizacion" TIMESTAMP with time zone,
    "T077yaInicio" boolean NOT NULL,
    "T077yaLlego" boolean NOT NULL,
    "T077multiplesAsignaciones" BOOLEAN not null,
    "T077viajeAgendadoAbierto" boolean NOT NULL
);

ALTER TABLE public."T077ViajesAgendados" OWNER TO postgres;

CREATE TABLE public."T078Compatibilidades_ViajesAgendados" (
    "T078IdCompatibilidad" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T078Id_ViajeAgendado" INTEGER NOT NULL,
    "T078Id_SolicitudViajeSugerido" INTEGER NOT NULL,
    "T078requiereAjuste" BOOLEAN not null,
    "T078fechaEmparejamiento" TIMESTAMP WITH time ZONE not null
);

ALTER TABLE public."T078Compatibilidades_ViajesAgendados" OWNER TO postgres;

CREATE TABLE public."T079BitacoraViaje" (
    "T079IdBitacoraViaje" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T079Id_ViajeAgendado" INTEGER NOT NULL,
    "T079Id_ConductorQueParte" INTEGER NULL,
    "T079nombreConductorFueraSistema" CHARACTER VARYING(90) null,
    "T079documentoConductorFS" CHARACTER VARYING(90) null,
    "T079telefonoConductorFS" CHARACTER varying(15) NULL,
    "T079fechaInicioRecorrido" TIMESTAMP WITH TIME ZONE not null,
    "T079fechaRegistroDelInicio" TIMESTAMP WITH TIME ZONE not null,
    "T079novedadSalida" character varying(255) NOT NULL,
    "T079fechaLlegadaRecorrido" TIMESTAMP WITH TIME ZONE not null,
    "T079novedadLlegada" character varying(255)
);

ALTER TABLE public."T079BitacoraViaje" OWNER TO postgres;




--****************************************************************
-- PRIMARY KEYS
--****************************************************************

ALTER TABLE ONLY public."T071VehiculosArrendados"
    ADD CONSTRAINT "PK_T071VehiculosArrendados" PRIMARY KEY ("T071IdVehiculoArrendado");


ALTER TABLE ONLY public."T072VehiculosAgendables_Conductor"
    ADD CONSTRAINT "PK_T072IdVehiculoConductor" PRIMARY KEY ("T072IdVehiculoConductor");


ALTER TABLE ONLY public."T073InspeccionesVehiculoDia"
    ADD CONSTRAINT "PK_T073IdInspeccionVehiculoDia" PRIMARY KEY ("T073IdInspeccionVehiculoDia");

ALTER TABLE ONLY public."T074VehiculosAgendados_DiaDisponible"
    ADD CONSTRAINT "PK_T074IdVehAgendaDia" PRIMARY KEY ("T074IdVehAgendaDia");

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "PK_T075IdSolicitudViaje" PRIMARY KEY ("T075IdSolicitudViaje");


ALTER TABLE ONLY public."T076Asignaciones_ViajeAgendado"
    ADD CONSTRAINT "PK_T076IdAsignacion_ViajeAgendado" PRIMARY KEY ("T076IdAsignacion_ViajeAgendado");


ALTER TABLE ONLY public."T077ViajesAgendados"
    ADD CONSTRAINT "PK_T077IdViajeAgendado" PRIMARY KEY ("T077IdViajeAgendado");


ALTER TABLE ONLY public."T078Compatibilidades_ViajesAgendados"
    ADD CONSTRAINT "PK_T078IdCompatibilidad" PRIMARY KEY ("T078IdCompatibilidad");


ALTER TABLE ONLY public."T079BitacoraViaje"
    ADD CONSTRAINT "PK_T079IdBitacoraViaje" PRIMARY KEY ("T079IdBitacoraViaje");


--****************************************************************
-- FOREIGN KEYS
--****************************************************************

ALTER TABLE ONLY public."T071VehiculosArrendados"
    ADD CONSTRAINT "FK_T071VehiculosArrendados_T071Id_Marca" FOREIGN KEY ("T071Id_Marca") REFERENCES public."T052Marcas"("T052IdMarca") NOT VALID;


-- Vehículos Agendables por Conductor

ALTER TABLE ONLY public."T072VehiculosAgendables_Conductor"
    ADD CONSTRAINT "FK_T072Conductores_VehiculosAgen_T072Id_PersonaActualizacionF" FOREIGN KEY ("T072Id_PersonaActualizacionFinal") REFERENCES public."T010Personas"("T010IdPersona") NOT VALID;



ALTER TABLE ONLY public."T072VehiculosAgendables_Conductor"
    ADD CONSTRAINT "FK_T072Conductores_VehiculosAgendable_T072Id_PersonaConductor" FOREIGN KEY ("T072Id_PersonaConductor") REFERENCES public."T010Personas"("T010IdPersona") NOT VALID;



ALTER TABLE ONLY public."T072VehiculosAgendables_Conductor"
    ADD CONSTRAINT "FK_T072Conductores_VehiculosAgendable_T072Id_PersonaQueAsigna" FOREIGN KEY ("T072Id_PersonaQueAsigna") REFERENCES public."T010Personas"("T010IdPersona") NOT VALID;


ALTER TABLE ONLY public."T072VehiculosAgendables_Conductor"
    ADD CONSTRAINT "FK_T072Conductores_VehiculosAgendable_T072Id_HojaDeVidaVehiculo" FOREIGN KEY ("T072Id_HojaDeVidaVehiculo") REFERENCES public."T066HojaDeVidaVehiculo"("T066IdHojaDeVida") NOT VALID;

--INSPECCIÓN VEHÍCULOS DIARIAMENTE

ALTER TABLE ONLY public."T073InspeccionesVehiculoDia"
    ADD CONSTRAINT "FK_T073Id_HojaDeVidaVehiculo" FOREIGN KEY ("T073Id_HojaDeVidaVehiculo") REFERENCES public."T066HojaDeVidaVehiculos"("T066IdHojaDeVida") NOT VALID;


ALTER TABLE ONLY public."T073InspeccionesVehiculoDia"
    ADD CONSTRAINT "FK_T073Id_PersonaQueInspecciona" FOREIGN KEY ("T073Id_PersonaQueInspecciona") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T073InspeccionesVehiculoDia"
    ADD CONSTRAINT "FK_T073Id_PersonaQueVerifica" FOREIGN KEY ("T073Id_PersonaQueVerifica") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

--VEHÍCULOS AGENDA DISPONIBILIDAD

ALTER TABLE ONLY public."T074VehiculosAgendados_DiaDisponible"
    ADD CONSTRAINT "FK_T074Id_HojaDeVidaVehiculo" FOREIGN KEY ("T074Id_HojaDeVidaVehiculo") REFERENCES public."T066HojaDeVidaVehiculos"("T066IdHojaDeVida") NOT VALID;


ALTER TABLE ONLY public."T074VehiculosAgendados_DiaDisponible"
    ADD CONSTRAINT "FK_T074Id_PersonaQueRegistra" FOREIGN KEY ("T074Id_PersonaQueRegistra") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T074VehiculosAgendados_DiaDisponible"
    ADD CONSTRAINT "FK_T074Id_ViajeAgendado" FOREIGN KEY ("T074Id_ViajeAgendado") REFERENCES public."TXX"("TTT")  NOT VALID;

--Solicitudes de viaje 

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "FK_T075Id_PersonaSolicita" FOREIGN KEY ("T075Id_PersonaSolicita") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "FK_T075Id_PersonaRechazaSolicitud" FOREIGN KEY ("T075Id_PersonaRechazaSolicitud") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "FK_T075Id_FuncionarioResponsable" FOREIGN KEY ("T075Id_FuncionarioResponsable") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "FK_T075Id_UnidadOrgSolicitante" FOREIGN KEY ("T075Id_UnidadOrgSolicitante") REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional")  NOT VALID;

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "FK_T075Id_UnidadOrgResponsable" FOREIGN KEY ("T075Id_UnidadOrgResponsable") REFERENCES public."T019UnidadesOrganizacionales"("T019IdUnidadOrganizacional")  NOT VALID;

ALTER TABLE ONLY public."T075SolicitudesViaje"
    ADD CONSTRAINT "FK_T075Id_PersonaCierraViaje" FOREIGN KEY ("T075Id_PersonaCierraViaje") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

--Asignaciones sobre viajes agendados 

ALTER TABLE ONLY public."T076Asignaciones_ViajeAgendado"
    ADD CONSTRAINT "FK_T076Id_ViajeAgendado" FOREIGN KEY ("T076Id_ViajeAgendado") REFERENCES public."TXX"("TZZZ")  NOT VALID;

ALTER TABLE ONLY public."T076Asignaciones_ViajeAgendado"
    ADD CONSTRAINT "FK_T076Id_SolicitudViaje" FOREIGN KEY ("T076Id_SolicitudViaje") REFERENCES public."TXX"("TZZZ")  NOT VALID;

ALTER TABLE ONLY public."T076Asignaciones_ViajeAgendado"
    ADD CONSTRAINT "FK_T076Id_PersonaAsigna" FOREIGN KEY ("T076Id_PersonaAsigna") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T076Asignaciones_ViajeAgendado"
    ADD CONSTRAINT "FK_T076Id_PersonaRechaza" FOREIGN KEY ("T076Id_PersonaRechaza") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;

ALTER TABLE ONLY public."T076Asignaciones_ViajeAgendado"
    ADD CONSTRAINT "FK_T076Id_PersonaAnula" FOREIGN KEY ("T076Id_PersonaAnula") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;


--VIAJES agendados 

ALTER TABLE ONLY public."T077ViajesAgendados"
    ADD CONSTRAINT "FK_T077Id_HojaDeVidaVehiculo" FOREIGN KEY ("T077Id_HojaDeVidaVehiculo") REFERENCES public."T066HojaDeVidaVehiculos"("T066IdHojaDeVida") NOT VALID;

ALTER TABLE ONLY public."T077ViajesAgendados"
    ADD CONSTRAINT "FK_T077Cod_MunicipioDestino" FOREIGN KEY ("T077Cod_MunicipioDestino") REFERENCES public."TXX"("TZZZ")  NOT VALID;

ALTER TABLE ONLY public."T077ViajesAgendados"
    ADD CONSTRAINT "FK_T077Id_PersonaAutoriza" FOREIGN KEY ("T077Id_PersonaAutoriza") REFERENCES public."T010Personas"("T010IdPersona")  NOT VALID;


-- Compatibilidad de viajes 

ALTER TABLE ONLY public."T078Compatibilidades_ViajesAgendados"
    ADD CONSTRAINT "FK_T078Id_ViajeAgendado" FOREIGN KEY ("T078Id_ViajeAgendado") REFERENCES public."TXX"("Tzzz")  NOT VALID;

ALTER TABLE ONLY public."T078Compatibilidades_ViajesAgendados"
    ADD CONSTRAINT "FK_T078Id_SolicitudViajeSugerido" FOREIGN KEY ("T078Id_SolicitudViajeSugerido") REFERENCES public."TXX"("TYY")  NOT VALID;


-- Bitacora de Viaje

ALTER TABLE ONLY public."T079BitacoraViaje"
    ADD CONSTRAINT "FK_T079Id_ViajeAgendado" FOREIGN KEY ("T079Id_ViajeAgendado") REFERENCES public."TXX"("Tzzz")  NOT VALID;

ALTER TABLE ONLY public."T079BitacoraViaje"
    ADD CONSTRAINT "FK_T079Id_ConductorQueParte" FOREIGN KEY ("T079Id_ConductorQueParte") REFERENCES public."TXX"("Tzzz")  NOT VALID;


/************************************************************************************
FIN    SECCIÓN Miguel Guevara - VEHICULOS TRANSPORTE
/************************************************************************************