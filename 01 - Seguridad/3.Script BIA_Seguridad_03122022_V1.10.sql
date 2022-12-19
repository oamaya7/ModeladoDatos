/****************************************************************
    Script de Creación de Base de Datos - Subsistema SEGURIDAD - Ultima Actualizacion 03/12/2022 - V1.10.
****************************************************************/


/****************************************************************
    CREACIÓN DE TIPOS DE DATOS PERSONALIZADOS eNUM.
****************************************************************/
CREATE TYPE public."eSubsistema" AS ENUM (
    'ALMA',     --ALMACÉN.
    'CONS',     --CONSERVACIÓN.
    'GEST',     --GESTOR DOCUMENTAL.
    'RECU',     --RECURSO HÍDRICO.
    'TRAM',     --TRAMITES Y SERVICIOS.
    'PLAN',     --SEGUIMIENTO A PLANES.
    'RECA',     --RECAUDO.
    'SEGU',     --SEGURIDAD Y AUDITORÍA.
    'TRSV'      --TRANSVERSALES.
);

ALTER TYPE public."eSubsistema" OWNER TO postgres;



CREATE TYPE public."eTipoDireccion" AS ENUM (
    'Res',
    'Lab',
    'Not'
);

ALTER TYPE public."eTipoDireccion" OWNER TO postgres;



CREATE TYPE public."eTipoPersona" AS ENUM (
    'N',
    'J'
);

ALTER TYPE public."eTipoPersona" OWNER TO postgres;



CREATE TYPE public."eTipoUsuario" AS ENUM (
    'I',
    'E'
);

ALTER TYPE public."eTipoUsuario" OWNER TO postgres;






SET default_tablespace = '';

SET default_table_access_method = heap;



/****************************************************************
    CREACIÓN DE TABLAS.
****************************************************************/
CREATE TABLE public."T001MunicipiosDepartamento" (
    "T001CodMunicipio" character(5) NOT NULL,
    "T001nombre" character varying(30) NOT NULL,
    "T001Cod_Departamento" character(2) NOT NULL
);

ALTER TABLE public."T001MunicipiosDepartamento" OWNER TO postgres;

ALTER TABLE ONLY public."T001MunicipiosDepartamento"
    ADD CONSTRAINT "PK_T001MunicipiosDepartamento" PRIMARY KEY ("T001CodMunicipio");

ALTER TABLE ONLY public."T001MunicipiosDepartamento"
    ADD CONSTRAINT "T001MunicipiosDepartamento_T001nombre_T001Cod_Departamento_UNQ" UNIQUE ("T001nombre", "T001Cod_Departamento")
        INCLUDE("T001nombre", "T001Cod_Departamento");


CREATE TABLE public."T002DepartamentosPais" (
    "T002CodDepartamento" character(2) NOT NULL,
    "T002nombre" character varying(50) NOT NULL,
    "T002Cod_Pais" character(2) NOT NULL
);

ALTER TABLE public."T002DepartamentosPais" OWNER TO postgres;

ALTER TABLE ONLY public."T002DepartamentosPais"
    ADD CONSTRAINT "PK_T002DepartamentosPais" PRIMARY KEY ("T002CodDepartamento");

ALTER TABLE ONLY public."T002DepartamentosPais"
    ADD CONSTRAINT "T002DepartamentosPais_T002nombre_UNQ" UNIQUE ("T002nombre")
        INCLUDE("T002nombre");


CREATE TABLE public."T003Paises" (
    "T003CodPais" character(2) NOT NULL,
    "T003nombre" character varying(50) NOT NULL
);

ALTER TABLE public."T003Paises" OWNER TO postgres;

ALTER TABLE ONLY public."T003Paises"
    ADD CONSTRAINT "PK_T003Paises" PRIMARY KEY ("T003CodPais");

ALTER TABLE ONLY public."T003Paises"
    ADD CONSTRAINT "T003Paises_T003nombre_UNQ" UNIQUE ("T003nombre")
        INCLUDE("T003nombre");


CREATE TABLE public."T004Sexo" (
    "T004CodSexo" character(1) NOT NULL,
    "T004nombre" character varying(20) NOT NULL
);

ALTER TABLE public."T004Sexo" OWNER TO postgres;

ALTER TABLE ONLY public."T004Sexo"
    ADD CONSTRAINT "PK_T004Sexo" PRIMARY KEY ("T004CodSexo");

ALTER TABLE ONLY public."T004Sexo"
    ADD CONSTRAINT "T004Sexo_T004nombre_UNQ" UNIQUE ("T004nombre")
        INCLUDE("T004nombre");


CREATE TABLE public."T005EstadoCivil" (
    "T005CodEstadoCivil" character(1) NOT NULL,
    "T005nombre" character varying(20) NOT NULL,
    "T005registroPrecargado" boolean NOT NULL,
    "T005activo" boolean NOT NULL DEFAULT TRUE,
    "T005itemYaUsado" boolean NOT NULL DEFAULT FALSE
);

ALTER TABLE public."T005EstadoCivil" OWNER TO postgres;

ALTER TABLE ONLY public."T005EstadoCivil"
    ADD CONSTRAINT "PK_T005EstadoCivil" PRIMARY KEY ("T005CodEstadoCivil");

ALTER TABLE ONLY public."T005EstadoCivil"
    ADD CONSTRAINT "T005EstadoCivil_T005nombre_UNQ" UNIQUE ("T005nombre")
        INCLUDE("T005nombre");


CREATE TABLE public."T006TiposDocumentoID" (
    "T006CodTipoDocumentoID" character(2) NOT NULL,
    "T006nombre" character varying(40) NOT NULL,
    "T006registroPrecargado" boolean NOT NULL,
    "T006activo" boolean NOT NULL DEFAULT TRUE,
    "T006itemYaUsado" boolean NOT NULL DEFAULT FALSE
);

ALTER TABLE public."T006TiposDocumentoID" OWNER TO postgres;

ALTER TABLE ONLY public."T006TiposDocumentoID"
    ADD CONSTRAINT "PK_T006TiposDocumentoID" PRIMARY KEY ("T006CodTipoDocumentoID");

ALTER TABLE ONLY public."T006TiposDocumentoID"
    ADD CONSTRAINT "T006TiposDocumentoID_T006nombre_UNQ" UNIQUE ("T006nombre")
        INCLUDE("T006nombre");


CREATE TABLE public."T007ClasesTercero" (
    "T007IdClaseTercero" smallint  GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 1) NOT NULL,
    "T007nombre" character varying(30) NOT NULL
);

ALTER TABLE public."T007ClasesTercero" OWNER TO postgres;

ALTER TABLE ONLY public."T007ClasesTercero"
    ADD CONSTRAINT "PK_T007ClasesTercero" PRIMARY KEY ("T007IdClaseTercero");

ALTER TABLE ONLY public."T007ClasesTercero"
    ADD CONSTRAINT "T007ClasesTercero_T007nombre_UNQ" UNIQUE ("T007nombre")
        INCLUDE("T007nombre");


CREATE TABLE public."T008OperacionesSobreUsuario" (
    "T008CodOperacion" character(1) NOT NULL,
    "T008nombre" character varying(20) NOT NULL
);

ALTER TABLE public."T008OperacionesSobreUsuario" OWNER TO postgres;

ALTER TABLE ONLY public."T008OperacionesSobreUsuario"
    ADD CONSTRAINT "PK_T008OperacionesSobreUsuario" PRIMARY KEY ("T008CodOperacion");

ALTER TABLE ONLY public."T008OperacionesSobreUsuario"
    ADD CONSTRAINT "T008OperacionesSobreUsuario_T008nombre_UNQ" UNIQUE ("T008nombre")
        INCLUDE("T008nombre");



CREATE TABLE public."T010Personas" (
    "T010IdPersona" integer GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 1) NOT NULL,
    "T010Cod_TipoDocumentoID" character(2) NOT NULL,
    "T010nroDocumentoID" character varying(20) NOT NULL,
    "T010digitoVerificacion" character(1),
    "T010TipoPersona" public."eTipoPersona" NOT NULL,
    "T010primerNombre" character varying(30),
    "T010segundoNombre" character varying(30),
    "T010primerApellido" character varying(30),
    "T010segundoApellido" character varying(30),
    "T010razonSocial" character varying(200),
    "T010nombreComercial" character varying(200),
    "T010dirResidencia" character varying(255),
    "T010dirResidenciaReferencia" character varying(255),
    "T010dirResidenciaGeoref" character varying,
    "T010Cod_MunicipioResidenciaNal" character(5),
    "T010Cod_PaisResidenciaExterior" character(2),
    "T010dirLaboralNal" character varying(255),
    "T010Cod_MunicipioLaboralNal" character(5),
    "T010dirNotificacionNal" character varying(255),
    "T010Cod_MunicipioNotificacionNal" character(5),
    "T010emailNotificacion" character varying(100),
    "T010emailEmpresarial" character varying(100),
    "T010telFijoResidencial" character varying(15),
    "T010telCelularPersona" character varying(15),
    "T010telEmpresa" character varying(15),
    "T010telCelularEmpresa" character varying(15),
    "T010telEmpresa2" character varying(15),
    "T010Cod_PaisNacionalidadDeEmpresa" character(2),
    "T010Id_PersonaRepLegal" integer,
    "T010fechaNacimiento" date,
    "T010Cod_PaisNacimiento" character(2),
    "T010Cod_Sexo" character(1),
    "T010Cod_EstadoCivil" character(1),
    "T010Id_Cargo" smallint,
    "T010Id_UnidadOrganizacionalActual" smallint,
    "T010fechaAsignacionUnidadOrg" timestamp with time zone,
    "T010esUnidadDeOrganigramaActual" boolean,
    "T010aceptaNotificacionSMS" boolean NOT NULL,
    "T010aceptaNotificacionEMail" boolean NOT NULL,
    "T010aceptaTratamientoDeDatos" boolean NOT NULL
);

ALTER TABLE public."T010Personas" OWNER TO postgres;

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "PK_T010Personas" PRIMARY KEY ("T010IdPersona");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "T010Personas_T010Cod_TipoDocumentoID_T010nroDocumentoID_UNQ" UNIQUE ("T010Cod_TipoDocumentoID", "T010nroDocumentoID")
        INCLUDE("T010Cod_TipoDocumentoID", "T010nroDocumentoID");


CREATE TABLE public."T011ClasesTercero_Persona" (
    "T011IdClasesTercero_Persona" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T011Id_Persona" integer NOT NULL,
    "T011Id_ClaseTercero" smallint NOT NULL
);

ALTER TABLE public."T011ClasesTercero_Persona" OWNER TO postgres;

ALTER TABLE ONLY public."T011ClasesTercero_Persona"
    ADD CONSTRAINT "PK_T011ClasesTercero_Persona" PRIMARY KEY ("T011IdClasesTercero_Persona");
    
ALTER TABLE ONLY public."T011ClasesTercero_Persona"
    ADD CONSTRAINT "T011ClasesTercero_UNQ" UNIQUE ("T011Id_Persona", "T011Id_ClaseTercero")
        INCLUDE("T011Id_Persona", "T011Id_ClaseTercero");


CREATE TABLE public."T012SucursalesEmpresa" (
    "T012IdSucursalesEmpresa" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T012Id_PersonaEmpresa" integer NOT NULL,
	"T012nroSucursal" smallint NOT NULL,
	"T012sucursal" character varying(255) NOT NULL,
	"T012dirSucursal" character varying(255) NOT NULL,
    "T012dirSucursalGeoref" character varying(255),
	"T012Cod_MunicipioSucursalNal" character(5),
	"T012Cod_PaisSucursalExterior" character(2),
    "T012dirNotificacionNal" character varying(255),
	"T012Cod_MunicipioNotificacionNal" character(5),
    "T012emailSucursal" character varying(100) NOT NULL,
    "T012telContactoSucursal" character varying(15),
	"T012esPrincipal" boolean
);

ALTER TABLE public."T012SucursalesEmpresa" OWNER TO postgres;

ALTER TABLE ONLY public."T012SucursalesEmpresa"
    ADD CONSTRAINT "PK_T012SucursalesEmpresa" PRIMARY KEY ("T012IdSucursalesEmpresa");
    
ALTER TABLE ONLY public."T012SucursalesEmpresa"
    ADD CONSTRAINT "T012SucursalesEmpresa_T012Id_PersonaEmpresa_T012nroSucursal_UNQ" UNIQUE ("T012Id_PersonaEmpresa", "T012nroSucursal")
        INCLUDE("T012Id_PersonaEmpresa", "T012nroSucursal");


CREATE TABLE public."T013Apoderados_Persona" (
    "T013IdApoderados_Persona" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T013Id_PersonaPoderdante" integer NOT NULL,
	"T013Id_PersonaApoderada" integer NOT NULL,
	"T013Id_Proceso" integer NOT NULL,
    "T013consecDelProceso" smallint NOT NULL,
	"T013fechaInicio" date NOT NULL,
    "T013fechaCierre" date
);

ALTER TABLE public."T013Apoderados_Persona" OWNER TO postgres;

ALTER TABLE ONLY public."T013Apoderados_Persona"
  ADD CONSTRAINT "PK_T013Apoderados_Persona" PRIMARY KEY ("T013IdApoderados_Persona");
  
ALTER TABLE ONLY public."T013Apoderados_Persona"
    ADD CONSTRAINT "T013Apoderados_Persona_UNQ" UNIQUE ("T013Id_PersonaPoderdante", "T013Id_PersonaApoderada", "T013Id_Proceso", "T013consecDelProceso")
        INCLUDE("T013Id_PersonaPoderdante", "T013Id_PersonaApoderada", "T013Id_Proceso", "T013consecDelProceso");


CREATE TABLE public."T014HistoricoActivacion" (
	"T014IdHistorico" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T014Id_UsuarioAfectado" integer NOT NULL,
    "T014Cod_Operacion" character(1) NOT NULL,
    "T014fechaOperacion" timestamp with time zone NOT NULL,
	"T014justificacion " character varying(255) NOT NULL,
    "T014Id_UsuarioOperador" integer NOT NULL
);

ALTER TABLE public."T014HistoricoActivacion" OWNER TO postgres;

ALTER TABLE ONLY public."T014HistoricoActivacion"
    ADD CONSTRAINT "PK_T014HistoricoActivacion" PRIMARY KEY ("T014IdHistorico");


CREATE TABLE public."T015HistoricoDirecciones" (
	"T015IdHistoDireccion" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T015Id_Persona" integer NOT NULL,
	"T015direccion" character varying(255) NOT NULL,
    "T015Cod_MunicipioEnCol" character(5),
    "T015Cod_PaisEnElExterior" character(2),
	"T015tipoDeDireccion" public."eTipoDireccion" NOT NULL,
    "T015fechaCambio" timestamp with time zone NOT NULL
);

ALTER TABLE public."T015HistoricoDirecciones" OWNER TO postgres;

ALTER TABLE ONLY public."T015HistoricoDirecciones"
    ADD CONSTRAINT "PK_T015HistoricoDirecciones" PRIMARY KEY ("T015IdHistoDireccion");


CREATE TABLE public."T016HistoricoEmails" (
	"T016IdHistoEmail" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
	"T016Id_Persona" integer NOT NULL,
    "T016emailDeNotificacion" character varying(100) NOT NULL,
    "T016fechaCambio" timestamp with time zone NOT NULL
);

ALTER TABLE public."T016HistoricoEmails" OWNER TO postgres;

ALTER TABLE ONLY public."T016HistoricoEmails"
    ADD CONSTRAINT "PK_T016HistoricoEmails" PRIMARY KEY ("T016IdHistoEmail");


CREATE TABLE public."TzPermisos" (
    "TzCodPermiso" character(2) NOT NULL,
    "Tznombre" character varying(20) NOT NULL
);

ALTER TABLE public."TzPermisos" OWNER TO postgres;

ALTER TABLE ONLY public."TzPermisos"
    ADD CONSTRAINT "PK_TzPermisos" PRIMARY KEY ("TzCodPermiso");

ALTER TABLE ONLY public."TzPermisos"
    ADD CONSTRAINT "TzPermisos_Tznombre_UNQ" UNIQUE ("Tznombre")
        INCLUDE("Tznombre");


CREATE TABLE public."TzModulos" (
	"TzIdModulo" smallint GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 1) NOT NULL,
	"Tznombre" character varying(70) NOT NULL,
    "Tzdescripcion" character varying(255) NOT NULL,
    "Tzsubsistema" public."eSubsistema" NOT NULL
);

ALTER TABLE public."TzModulos" OWNER TO postgres;

ALTER TABLE ONLY public."TzModulos"
    ADD CONSTRAINT "PK_TzModulos" PRIMARY KEY ("TzIdModulo");

ALTER TABLE ONLY public."TzModulos"
    ADD CONSTRAINT "TzModulos_Tznombre_UNQ" UNIQUE ("Tznombre")
        INCLUDE("Tznombre");


CREATE TABLE public."TzPermisos_Modulo" (
    "TzIdPermisos_Modulo" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "TzId_Modulo" smallint NOT NULL,
	"TzCod_Permiso" character(2) NOT NULL
);

ALTER TABLE public."TzPermisos_Modulo" OWNER TO postgres;

ALTER TABLE ONLY public."TzPermisos_Modulo"
    ADD CONSTRAINT "PK_TzPermisos_Modulo" PRIMARY KEY ("TzIdPermisos_Modulo");
   
ALTER TABLE ONLY public."TzPermisos_Modulo"
    ADD CONSTRAINT "TzPermisos_Modulo_TzId_Modulo_TzCod_Permiso_UNQ" UNIQUE ("TzId_Modulo", "TzCod_Permiso")
        INCLUDE("TzId_Modulo", "TzCod_Permiso");


CREATE TABLE public."TzRoles" (
    "TzIdRol" smallint GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 1) NOT NULL,
    "Tznombre" character varying(100) NOT NULL,
    "Tzdescripcion" character varying(255) NOT NULL,
    "TzrolDelSistema" boolean NOT NULL
);

ALTER TABLE public."TzRoles" OWNER TO postgres;

ALTER TABLE ONLY public."TzRoles"
    ADD CONSTRAINT "PK_TzRoles" PRIMARY KEY ("TzIdRol");

ALTER TABLE ONLY public."TzRoles"
    ADD CONSTRAINT "TzRoles_Tznombre_UNQ" UNIQUE ("Tznombre")
        INCLUDE("Tznombre");


CREATE TABLE public."TzPermisos_Modulo_Rol" (
    "TzIdPermisos_Modulo_Rol" smallint GENERATED ALWAYS AS IDENTITY (START WITH 20 INCREMENT BY 1) NOT NULL,
    "TzId_Rol" smallint NOT NULL,
    "TzId_Permisos_Modulo" smallint NOT NULL
);

ALTER TABLE public."TzPermisos_Modulo_Rol" OWNER TO postgres;

ALTER TABLE ONLY public."TzPermisos_Modulo_Rol"
    ADD CONSTRAINT "PK_TzIdPermisos_Modulo_Rol" PRIMARY KEY ("TzIdPermisos_Modulo_Rol");
    
ALTER TABLE ONLY public."TzPermisos_Modulo_Rol"
    ADD CONSTRAINT "TzPermisos_Modulo_Rol_TzId_Rol_TzId_Permisos_Modulo_UNQ" UNIQUE ("TzId_Rol", "TzId_Permisos_Modulo")
        INCLUDE("TzId_Rol", "TzId_Permisos_Modulo");


CREATE TABLE public."TzUsuarios" (
    "TzIdUsuario" integer GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 1) NOT NULL,
    "TznombreUsuario" character varying(30) NOT NULL,
    "TzId_Persona" integer NOT NULL,
    "Tzcontrasegna" character varying(255) NOT NULL,
    "Tzactivo" boolean NOT NULL,
    "Tzbloqueado" boolean NOT NULL,
    "TzcreadoPorPortal" boolean NOT NULL,
    "TzId_UsuarioCreador" integer NULL,
    "TzfechaCreacion" timestamp with time zone NOT NULL,
    "TzfechaActivacionInicial" timestamp with time zone,
    "TztipoUsuario" public."eTipoUsuario" NOT NULL,
    "TzrutaFoto" character varying(255)
);

ALTER TABLE public."TzUsuarios" OWNER TO postgres;

ALTER TABLE ONLY public."TzUsuarios"
    ADD CONSTRAINT "PK_TzUsuarios" PRIMARY KEY ("TzIdUsuario");
    
ALTER TABLE ONLY public."TzUsuarios"
    ADD CONSTRAINT "TzUsuarios_TznombreUsuario_UNQ" UNIQUE ("TznombreUsuario")
        INCLUDE("TznombreUsuario");

CREATE TABLE public."TzUsuarios_Rol" (
    "TzIdUsuarios_Rol" integer GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 1) NOT NULL,
    "TzId_Rol" integer NOT NULL,
    "TzId_Usuario" integer NOT NULL
);

ALTER TABLE public."TzUsuarios_Rol" OWNER TO postgres;

ALTER TABLE ONLY public."TzUsuarios_Rol"
    ADD CONSTRAINT "PK_TzIdUsuarios_Rol" PRIMARY KEY ("TzIdUsuarios_Rol");

ALTER TABLE ONLY public."TzUsuarios_Rol"
    ADD CONSTRAINT "TzUsuarios_Rol_TzId_Rol_TzId_Usuario_UNQ" UNIQUE ("TzId_Rol", "TzId_Usuario")
        INCLUDE("TzId_Rol", "TzId_Usuario");


CREATE TABLE public."TzLogin" (
    "TzIdLogin" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "TzId_Usuario" integer NOT NULL,
    "TzdirIP" Inet NOT NULL,
    "TzdispositivoConexion" character varying(30) NOT NULL,
    "TzfechaLogin" timestamp with time zone NOT NULL,
    "TzfechaCierreSesion" timestamp with time zone
);

ALTER TABLE public."TzLogin" OWNER TO postgres;

ALTER TABLE ONLY public."TzLogin"
    ADD CONSTRAINT "PK_TzLogin" PRIMARY KEY ("TzIdLogin");


CREATE TABLE public."TzLoginErroneo" (
    "TzIdLoginError" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "TzId_Usuario" integer NOT NULL,
    "TzdirIP" Inet NOT NULL,
    "TzdispositivoConexion" character varying(30) NOT NULL,
    "TzfechaLoginError" timestamp with time zone NOT NULL,
    "Tzcontador" smallint NOT NULL
);

ALTER TABLE public."TzLoginErroneo" OWNER TO postgres;

ALTER TABLE ONLY public."TzLoginErroneo"
    ADD CONSTRAINT "PK_TzLoginErroneo" PRIMARY KEY ("TzIdLoginError");

ALTER TABLE ONLY public."TzLoginErroneo"
    ADD CONSTRAINT "TzLoginErroneo_TzId_Usuario_UNQ" UNIQUE ("TzId_Usuario")
        INCLUDE("TzId_Usuario");


CREATE TABLE public."TzUsuarioErroneo" (
    "TzIdUsuarioError" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "TzcampoUsuario" character varying(30) NOT NULL,
    "TzdirIP" Inet NOT NULL,
    "TzdispositivoConexion" character varying(30) NOT NULL,
    "TzfechaLoginError" timestamp with time zone NOT NULL
);

ALTER TABLE public."TzUsuarioErroneo" OWNER TO postgres;

ALTER TABLE ONLY public."TzUsuarioErroneo"
    ADD CONSTRAINT "PK_TzUsuarioErroneo" PRIMARY KEY ("TzIdUsuarioError");


CREATE TABLE public."TzAuditorias" (
    "TzIdAuditoria" integer GENERATED ALWAYS AS IDENTITY NOT NULL,
    "TzId_Usuario" integer,
    "TzId_Modulo" smallint NOT NULL,
	"Tzsubsistema" public."eSubsistema" NOT NULL,
	"TzCod_PermisoAccion" character(2) NOT NULL,
    "TzfechaAccion" timestamp with time zone NOT NULL,
    "TzdirIp" Inet NOT NULL,
    "Tzdescripcion" text NOT NULL,
    "TzvaloresActualizados" text
);

ALTER TABLE public."TzAuditorias" OWNER TO postgres;

ALTER TABLE ONLY public."TzAuditorias"
    ADD CONSTRAINT "PK_TzAuditorias" PRIMARY KEY ("TzIdAuditoria");



/****************************************************************
 LAS FOREIGN KEYS
****************************************************************/
ALTER TABLE ONLY public."T001MunicipiosDepartamento"
    ADD CONSTRAINT "FK_T001MunicipiosDepartamento_T001Cod_Departamento" FOREIGN KEY ("T001Cod_Departamento") REFERENCES public."T002DepartamentosPais"("T002CodDepartamento");


ALTER TABLE ONLY public."T002DepartamentosPais"
    ADD CONSTRAINT "FK_T002DepartamentosPais_T002Cod_Pais" FOREIGN KEY ("T002Cod_Pais") REFERENCES public."T003Paises"("T003CodPais");


ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_EstadoCivil" FOREIGN KEY ("T010Cod_EstadoCivil") REFERENCES public."T005EstadoCivil"("T005CodEstadoCivil");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_MunicipioLaboralNal" FOREIGN KEY ("T010Cod_MunicipioLaboralNal") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_MunicipioNotificacionNal" FOREIGN KEY ("T010Cod_MunicipioNotificacionNal") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_MunicipioResidenciaNal" FOREIGN KEY ("T010Cod_MunicipioResidenciaNal") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_PaisNacimiento" FOREIGN KEY ("T010Cod_PaisNacimiento") REFERENCES public."T003Paises"("T003CodPais");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_PaisNacionalidadDeEmpresa" FOREIGN KEY ("T010Cod_PaisNacionalidadDeEmpresa") REFERENCES public."T003Paises"("T003CodPais");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_PaisResidenciaExterior" FOREIGN KEY ("T010Cod_PaisResidenciaExterior") REFERENCES public."T003Paises"("T003CodPais");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_Sexo" FOREIGN KEY ("T010Cod_Sexo") REFERENCES public."T004Sexo"("T004CodSexo");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Cod_TipoDocumentoID" FOREIGN KEY ("T010Cod_TipoDocumentoID") REFERENCES public."T006TiposDocumentoID"("T006CodTipoDocumentoID");

ALTER TABLE ONLY public."T010Personas"
    ADD CONSTRAINT "FK_T010Personas_T010Id_PersonaRepLegal" FOREIGN KEY ("T010Id_PersonaRepLegal") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."T011ClasesTercero_Persona"
    ADD CONSTRAINT "FK_T011ClasesTercero_Persona_T011Id_ClaseTercero" FOREIGN KEY ("T011Id_ClaseTercero") REFERENCES public."T007ClasesTercero"("T007IdClaseTercero");

ALTER TABLE ONLY public."T011ClasesTercero_Persona"
    ADD CONSTRAINT "FK_T011ClasesTercero_Persona_T011Id_Persona" FOREIGN KEY ("T011Id_Persona") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."T012SucursalesEmpresa"
    ADD CONSTRAINT "FK_T012SucursalesEmpresa_T012Id_PersonaEmpresa" FOREIGN KEY ("T012Id_PersonaEmpresa") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T012SucursalesEmpresa"
    ADD CONSTRAINT "FK_T012SucursalesEmpresa_T012Cod_MunicipioSucursalNal" FOREIGN KEY ("T012Cod_MunicipioSucursalNal") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T012SucursalesEmpresa"
    ADD CONSTRAINT "FK_T012SucursalesEmpresa_T012Cod_PaisSucursalExterior" FOREIGN KEY ("T012Cod_PaisSucursalExterior") REFERENCES public."T003Paises"("T003CodPais");

ALTER TABLE ONLY public."T012SucursalesEmpresa"
    ADD CONSTRAINT "FK_T012SucursalesEmpresa_T012Cod_MunicipioNotificacionNal" FOREIGN KEY ("T012Cod_MunicipioNotificacionNal") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");


ALTER TABLE ONLY public."T013Apoderados_Persona"
    ADD CONSTRAINT "FK_T013Apoderados_Persona_T013Id_PersonaPoderdante" FOREIGN KEY ("T013Id_PersonaPoderdante") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T013Apoderados_Persona"
    ADD CONSTRAINT "FK_T013Apoderados_Persona_T013Id_PersonaApoderada" FOREIGN KEY ("T013Id_PersonaApoderada") REFERENCES public."T010Personas"("T010IdPersona");

--NOTA: Falta la Foreign Key a la tabla de PROCESOS, dado que la tabla aún no está.


ALTER TABLE ONLY public."T014HistoricoActivacion"
    ADD CONSTRAINT "FK_T014HistoricoActivacion_T014Id_UsuarioAfectado" FOREIGN KEY ("T014Id_UsuarioAfectado") REFERENCES public."TzUsuarios"("TzIdUsuario");

ALTER TABLE ONLY public."T014HistoricoActivacion"
    ADD CONSTRAINT "FK_T014HistoricoActivacion_T014Cod_Operacion" FOREIGN KEY ("T014Cod_Operacion") REFERENCES public."T008OperacionesSobreUsuario"("T008CodOperacion");

ALTER TABLE ONLY public."T014HistoricoActivacion"
    ADD CONSTRAINT "FK_T014HistoricoActivacion_T014Id_UsuarioOperador" FOREIGN KEY ("T014Id_UsuarioOperador") REFERENCES public."TzUsuarios"("TzIdUsuario");


ALTER TABLE ONLY public."T015HistoricoDirecciones"
    ADD CONSTRAINT "FK_T015HistoricoDirecciones_T015Id_Persona" FOREIGN KEY ("T015Id_Persona") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."T015HistoricoDirecciones"
    ADD CONSTRAINT "FK_T015HistoricoDirecciones_T015Cod_MunicipioEnCol" FOREIGN KEY ("T015Cod_MunicipioEnCol") REFERENCES public."T001MunicipiosDepartamento"("T001CodMunicipio");

ALTER TABLE ONLY public."T015HistoricoDirecciones"
    ADD CONSTRAINT "FK_T015HistoricoDirecciones_T015Cod_PaisEnElExterior" FOREIGN KEY ("T015Cod_PaisEnElExterior") REFERENCES public."T003Paises"("T003CodPais");


ALTER TABLE ONLY public."T016HistoricoEmails"
    ADD CONSTRAINT "FK_T016HistoricoEmails_T016Id_Persona" FOREIGN KEY ("T016Id_Persona") REFERENCES public."T010Personas"("T010IdPersona");


ALTER TABLE ONLY public."TzAuditorias"
    ADD CONSTRAINT "FK_TzAuditorias_TzId_Usuario" FOREIGN KEY ("TzId_Usuario") REFERENCES public."TzUsuarios"("TzIdUsuario");

ALTER TABLE ONLY public."TzAuditorias"
    ADD CONSTRAINT "FK_TzAuditorias_TzId_Modulo" FOREIGN KEY ("TzId_Modulo") REFERENCES public."TzModulos"("TzIdModulo");

ALTER TABLE ONLY public."TzAuditorias"
    ADD CONSTRAINT "FK_TzAuditorias_TzCod_PermisoAccion" FOREIGN KEY ("TzCod_PermisoAccion") REFERENCES public."TzPermisos"("TzCodPermiso");


ALTER TABLE ONLY public."TzLogin"
    ADD CONSTRAINT "FK_TzLogin_TzId_Usuario" FOREIGN KEY ("TzId_Usuario") REFERENCES public."TzUsuarios"("TzIdUsuario");


ALTER TABLE ONLY public."TzLoginErroneo"
    ADD CONSTRAINT "FK_TzLoginErroneo_TzId_Usuario" FOREIGN KEY ("TzId_Usuario") REFERENCES public."TzUsuarios"("TzIdUsuario");


ALTER TABLE ONLY public."TzPermisos_Modulo"
    ADD CONSTRAINT "FK_TzPermisos_Modulo_TzId_Modulo" FOREIGN KEY ("TzId_Modulo") REFERENCES public."TzModulos"("TzIdModulo");

ALTER TABLE ONLY public."TzPermisos_Modulo"
    ADD CONSTRAINT "FK_TzPermisos_Modulo_TzCod_Permiso" FOREIGN KEY ("TzCod_Permiso") REFERENCES public."TzPermisos"("TzCodPermiso");


ALTER TABLE ONLY public."TzPermisos_Modulo_Rol"
    ADD CONSTRAINT "FK_TzPermisos_Modulo_Rol_TzId_Rol" FOREIGN KEY ("TzId_Rol") REFERENCES public."TzRoles"("TzIdRol");

ALTER TABLE ONLY public."TzPermisos_Modulo_Rol"
    ADD CONSTRAINT "FK_TzPermisos_Modulo_Rol_TzId_Permisos_Modulo" FOREIGN KEY ("TzId_Permisos_Modulo") REFERENCES public."TzPermisos_Modulo"("TzIdPermisos_Modulo");


ALTER TABLE ONLY public."TzUsuarios"
    ADD CONSTRAINT "FK_TzUsuarios_TzId_Persona" FOREIGN KEY ("TzId_Persona") REFERENCES public."T010Personas"("T010IdPersona");

ALTER TABLE ONLY public."TzUsuarios"
    ADD CONSTRAINT "FK_TzUsuarios_TzId_UsuarioCreador" FOREIGN KEY ("TzId_UsuarioCreador") REFERENCES public."TzUsuarios"("TzIdUsuario");


ALTER TABLE ONLY public."TzUsuarios_Rol"
    ADD CONSTRAINT "FK_TzUsuarios_Rol_TzId_Rol" FOREIGN KEY ("TzId_Rol") REFERENCES public."TzRoles"("TzIdRol");

ALTER TABLE ONLY public."TzUsuarios_Rol"
    ADD CONSTRAINT "FK_TzUsuarios_Rol_TzId_Usuario" FOREIGN KEY ("TzId_Usuario") REFERENCES public."TzUsuarios"("TzIdUsuario");



/****************************************************************
    INSERCIÓN DE DATOS INICIALES.
****************************************************************/
-- PAÍSES.
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AD', 'Andorra');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AE', 'Emiratos Árabes Unidos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AF', 'Afganistán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AG', 'Antigua y Barbuda');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AI', 'Anguila');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AL', 'Albania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AM', 'Armenia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AN', 'Antillas Neerlandesas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AO', 'Angola');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AQ', 'Antártida');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AR', 'Argentina');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AS', 'Samoa Americana');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AT', 'Austria');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AU', 'Australia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AW', 'Aruba');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AX', 'Islas Áland');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('AZ', 'Azerbaiyán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BA', 'Bosnia y Herzegovina');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BB', 'Barbados');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BD', 'Bangladesh');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BE', 'Bélgica');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BF', 'Burkina Faso');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BG', 'Bulgaria');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BH', 'Bahréin');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BI', 'Burundi');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BJ', 'Benin');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BL', 'San Bartolomé');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BM', 'Bermudas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BN', 'Brunéi');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BO', 'Bolivia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BR', 'Brasil');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BS', 'Bahamas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BT', 'Bhután');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BV', 'Isla Bouvet');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BW', 'Botsuana');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BY', 'Belarús');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('BZ', 'Belice');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CA', 'Canadá');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CC', 'Islas Cocos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CF', 'República Centro-Africana');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CG', 'Congo');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CH', 'Suiza');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CI', 'Costa de Marfil');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CK', 'Islas Cook');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CL', 'Chile');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CM', 'Camerún');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CN', 'China');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CO', 'Colombia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CR', 'Costa Rica');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CU', 'Cuba');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CV', 'Cabo Verde');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CX', 'Islas Christmas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CY', 'Chipre');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('CZ', 'República Checa');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('DE', 'Alemania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('DJ', 'Yibuti');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('DK', 'Dinamarca');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('DM', 'Domínica');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('DO', 'República Dominicana');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('DZ', 'Argel');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('EC', 'Ecuador');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('EE', 'Estonia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('EG', 'Egipto');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('EH', 'Sahara Occidental');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ER', 'Eritrea');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ES', 'España');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ET', 'Etiopía');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('FI', 'Finlandia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('FJ', 'Fiji');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('FK', 'Islas Malvinas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('FM', 'Micronesia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('FO', 'Islas Faroe');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('FR', 'Francia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GA', 'Gabón');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GB', 'Reino Unido');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GD', 'Granada');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GE', 'Georgia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GF', 'Guayana Francesa');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GG', 'Guernsey');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GH', 'Ghana');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GI', 'Gibraltar');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GL', 'Groenlandia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GM', 'Gambia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GN', 'Guinea');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GP', 'Guadalupe');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GQ', 'Guinea Ecuatorial');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GR', 'Grecia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GS', 'Georgia del Sur e Islas Sandwich del Sur');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GT', 'Guatemala');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GU', 'Guam');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GW', 'Guinea-Bissau');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('GY', 'Guayana');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('HK', 'Hong Kong');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('HM', 'Islas Heard y McDonald');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('HN', 'Honduras');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('HR', 'Croacia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('HT', 'Haití');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('HU', 'Hungría');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ID', 'Indonesia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IE', 'Irlanda');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IL', 'Israel');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IM', 'Isla de Man');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IN', 'India');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IO', 'Territorio Británico del Océano Índico');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IQ', 'Irak');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IR', 'Irán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IS', 'Islandia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('IT', 'Italia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('JE', 'Jersey');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('JM', 'Jamaica');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('JO', 'Jordania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('JP', 'Japón');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KE', 'Kenia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KG', 'Kirguistán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KH', 'Camboya');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KI', 'Kiribati');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KM', 'Comoros');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KN', 'San Cristóbal y Nieves');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KP', 'Corea del Norte');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KR', 'Corea del Sur');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KW', 'Kuwait');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KY', 'Islas Caimán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('KZ', 'Kazajstán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LA', 'Laos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LB', 'Líbano');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LC', 'Santa Lucía');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LI', 'Liechtenstein');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LK', 'Sri Lanka');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LR', 'Liberia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LS', 'Lesotho');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LT', 'Lituania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LU', 'Luxemburgo');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LV', 'Letonia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('LY', 'Libia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MA', 'Marruecos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MC', 'Mónaco');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MD', 'Moldova');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ME', 'Montenegro');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MG', 'Madagascar');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MH', 'Islas Marshall');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MK', 'Macedonia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ML', 'Mali');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MM', 'Myanmar');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MN', 'Mongolia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MO', 'Macao');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MQ', 'Martinica');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MR', 'Mauritania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MS', 'Montserrat');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MT', 'Malta');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MU', 'Mauricio');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MV', 'Maldivas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MW', 'Malawi');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MX', 'México');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MY', 'Malasia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('MZ', 'Mozambique');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NA', 'Namibia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NC', 'Nueva Caledonia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NE', 'Níger');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NF', 'Islas Norkfolk');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NG', 'Nigeria');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NI', 'Nicaragua');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NL', 'Países Bajos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NO', 'Noruega');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NP', 'Nepal');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NR', 'Nauru');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NU', 'Niue');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('NZ', 'Nueva Zelanda');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('OM', 'Omán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PA', 'Panamá');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PE', 'Perú');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PF', 'Polinesia Francesa');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PG', 'Papúa Nueva Guinea');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PH', 'Filipinas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PK', 'Pakistán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PL', 'Polonia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PM', 'San Pedro y Miquelón');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PN', 'Islas Pitcairn');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PR', 'Puerto Rico');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PS', 'Palestina');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PT', 'Portugal');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PW', 'Islas Palaos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('PY', 'Paraguay');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('QA', 'Qatar');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('RE', 'Reunión');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('RO', 'Rumanía');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('RS', 'Serbia y Montenegro');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('RU', 'Rusia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('RW', 'Ruanda');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SA', 'Arabia Saudita');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SB', 'Islas Solomón');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SC', 'Seychelles');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SD', 'Sudán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SE', 'Suecia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SG', 'Singapur');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SH', 'Santa Elena');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SI', 'Eslovenia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SJ', 'Islas Svalbard y Jan Mayen');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SK', 'Eslovaquia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SL', 'Sierra Leona');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SM', 'San Marino');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SN', 'Senegal');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SO', 'Somalia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SR', 'Surinam');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ST', 'Santo Tomé y Príncipe');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SV', 'El Salvador');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SY', 'Siria');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('SZ', 'Suazilandia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TC', 'Islas Turcas y Caicos');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TD', 'Chad');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TF', 'Territorios Australes Franceses');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TG', 'Togo');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TH', 'Tailandia');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TZ', 'Tanzania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TJ', 'Tayikistán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TK', 'Tokelau');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TL', 'Timor-Leste');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TM', 'Turkmenistán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TN', 'Túnez');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TO', 'Tonga');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TR', 'Turquía');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TT', 'Trinidad y Tobago');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TV', 'Tuvalu');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('TW', 'Taiwán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('UA', 'Ucrania');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('UG', 'Uganda');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('US', 'Estados Unidos de América');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('UY', 'Uruguay');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('UZ', 'Uzbekistán');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VA', 'Ciudad del Vaticano');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VC', 'San Vicente y las Granadinas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VE', 'Venezuela');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VG', 'Islas Vírgenes Británicas');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VI', 'Islas Vírgenes de los Estados Unidos de América');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VN', 'Vietnam');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('VU', 'Vanuatu');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('WF', 'Wallis y Futuna');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('WS', 'Samoa');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('YE', 'Yemen');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('YT', 'Mayotte');
INSERT INTO public."T003Paises" ("T003CodPais", "T003nombre") VALUES ('ZA', 'Sudáfrica');

-- DEPARTAMENTOS DE COLOMBIA.
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('11', 'BOGOTÁ. D.C.', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('13', 'BOLÍVAR', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('15', 'BOYACÁ', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('17', 'CALDAS', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('18', 'CAQUETÁ', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('19', 'CAUCA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('20', 'CESAR', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('23', 'CÓRDOBA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('25', 'CUNDINAMARCA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('27', 'CHOCÓ', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('41', 'HUILA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('44', 'LA GUAJIRA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('47', 'MAGDALENA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('50', 'META', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('52', 'NARIÑO', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('54', 'NORTE DE SANTANDER', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('63', 'QUINDÍO', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('66', 'RISARALDA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('68', 'SANTANDER', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('70', 'SUCRE', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('73', 'TOLIMA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('76', 'VALLE DEL CAUCA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('81', 'ARAUCA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('85', 'CASANARE', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('86', 'PUTUMAYO', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('88', 'SAN ANDRÉS, PROVIDENCIA Y SANTA CATALINA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('91', 'AMAZONAS', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('94', 'GUAINÍA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('95', 'GUAVIARE', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('97', 'VAUPÉS', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('99', 'VICHADA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('05', 'ANTIOQUIA', 'CO');
INSERT INTO public."T002DepartamentosPais" ("T002CodDepartamento", "T002nombre", "T002Cod_Pais") VALUES ('08', 'ATLÁNTICO', 'CO');

-- MUNICIPIOS DE LOS DEPARTAMENTOS DE COLOMBIA.
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('11001', 'BOGOTÁ. D.C.', '11');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13001', 'CARTAGENA DE INDIAS', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13006', 'ACHÍ', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13030', 'ALTOS DEL ROSARIO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13042', 'ARENAL', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13052', 'ARJONA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13062', 'ARROYOHONDO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13074', 'BARRANCO DE LOBA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13140', 'CALAMAR', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13160', 'CANTAGALLO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13188', 'CICUCO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13212', 'CÓRDOBA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13222', 'CLEMENCIA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13244', 'EL CARMEN DE BOLÍVAR', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13248', 'EL GUAMO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13268', 'EL PEÑÓN', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13300', 'HATILLO DE LOBA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13430', 'MAGANGUÉ', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13433', 'MAHATES', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13440', 'MARGARITA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13442', 'MARÍA LA BAJA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13458', 'MONTECRISTO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13468', 'SANTA CRUZ DE MOMPOX', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13473', 'MORALES', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13490', 'NOROSÍ', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13549', 'PINILLOS', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13580', 'REGIDOR', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13600', 'RÍO VIEJO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13620', 'SAN CRISTÓBAL', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13647', 'SAN ESTANISLAO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13650', 'SAN FERNANDO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13654', 'SAN JACINTO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13655', 'SAN JACINTO DEL CAUCA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13657', 'SAN JUAN NEPOMUCENO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13667', 'SAN MARTÍN DE LOBA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13670', 'SAN PABLO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13673', 'SANTA CATALINA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13683', 'SANTA ROSA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13688', 'SANTA ROSA DEL SUR', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13744', 'SIMITÍ', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13760', 'SOPLAVIENTO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13780', 'TALAIGUA NUEVO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13810', 'TIQUISIO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13836', 'TURBACO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13838', 'TURBANÁ', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13873', 'VILLANUEVA', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('13894', 'ZAMBRANO', '13');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15001', 'TUNJA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15022', 'ALMEIDA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15047', 'AQUITANIA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15051', 'ARCABUCO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15087', 'BELÉN', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15090', 'BERBEO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15092', 'BETÉITIVA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15097', 'BOAVITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15104', 'BOYACÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15106', 'BRICEÑO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15109', 'BUENAVISTA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15114', 'BUSBANZÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15131', 'CALDAS', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15135', 'CAMPOHERMOSO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15162', 'CERINZA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15172', 'CHINAVITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15176', 'CHIQUINQUIRÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15180', 'CHISCAS', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15183', 'CHITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15185', 'CHITARAQUE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15187', 'CHIVATÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15189', 'CIÉNEGA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15204', 'CÓMBITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15212', 'COPER', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15215', 'CORRALES', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15218', 'COVARACHÍA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15223', 'CUBARÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15224', 'CUCAITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15226', 'CUÍTIVA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15232', 'CHÍQUIZA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15236', 'CHIVOR', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15238', 'DUITAMA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15244', 'EL COCUY', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15248', 'EL ESPINO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15272', 'FIRAVITOBA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15276', 'FLORESTA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15293', 'GACHANTIVÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15296', 'GÁMEZA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15299', 'GARAGOA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15317', 'GUACAMAYAS', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15322', 'GUATEQUE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15325', 'GUAYATÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15332', 'GÜICÁN DE LA SIERRA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15362', 'IZA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15367', 'JENESANO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15368', 'JERICÓ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15377', 'LABRANZAGRANDE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15380', 'LA CAPILLA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15401', 'LA VICTORIA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15403', 'LA UVITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15407', 'VILLA DE LEYVA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15425', 'MACANAL', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15442', 'MARIPÍ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15455', 'MIRAFLORES', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15464', 'MONGUA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15466', 'MONGUÍ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15469', 'MONIQUIRÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15476', 'MOTAVITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15480', 'MUZO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15491', 'NOBSA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15494', 'NUEVO COLÓN', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15500', 'OICATÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15507', 'OTANCHE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15511', 'PACHAVITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15514', 'PÁEZ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15516', 'PAIPA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15518', 'PAJARITO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15522', 'PANQUEBA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15531', 'PAUNA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15533', 'PAYA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15537', 'PAZ DE RÍO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15542', 'PESCA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15550', 'PISBA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15572', 'PUERTO BOYACÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15580', 'QUÍPAMA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15599', 'RAMIRIQUÍ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15600', 'RÁQUIRA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15621', 'RONDÓN', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15632', 'SABOYÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15638', 'SÁCHICA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15646', 'SAMACÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15660', 'SAN EDUARDO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15664', 'SAN JOSÉ DE PARE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15667', 'SAN LUIS DE GACENO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15673', 'SAN MATEO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15676', 'SAN MIGUEL DE SEMA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15681', 'SAN PABLO DE BORBUR', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15686', 'SANTANA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15690', 'SANTA MARÍA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15693', 'SANTA ROSA DE VITERBO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15696', 'SANTA SOFÍA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15720', 'SATIVANORTE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15723', 'SATIVASUR', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15740', 'SIACHOQUE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15753', 'SOATÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15755', 'SOCOTÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15757', 'SOCHA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15759', 'SOGAMOSO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15761', 'SOMONDOCO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15762', 'SORA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15763', 'SOTAQUIRÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15764', 'SORACÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15774', 'SUSACÓN', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15776', 'SUTAMARCHÁN', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15778', 'SUTATENZA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15790', 'TASCO', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15798', 'TENZA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15804', 'TIBANÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15806', 'TIBASOSA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15808', 'TINJACÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15810', 'TIPACOQUE', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15814', 'TOCA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15816', 'TOGÜÍ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15820', 'TÓPAGA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15822', 'TOTA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15832', 'TUNUNGUÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15835', 'TURMEQUÉ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15837', 'TUTA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15839', 'TUTAZÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15842', 'ÚMBITA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15861', 'VENTAQUEMADA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15879', 'VIRACACHÁ', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('15897', 'ZETAQUIRA', '15');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17001', 'MANIZALES', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17013', 'AGUADAS', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17042', 'ANSERMA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17050', 'ARANZAZU', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17088', 'BELALCÁZAR', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17174', 'CHINCHINÁ', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17272', 'FILADELFIA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17380', 'LA DORADA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17388', 'LA MERCED', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17433', 'MANZANARES', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17442', 'MARMATO', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17444', 'MARQUETALIA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17446', 'MARULANDA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17486', 'NEIRA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17495', 'NORCASIA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17513', 'PÁCORA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17524', 'PALESTINA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17541', 'PENSILVANIA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17614', 'RIOSUCIO', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17616', 'RISARALDA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17653', 'SALAMINA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17662', 'SAMANÁ', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17665', 'SAN JOSÉ', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17777', 'SUPÍA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17867', 'VICTORIA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17873', 'VILLAMARÍA', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('17877', 'VITERBO', '17');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18001', 'FLORENCIA', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18029', 'ALBANIA', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18094', 'BELÉN DE LOS ANDAQUÍES', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18150', 'CARTAGENA DEL CHAIRÁ', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18205', 'CURILLO', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18247', 'EL DONCELLO', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18256', 'EL PAUJÍL', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18410', 'LA MONTAÑITA', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18460', 'MILÁN', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18479', 'MORELIA', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18592', 'PUERTO RICO', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18610', 'SAN JOSÉ DEL FRAGUA', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18753', 'SAN VICENTE DEL CAGUÁN', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18756', 'SOLANO', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18785', 'SOLITA', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('18860', 'VALPARAÍSO', '18');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19318', 'GUAPI', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19001', 'POPAYÁN', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19022', 'ALMAGUER', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19050', 'ARGELIA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19075', 'BALBOA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19100', 'BOLÍVAR', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19110', 'BUENOS AIRES', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19130', 'CAJIBÍO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19137', 'CALDONO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19142', 'CALOTO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19212', 'CORINTO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19256', 'EL TAMBO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19290', 'FLORENCIA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19300', 'GUACHENÉ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19355', 'INZÁ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19364', 'JAMBALÓ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19392', 'LA SIERRA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19397', 'LA VEGA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19418', 'LÓPEZ DE MICAY', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19450', 'MERCADERES', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19455', 'MIRANDA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19473', 'MORALES', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19513', 'PADILLA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19517', 'PÁEZ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19532', 'PATÍA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19533', 'PIAMONTE', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19548', 'PIENDAMÓ - TUNÍA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19573', 'PUERTO TEJADA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19585', 'PURACÉ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19622', 'ROSAS', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19693', 'SAN SEBASTIÁN', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19698', 'SANTANDER DE QUILICHAO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19701', 'SANTA ROSA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19743', 'SILVIA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19760', 'SOTARÁ PAISPAMBA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19780', 'SUÁREZ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19785', 'SUCRE', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19807', 'TIMBÍO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19809', 'TIMBIQUÍ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19821', 'TORIBÍO', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19824', 'TOTORÓ', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('19845', 'VILLA RICA', '19');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20001', 'VALLEDUPAR', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20011', 'AGUACHICA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20013', 'AGUSTÍN CODAZZI', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20032', 'ASTREA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20045', 'BECERRIL', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20060', 'BOSCONIA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20175', 'CHIMICHAGUA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20178', 'CHIRIGUANÁ', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20228', 'CURUMANÍ', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20238', 'EL COPEY', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20250', 'EL PASO', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20295', 'GAMARRA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20310', 'GONZÁLEZ', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20383', 'LA GLORIA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20400', 'LA JAGUA DE IBIRICO', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20443', 'MANAURE BALCÓN DEL CESAR', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20517', 'PAILITAS', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20550', 'PELAYA', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20570', 'PUEBLO BELLO', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20614', 'RÍO DE ORO', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20621', 'LA PAZ', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20710', 'SAN ALBERTO', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20750', 'SAN DIEGO', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20770', 'SAN MARTÍN', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('20787', 'TAMALAMEQUE', '20');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23001', 'MONTERÍA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23068', 'AYAPEL', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23079', 'BUENAVISTA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23090', 'CANALETE', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23162', 'CERETÉ', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23168', 'CHIMÁ', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23182', 'CHINÚ', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23189', 'CIÉNAGA DE ORO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23300', 'COTORRA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23350', 'LA APARTADA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23417', 'LORICA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23419', 'LOS CÓRDOBAS', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23464', 'MOMIL', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23466', 'MONTELÍBANO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23500', 'MOÑITOS', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23555', 'PLANETA RICA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23570', 'PUEBLO NUEVO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23574', 'PUERTO ESCONDIDO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23580', 'PUERTO LIBERTADOR', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23586', 'PURÍSIMA DE LA CONCEPCIÓN', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23660', 'SAHAGÚN', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23670', 'SAN ANDRÉS DE SOTAVENTO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23672', 'SAN ANTERO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23675', 'SAN BERNARDO DEL VIENTO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23678', 'SAN CARLOS', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23682', 'SAN JOSÉ DE URÉ', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23686', 'SAN PELAYO', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23807', 'TIERRALTA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23815', 'TUCHÍN', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('23855', 'VALENCIA', '23');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25001', 'AGUA DE DIOS', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25019', 'ALBÁN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25035', 'ANAPOIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25040', 'ANOLAIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25053', 'ARBELÁEZ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25086', 'BELTRÁN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25095', 'BITUIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25099', 'BOJACÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25120', 'CABRERA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25123', 'CACHIPAY', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25126', 'CAJICÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25148', 'CAPARRAPÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25151', 'CÁQUEZA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25154', 'CARMEN DE CARUPA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25168', 'CHAGUANÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25175', 'CHÍA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25178', 'CHIPAQUE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25181', 'CHOACHÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25183', 'CHOCONTÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25200', 'COGUA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25214', 'COTA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25224', 'CUCUNUBÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25245', 'EL COLEGIO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25258', 'EL PEÑÓN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25260', 'EL ROSAL', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25269', 'FACATATIVÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25279', 'FÓMEQUE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25281', 'FOSCA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25286', 'FUNZA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25288', 'FÚQUENE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25290', 'FUSAGASUGÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25293', 'GACHALÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25295', 'GACHANCIPÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25297', 'GACHETÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25299', 'GAMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25307', 'GIRARDOT', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25312', 'GRANADA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25317', 'GUACHETÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25320', 'GUADUAS', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25322', 'GUASCA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25324', 'GUATAQUÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25326', 'GUATAVITA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25328', 'GUAYABAL DE SÍQUIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25335', 'GUAYABETAL', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25339', 'GUTIÉRREZ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25368', 'JERUSALÉN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25372', 'JUNÍN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25377', 'LA CALERA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25386', 'LA MESA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25394', 'LA PALMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25398', 'LA PEÑA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25402', 'LA VEGA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25407', 'LENGUAZAQUE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25426', 'MACHETÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25430', 'MADRID', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25436', 'MANTA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25438', 'MEDINA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25473', 'MOSQUERA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25483', 'NARIÑO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25486', 'NEMOCÓN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25488', 'NILO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25489', 'NIMAIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25491', 'NOCAIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25506', 'VENECIA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25513', 'PACHO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25518', 'PAIME', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25524', 'PANDI', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25530', 'PARATEBUENO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25535', 'PASCA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25572', 'PUERTO SALGAR', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25580', 'PULÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25592', 'QUEBRADANEGRA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25594', 'QUETAME', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25596', 'QUIPILE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25599', 'APULO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25612', 'RICAURTE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25645', 'SAN ANTONIO DEL TEQUENDAMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25649', 'SAN BERNARDO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25653', 'SAN CAYETANO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25658', 'SAN FRANCISCO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25662', 'SAN JUAN DE RIOSECO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25718', 'SASAIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25736', 'SESQUILÉ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25740', 'SIBATÉ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25743', 'SILVANIA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25745', 'SIMIJACA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25754', 'SOACHA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25758', 'SOPÓ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25769', 'SUBACHOQUE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25772', 'SUESCA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25777', 'SUPATÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25779', 'SUSA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25781', 'SUTATAUSA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25785', 'TABIO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25793', 'TAUSA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25797', 'TENA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25799', 'TENJO', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25805', 'TIBACUY', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25807', 'TIBIRITA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25815', 'TOCAIMA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25817', 'TOCANCIPÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25823', 'TOPAIPÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25839', 'UBALÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25841', 'UBAQUE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25843', 'VILLA DE SAN DIEGO DE UBATÉ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25845', 'UNE', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25851', 'ÚTICA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25862', 'VERGARA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25867', 'VIANÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25871', 'VILLAGÓMEZ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25873', 'VILLAPINZÓN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25875', 'VILLETA', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25878', 'VIOTÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25885', 'YACOPÍ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25898', 'ZIPACÓN', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('25899', 'ZIPAQUIRÁ', '25');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27001', 'QUIBDÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27006', 'ACANDÍ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27025', 'ALTO BAUDÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27050', 'ATRATO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27073', 'BAGADÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27075', 'BAHÍA SOLANO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27077', 'BAJO BAUDÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27099', 'BOJAYÁ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27135', 'EL CANTÓN DEL SAN PABLO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27150', 'CARMEN DEL DARIÉN', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27160', 'CÉRTEGUI', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27205', 'CONDOTO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27245', 'EL CARMEN DE ATRATO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27250', 'EL LITORAL DEL SAN JUAN', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27361', 'ISTMINA', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27372', 'JURADÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27413', 'LLORÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27425', 'MEDIO ATRATO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27430', 'MEDIO BAUDÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27450', 'MEDIO SAN JUAN', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27491', 'NÓVITA', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27495', 'NUQUÍ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27580', 'RÍO IRÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27600', 'RÍO QUITO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27615', 'RIOSUCIO', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27660', 'SAN JOSÉ DEL PALMAR', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27745', 'SIPÍ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27787', 'TADÓ', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27800', 'UNGUÍA', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('27810', 'UNIÓN PANAMERICANA', '27');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41001', 'NEIVA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41006', 'ACEVEDO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41013', 'AGRADO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41016', 'AIPE', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41020', 'ALGECIRAS', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41026', 'ALTAMIRA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41078', 'BARAYA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41132', 'CAMPOALEGRE', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41206', 'COLOMBIA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41244', 'ELÍAS', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41298', 'GARZÓN', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41306', 'GIGANTE', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41319', 'GUADALUPE', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41349', 'HOBO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41357', 'ÍQUIRA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41359', 'ISNOS', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41378', 'LA ARGENTINA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41396', 'LA PLATA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41483', 'NÁTAGA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41503', 'OPORAPA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41518', 'PAICOL', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41524', 'PALERMO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41530', 'PALESTINA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41548', 'PITAL', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41551', 'PITALITO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41615', 'RIVERA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41660', 'SALADOBLANCO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41668', 'SAN AGUSTÍN', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41676', 'SANTA MARÍA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41770', 'SUAZA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41791', 'TARQUI', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41797', 'TESALIA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41799', 'TELLO', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41801', 'TERUEL', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41807', 'TIMANÁ', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41872', 'VILLAVIEJA', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('41885', 'YAGUARÁ', '41');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44001', 'RIOHACHA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44035', 'ALBANIA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44078', 'BARRANCAS', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44090', 'DIBULLA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44098', 'DISTRACCIÓN', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44110', 'EL MOLINO', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44279', 'FONSECA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44378', 'HATONUEVO', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44420', 'LA JAGUA DEL PILAR', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44430', 'MAICAO', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44560', 'MANAURE', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44650', 'SAN JUAN DEL CESAR', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44847', 'URIBIA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44855', 'URUMITA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('44874', 'VILLANUEVA', '44');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47001', 'SANTA MARTA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47030', 'ALGARROBO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47053', 'ARACATACA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47058', 'ARIGUANÍ', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47161', 'CERRO DE SAN ANTONIO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47170', 'CHIVOLO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47189', 'CIÉNAGA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47205', 'CONCORDIA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47245', 'EL BANCO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47258', 'EL PIÑÓN', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47268', 'EL RETÉN', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47288', 'FUNDACIÓN', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47318', 'GUAMAL', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47460', 'NUEVA GRANADA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47541', 'PEDRAZA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47545', 'PIJIÑO DEL CARMEN', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47551', 'PIVIJAY', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47555', 'PLATO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47570', 'PUEBLOVIEJO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47605', 'REMOLINO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47660', 'SABANAS DE SAN ÁNGEL', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47675', 'SALAMINA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47692', 'SAN SEBASTIÁN DE BUENAVISTA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47703', 'SAN ZENÓN', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47707', 'SANTA ANA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47720', 'SANTA BÁRBARA DE PINTO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47745', 'SITIONUEVO', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47798', 'TENERIFE', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47960', 'ZAPAYÁN', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('47980', 'ZONA BANANERA', '47');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50001', 'VILLAVICENCIO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50006', 'ACACÍAS', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50110', 'BARRANCA DE UPÍA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50124', 'CABUYARO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50150', 'CASTILLA LA NUEVA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50223', 'CUBARRAL', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50226', 'CUMARAL', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50245', 'EL CALVARIO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50251', 'EL CASTILLO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50270', 'EL DORADO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50287', 'FUENTE DE ORO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50313', 'GRANADA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50318', 'GUAMAL', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50325', 'MAPIRIPÁN', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50330', 'MESETAS', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50350', 'LA MACARENA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50370', 'URIBE', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50400', 'LEJANÍAS', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50450', 'PUERTO CONCORDIA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50568', 'PUERTO GAITÁN', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50573', 'PUERTO LÓPEZ', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50577', 'PUERTO LLERAS', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50590', 'PUERTO RICO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50606', 'RESTREPO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50680', 'SAN CARLOS DE GUAROA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50683', 'SAN JUAN DE ARAMA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50686', 'SAN JUANITO', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50689', 'SAN MARTÍN', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('50711', 'VISTAHERMOSA', '50');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52001', 'PASTO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52019', 'ALBÁN', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52022', 'ALDANA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52036', 'ANCUYA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52051', 'ARBOLEDA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52079', 'BARBACOAS', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52083', 'BELÉN', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52110', 'BUESACO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52203', 'COLÓN', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52207', 'CONSACÁ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52210', 'CONTADERO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52215', 'CÓRDOBA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52224', 'CUASPUD CARLOSAMA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52227', 'CUMBAL', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52233', 'CUMBITARA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52240', 'CHACHAGÜÍ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52250', 'EL CHARCO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52254', 'EL PEÑOL', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52256', 'EL ROSARIO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52258', 'EL TABLÓN DE GÓMEZ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52260', 'EL TAMBO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52287', 'FUNES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52317', 'GUACHUCAL', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52320', 'GUAITARILLA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52323', 'GUALMATÁN', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52352', 'ILES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52354', 'IMUÉS', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52356', 'IPIALES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52378', 'LA CRUZ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52381', 'LA FLORIDA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52385', 'LA LLANADA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52390', 'LA TOLA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52399', 'LA UNIÓN', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52405', 'LEIVA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52411', 'LINARES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52418', 'LOS ANDES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52427', 'MAGÜÍ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52435', 'MALLAMA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52473', 'MOSQUERA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52480', 'NARIÑO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52490', 'OLAYA HERRERA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52506', 'OSPINA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52520', 'FRANCISCO PIZARRO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52540', 'POLICARPA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52560', 'POTOSÍ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52565', 'PROVIDENCIA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52573', 'PUERRES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52585', 'PUPIALES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52612', 'RICAURTE', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52621', 'ROBERTO PAYÁN', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52678', 'SAMANIEGO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52683', 'SANDONÁ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52685', 'SAN BERNARDO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52687', 'SAN LORENZO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52693', 'SAN PABLO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52694', 'SAN PEDRO DE CARTAGO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52696', 'SANTA BÁRBARA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52699', 'SANTACRUZ', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52720', 'SAPUYES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52786', 'TAMINANGO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52788', 'TANGUA', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52835', 'SAN ANDRÉS DE TUMACO', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52838', 'TÚQUERRES', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('52885', 'YACUANQUER', '52');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54001', 'SAN JOSÉ DE CÚCUTA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54003', 'ÁBREGO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54051', 'ARBOLEDAS', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54099', 'BOCHALEMA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54109', 'BUCARASICA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54125', 'CÁCOTA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54128', 'CÁCHIRA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54172', 'CHINÁCOTA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54174', 'CHITAGÁ', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54206', 'CONVENCIÓN', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54223', 'CUCUTILLA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54239', 'DURANIA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54245', 'EL CARMEN', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54250', 'EL TARRA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54261', 'EL ZULIA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54313', 'GRAMALOTE', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54344', 'HACARÍ', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54347', 'HERRÁN', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54377', 'LABATECA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54385', 'LA ESPERANZA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54398', 'LA PLAYA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54405', 'LOS PATIOS', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54418', 'LOURDES', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54480', 'MUTISCUA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54498', 'OCAÑA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54518', 'PAMPLONA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54520', 'PAMPLONITA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54553', 'PUERTO SANTANDER', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54599', 'RAGONVALIA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54660', 'SALAZAR', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54670', 'SAN CALIXTO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54673', 'SAN CAYETANO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54680', 'SANTIAGO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54720', 'SARDINATA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54743', 'SILOS', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54800', 'TEORAMA', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54810', 'TIBÚ', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54820', 'TOLEDO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54871', 'VILLA CARO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('54874', 'VILLA DEL ROSARIO', '54');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63001', 'ARMENIA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63111', 'BUENAVISTA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63130', 'CALARCÁ', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63190', 'CIRCASIA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63212', 'CÓRDOBA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63272', 'FILANDIA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63302', 'GÉNOVA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63401', 'LA TEBAIDA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63470', 'MONTENEGRO', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63548', 'PIJAO', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63594', 'QUIMBAYA', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('63690', 'SALENTO', '63');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66001', 'PEREIRA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66045', 'APÍA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66075', 'BALBOA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66088', 'BELÉN DE UMBRÍA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66170', 'DOSQUEBRADAS', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66318', 'GUÁTICA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66383', 'LA CELIA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66400', 'LA VIRGINIA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66440', 'MARSELLA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66456', 'MISTRATÓ', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66572', 'PUEBLO RICO', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66594', 'QUINCHÍA', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66682', 'SANTA ROSA DE CABAL', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('66687', 'SANTUARIO', '66');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68001', 'BUCARAMANGA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68013', 'AGUADA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68020', 'ALBANIA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68051', 'ARATOCA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68077', 'BARBOSA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68079', 'BARICHARA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68081', 'BARRANCABERMEJA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68092', 'BETULIA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68101', 'BOLÍVAR', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68121', 'CABRERA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68132', 'CALIFORNIA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68147', 'CAPITANEJO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68152', 'CARCASÍ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68160', 'CEPITÁ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68162', 'CERRITO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68167', 'CHARALÁ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68169', 'CHARTA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68176', 'CHIMA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68179', 'CHIPATÁ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68190', 'CIMITARRA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68207', 'CONCEPCIÓN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68209', 'CONFINES', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68211', 'CONTRATACIÓN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68217', 'COROMORO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68229', 'CURITÍ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68235', 'EL CARMEN DE CHUCURI', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68245', 'EL GUACAMAYO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68250', 'EL PEÑÓN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68255', 'EL PLAYÓN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68264', 'ENCINO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68266', 'ENCISO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68271', 'FLORIÁN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68276', 'FLORIDABLANCA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68296', 'GALÁN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68298', 'GÁMBITA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68307', 'GIRÓN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68318', 'GUACA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68320', 'GUADALUPE', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68322', 'GUAPOTÁ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68324', 'GUAVATÁ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68327', 'GÜEPSA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68344', 'HATO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68368', 'JESÚS MARÍA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68370', 'JORDÁN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68377', 'LA BELLEZA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68385', 'LANDÁZURI', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68397', 'LA PAZ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68406', 'LEBRIJA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68418', 'LOS SANTOS', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68425', 'MACARAVITA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68432', 'MÁLAGA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68444', 'MATANZA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68464', 'MOGOTES', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68468', 'MOLAGAVITA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68498', 'OCAMONTE', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68500', 'OIBA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68502', 'ONZAGA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68522', 'PALMAR', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68524', 'PALMAS DEL SOCORRO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68533', 'PÁRAMO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68547', 'PIEDECUESTA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68549', 'PINCHOTE', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68572', 'PUENTE NACIONAL', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68573', 'PUERTO PARRA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68575', 'PUERTO WILCHES', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68615', 'RIONEGRO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68655', 'SABANA DE TORRES', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68669', 'SAN ANDRÉS', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68673', 'SAN BENITO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68679', 'SAN GIL', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68682', 'SAN JOAQUÍN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68684', 'SAN JOSÉ DE MIRANDA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68686', 'SAN MIGUEL', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68689', 'SAN VICENTE DE CHUCURÍ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68705', 'SANTA BÁRBARA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68720', 'SANTA HELENA DEL OPÓN', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68745', 'SIMACOTA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68755', 'SOCORRO', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68770', 'SUAITA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68773', 'SUCRE', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68780', 'SURATÁ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68820', 'TONA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68855', 'VALLE DE SAN JOSÉ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68861', 'VÉLEZ', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68867', 'VETAS', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68872', 'VILLANUEVA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('68895', 'ZAPATOCA', '68');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70001', 'SINCELEJO', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70110', 'BUENAVISTA', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70124', 'CAIMITO', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70204', 'COLOSÓ', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70215', 'COROZAL', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70221', 'COVEÑAS', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70230', 'CHALÁN', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70233', 'EL ROBLE', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70235', 'GALERAS', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70265', 'GUARANDA', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70400', 'LA UNIÓN', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70418', 'LOS PALMITOS', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70429', 'MAJAGUAL', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70473', 'MORROA', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70508', 'OVEJAS', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70523', 'PALMITO', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70670', 'SAMPUÉS', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70678', 'SAN BENITO ABAD', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70702', 'SAN JUAN DE BETULIA', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70708', 'SAN MARCOS', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70713', 'SAN ONOFRE', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70717', 'SAN PEDRO', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70742', 'SAN LUIS DE SINCÉ', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70771', 'SUCRE', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70820', 'SANTIAGO DE TOLÚ', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('70823', 'SAN JOSÉ DE TOLUVIEJO', '70');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73001', 'IBAGUÉ', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73024', 'ALPUJARRA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73026', 'ALVARADO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73030', 'AMBALEMA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73043', 'ANZOÁTEGUI', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73055', 'ARMERO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73067', 'ATACO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73124', 'CAJAMARCA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73148', 'CARMEN DE APICALÁ', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73152', 'CASABIANCA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73168', 'CHAPARRAL', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73200', 'COELLO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73217', 'COYAIMA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73226', 'CUNDAY', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73236', 'DOLORES', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73268', 'ESPINAL', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73270', 'FALAN', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73275', 'FLANDES', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73283', 'FRESNO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73319', 'GUAMO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73347', 'HERVEO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73349', 'HONDA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73352', 'ICONONZO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73408', 'LÉRIDA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73411', 'LÍBANO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73443', 'SAN SEBASTIÁN DE MARIQUITA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73449', 'MELGAR', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73461', 'MURILLO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73483', 'NATAGAIMA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73504', 'ORTEGA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73520', 'PALOCABILDO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73547', 'PIEDRAS', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73555', 'PLANADAS', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73563', 'PRADO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73585', 'PURIFICACIÓN', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73616', 'RIOBLANCO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73622', 'RONCESVALLES', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73624', 'ROVIRA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73671', 'SALDAÑA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73675', 'SAN ANTONIO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73678', 'SAN LUIS', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73686', 'SANTA ISABEL', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73770', 'SUÁREZ', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73854', 'VALLE DE SAN JUAN', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73861', 'VENADILLO', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73870', 'VILLAHERMOSA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('73873', 'VILLARRICA', '73');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76001', 'CALI', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76020', 'ALCALÁ', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76036', 'ANDALUCÍA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76041', 'ANSERMANUEVO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76054', 'ARGELIA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76100', 'BOLÍVAR', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76109', 'BUENAVENTURA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76111', 'GUADALAJARA DE BUGA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76113', 'BUGALAGRANDE', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76122', 'CAICEDONIA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76126', 'CALIMA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76130', 'CANDELARIA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76147', 'CARTAGO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76233', 'DAGUA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76243', 'EL ÁGUILA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76246', 'EL CAIRO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76248', 'EL CERRITO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76250', 'EL DOVIO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76275', 'FLORIDA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76306', 'GINEBRA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76318', 'GUACARÍ', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76364', 'JAMUNDÍ', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76377', 'LA CUMBRE', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76400', 'LA UNIÓN', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76403', 'LA VICTORIA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76497', 'OBANDO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76520', 'PALMIRA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76563', 'PRADERA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76606', 'RESTREPO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76616', 'RIOFRÍO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76622', 'ROLDANILLO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76670', 'SAN PEDRO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76736', 'SEVILLA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76823', 'TORO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76828', 'TRUJILLO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76834', 'TULUÁ', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76845', 'ULLOA', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76863', 'VERSALLES', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76869', 'VIJES', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76890', 'YOTOCO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76892', 'YUMBO', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('76895', 'ZARZAL', '76');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81001', 'ARAUCA', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81065', 'ARAUQUITA', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81220', 'CRAVO NORTE', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81300', 'FORTUL', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81591', 'PUERTO RONDÓN', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81736', 'SARAVENA', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('81794', 'TAME', '81');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85001', 'YOPAL', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85010', 'AGUAZUL', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85015', 'CHÁMEZA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85125', 'HATO COROZAL', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85136', 'LA SALINA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85139', 'MANÍ', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85162', 'MONTERREY', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85225', 'NUNCHÍA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85230', 'OROCUÉ', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85250', 'PAZ DE ARIPORO', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85263', 'PORE', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85279', 'RECETOR', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85300', 'SABANALARGA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85315', 'SÁCAMA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85325', 'SAN LUIS DE PALENQUE', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85400', 'TÁMARA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85410', 'TAURAMENA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85430', 'TRINIDAD', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('85440', 'VILLANUEVA', '85');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86001', 'MOCOA', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86219', 'COLÓN', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86320', 'ORITO', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86568', 'PUERTO ASÍS', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86569', 'PUERTO CAICEDO', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86571', 'PUERTO GUZMÁN', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86573', 'PUERTO LEGUÍZAMO', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86749', 'SIBUNDOY', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86755', 'SAN FRANCISCO', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86757', 'SAN MIGUEL', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86760', 'SANTIAGO', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86865', 'VALLE DEL GUAMUEZ', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('86885', 'VILLAGARZÓN', '86');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('88001', 'SAN ANDRÉS', '88');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('88564', 'PROVIDENCIA', '88');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91001', 'LETICIA', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91263', 'EL ENCANTO', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91405', 'LA CHORRERA', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91407', 'LA PEDRERA', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91430', 'LA VICTORIA', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91460', 'MIRITÍ - PARANÁ', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91530', 'PUERTO ALEGRÍA', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91536', 'PUERTO ARICA', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91540', 'PUERTO NARIÑO', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91669', 'PUERTO SANTANDER', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('91798', 'TARAPACÁ', '91');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94001', 'INÍRIDA', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94343', 'BARRANCOMINAS', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94883', 'SAN FELIPE', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94884', 'PUERTO COLOMBIA', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94885', 'LA GUADALUPE', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94886', 'CACAHUAL', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94887', 'PANA PANA', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('94888', 'MORICHAL', '94');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('95001', 'SAN JOSÉ DEL GUAVIARE', '95');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('95015', 'CALAMAR', '95');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('95025', 'EL RETORNO', '95');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('95200', 'MIRAFLORES', '95');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('97001', 'MITÚ', '97');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('97161', 'CARURÚ', '97');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('97511', 'PACOA', '97');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('97666', 'TARAIRA', '97');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('97777', 'PAPUNAHUA', '97');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('97889', 'YAVARATÉ', '97');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('99001', 'PUERTO CARREÑO', '99');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('99524', 'LA PRIMAVERA', '99');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('99624', 'SANTA ROSALÍA', '99');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('99773', 'CUMARIBO', '99');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05001', 'MEDELLÍN', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05002', 'ABEJORRAL', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05004', 'ABRIAQUÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05021', 'ALEJANDRÍA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05030', 'AMAGÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05031', 'AMALFI', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05034', 'ANDES', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05036', 'ANGELÓPOLIS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05038', 'ANGOSTURA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05040', 'ANORÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05042', 'SANTA FÉ DE ANTIOQUIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05044', 'ANZÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05045', 'APARTADÓ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05051', 'ARBOLETES', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05055', 'ARGELIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05059', 'ARMENIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05079', 'BARBOSA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05086', 'BELMIRA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05088', 'BELLO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05091', 'BETANIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05093', 'BETULIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05101', 'CIUDAD BOLÍVAR', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05107', 'BRICEÑO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05113', 'BURITICÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05120', 'CÁCERES', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05125', 'CAICEDO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05129', 'CALDAS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05134', 'CAMPAMENTO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05138', 'CAÑASGORDAS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05142', 'CARACOLÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05145', 'CARAMANTA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05147', 'CAREPA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05148', 'EL CARMEN DE VIBORAL', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05150', 'CAROLINA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05154', 'CAUCASIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05172', 'CHIGORODÓ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05190', 'CISNEROS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05197', 'COCORNÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05206', 'CONCEPCIÓN', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05209', 'CONCORDIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05212', 'COPACABANA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05234', 'DABEIBA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05237', 'DONMATÍAS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05240', 'EBÉJICO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05250', 'EL BAGRE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05264', 'ENTRERRÍOS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05266', 'ENVIGADO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05282', 'FREDONIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05284', 'FRONTINO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05306', 'GIRALDO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05308', 'GIRARDOTA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05310', 'GÓMEZ PLATA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05313', 'GRANADA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05315', 'GUADALUPE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05318', 'GUARNE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05321', 'GUATAPÉ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05347', 'HELICONIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05353', 'HISPANIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05360', 'ITAGÜÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05361', 'ITUANGO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05364', 'JARDÍN', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05368', 'JERICÓ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05376', 'LA CEJA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05380', 'LA ESTRELLA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05390', 'LA PINTADA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05400', 'LA UNIÓN', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05411', 'LIBORINA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05425', 'MACEO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05440', 'MARINILLA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05467', 'MONTEBELLO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05475', 'MURINDÓ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05480', 'MUTATÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05483', 'NARIÑO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05490', 'NECOCLÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05495', 'NECHÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05501', 'OLAYA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05541', 'PEÑOL', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05543', 'PEQUE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05576', 'PUEBLORRICO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05579', 'PUERTO BERRÍO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05585', 'PUERTO NARE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05591', 'PUERTO TRIUNFO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05604', 'REMEDIOS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05607', 'RETIRO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05615', 'RIONEGRO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05628', 'SABANALARGA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05631', 'SABANETA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05642', 'SALGAR', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05647', 'SAN ANDRÉS DE CUERQUÍA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05649', 'SAN CARLOS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05652', 'SAN FRANCISCO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05656', 'SAN JERÓNIMO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05658', 'SAN JOSÉ DE LA MONTAÑA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05659', 'SAN JUAN DE URABÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05660', 'SAN LUIS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05664', 'SAN PEDRO DE LOS MILAGROS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05665', 'SAN PEDRO DE URABÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05667', 'SAN RAFAEL', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05670', 'SAN ROQUE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05674', 'SAN VICENTE FERRER', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05679', 'SANTA BÁRBARA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05686', 'SANTA ROSA DE OSOS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05690', 'SANTO DOMINGO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05697', 'EL SANTUARIO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05736', 'SEGOVIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05756', 'SONSÓN', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05761', 'SOPETRÁN', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05789', 'TÁMESIS', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05790', 'TARAZÁ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05792', 'TARSO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05809', 'TITIRIBÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05819', 'TOLEDO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05837', 'TURBO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05842', 'URAMITA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05847', 'URRAO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05854', 'VALDIVIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05856', 'VALPARAÍSO', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05858', 'VEGACHÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05861', 'VENECIA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05873', 'VIGÍA DEL FUERTE', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05885', 'YALÍ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05887', 'YARUMAL', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05890', 'YOLOMBÓ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05893', 'YONDÓ', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('05895', 'ZARAGOZA', '05');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08001', 'BARRANQUILLA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08078', 'BARANOA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08137', 'CAMPO DE LA CRUZ', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08141', 'CANDELARIA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08296', 'GALAPA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08372', 'JUAN DE ACOSTA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08421', 'LURUACO', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08433', 'MALAMBO', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08436', 'MANATÍ', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08520', 'PALMAR DE VARELA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08549', 'PIOJÓ', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08558', 'POLONUEVO', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08560', 'PONEDERA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08573', 'PUERTO COLOMBIA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08606', 'REPELÓN', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08634', 'SABANAGRANDE', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08638', 'SABANALARGA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08675', 'SANTA LUCÍA', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08685', 'SANTO TOMÁS', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08758', 'SOLEDAD', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08770', 'SUAN', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08832', 'TUBARÁ', '08');
INSERT INTO public."T001MunicipiosDepartamento" ("T001CodMunicipio", "T001nombre", "T001Cod_Departamento") VALUES ('08849', 'USIACURÍ', '08');


-- SEXO.
INSERT INTO public."T004Sexo" ("T004CodSexo", "T004nombre") VALUES ('H', 'HOMBRE');
INSERT INTO public."T004Sexo" ("T004CodSexo", "T004nombre") VALUES ('M', 'MUJER');
INSERT INTO public."T004Sexo" ("T004CodSexo", "T004nombre") VALUES ('I', 'INTERSEXUAL');


-- ESTADO CIVIL
INSERT INTO public."T005EstadoCivil" ("T005CodEstadoCivil", "T005nombre", "T005registroPrecargado") VALUES ('S', 'Soltero', true);
INSERT INTO public."T005EstadoCivil" ("T005CodEstadoCivil", "T005nombre", "T005registroPrecargado") VALUES ('C', 'Casado', true);
INSERT INTO public."T005EstadoCivil" ("T005CodEstadoCivil", "T005nombre", "T005registroPrecargado") VALUES ('U', 'Unión libre', true);
INSERT INTO public."T005EstadoCivil" ("T005CodEstadoCivil", "T005nombre", "T005registroPrecargado") VALUES ('D', 'Divorciado', true);
INSERT INTO public."T005EstadoCivil" ("T005CodEstadoCivil", "T005nombre", "T005registroPrecargado") VALUES ('V', 'Viudo', true);


-- TIPOS DE DOCUMENTO DE ID
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('CC', 'Cédula de Ciudadania', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('CE', 'Cédula de Extranjeria', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('TI', 'Tarjeta de Identidad', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('RC', 'Registro Civil', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('NU', 'NUIP', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('PA', 'Pasaporte', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('PE', 'Permiso Especial de Permanencia', true);
INSERT INTO public."T006TiposDocumentoID" ("T006CodTipoDocumentoID", "T006nombre", "T006registroPrecargado") VALUES ('NT', 'NIT', true);


-- CLASES DE TERCERO
INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (1, 'Empresa');

INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (2, 'Funcionario');

INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (3, 'Contratista');

INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (4, 'Proveedor');

INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (5, 'Aseguradora');

INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (6, 'Conductor');

INSERT INTO public."T007ClasesTercero" ("T007IdClaseTercero", "T007nombre")
OVERRIDING SYSTEM VALUE 
VALUES (7, 'Conductor externo');

-- OPERACIONES SOBRE USUARIO
INSERT INTO public."T008OperacionesSobreUsuario" ("T008CodOperacion", "T008nombre") VALUES ('A', 'Activar');
INSERT INTO public."T008OperacionesSobreUsuario" ("T008CodOperacion", "T008nombre") VALUES ('I', 'Inactivar');
INSERT INTO public."T008OperacionesSobreUsuario" ("T008CodOperacion", "T008nombre") VALUES ('B', 'Bloquear');
INSERT INTO public."T008OperacionesSobreUsuario" ("T008CodOperacion", "T008nombre") VALUES ('D', 'Desbloquear');


-- PERMISOS
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('CR', 'Crear');
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('BO', 'Borrar');
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('AC', 'Actualizar');
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('CO', 'Consultar');
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('EJ', 'Ejecutar');
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('AP', 'Aprobar');
INSERT INTO public."TzPermisos" ("TzCodPermiso", "Tznombre") VALUES ('AN', 'Anular');



-- MODULOS
-- Módulo "Personas": módulo para administrar los registros de Personas del sistema, todos sus atributos completos, siempre que sean modificables.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (1, 'Personas', 'Permite administrar las personas del sistema','TRSV');
-- Módulo "Usuarios": módulo para administrar los datos completos de los usuarios.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE 
VALUES (2, 'Usuarios', 'Permite administrar los usuarios del sistema','SEGU');
-- Módulo "Administración de Datos Cuenta Usuario Interno": módulo para que un usuario INTERNO actualice los datos que se permiten "actualizar" por cuenta del mismo usuario, tanto los de usuario como algunos datos Personales (sólo los que se deba permitir actualizar).
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (3, 'Administración de Datos Cuenta Usuario Interno', 'Permite administrar a una persona que tiene un usuario interno, los datos de su usuario y datos personales desde el sistema - Sólo para usuarios internos','SEGU');
-- Módulo "Administración de Datos Cuenta Usuario Externo": módulo para que un usuario EXTERNO actualice los datos que se permiten "actualizar" por cuenta del mismo usuario, tanto los de usuario como algunos datos Personales (sólo los que se deba permitir actualizar).
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (4, 'Administración de Datos Cuenta Usuario Externo', 'Permite administrar a una persona que tiene un usuario externo, los datos de su usuario y datos personales desde el portal web - Sólo para usuarios externos','SEGU');
-- Módulo "Roles"
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (5, 'Roles', 'Permite administrar los roles del sistema','SEGU');
-- Módulo "Estado Civil"
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (6, 'Estado Civil', 'Permite administrar la información básica de los Estados Civiles del sistema','TRSV');
-- Módulo "Tipos de Documento de ID"
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (7, 'Tipos de Documentos de ID', 'Permite administrar los tipos de documentos de identificación','TRSV');
-- Módulo Proceso DE "Delegación del Rol SuperUsuario"
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (8, 'Delegación del Rol de SuperUsuario', 'Proceso que permite a un SuperUsuario delegar dicha función a otra persona','SEGU');

--COMPLEMENTO MÓDULO AUDITORÍA. -- Con este registro se va a poder consultar el nombre del módulo
--al que un usuario externo está modificando (creándose como persona) para efectos de que quede una auditoría de la acción.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (9, 'Creación Persona Vía Portal', 'Permite crear una persona vía Portal','SEGU');
--COMPLEMENTO MÓDULO AUDITORÍA. -- Con este registro se va a poder consultar el nombre del módulo
--al que un usuario externo está modificando (creándose como usuario) para efectos de que quede una auditoría de la acción.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (10, 'Creación Usuario Vía Portal', 'Permite crear un usuario vía Portal','SEGU');

-- Módulo "Marcas".
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (11, 'Marcas', 'Permite administrar la información básica de las Marcas de artículos activos fijos','ALMA');
-- Módulo "Bodegas".
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (12, 'Bodegas', 'Permite administrar las bodegas del Almacén creadas en el sistema','ALMA');
-- Módulo "Porcentajes de IVA".
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (13, 'Porcentajes de IVA', 'Permite administrar la información básica de los porcentajes de IVA que manejará el sistema','ALMA');
-- Módulo "Unidades de Medida".
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (14, 'Unidades de Medida', 'Permite administrar la información básica de las unidades de medida que manejará el sistema','ALMA');

-- Módulo "Organigramas": módulo para administrar los ORGANIGRAMAS del sistema, implica organigrama, sus niveles y sus unidades organizacionales.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (15, 'Organigramas', 'Permite administrar los organigramas del sistema','TRSV');
-- Módulo "Cambio de Organigrama Actual": módulo para cambiar de ORGANIGRAMA vigente de la entidad en el sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (16, 'Cambio de Organigrama Actual', 'Permite adoptar un nuevo organigrama de la entidad en el sistema','TRSV');
-- Módulo "Cargos": módulo para administrar los CARGOS del sistema. 
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (17, 'Cargos', 'Permite administrar los cargos disponibles en el sistema','TRSV');

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

-- Módulo "Cuadro de Clasificación Documental": módulo para administrar los CUADROS DE CLASIFICACIÓN DOCUMENTAL del sistema, implica CCD, sus series, subseries y sus unión con las unidades organizacionales.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (27, 'Cuadro de Clasificación Documental', 'Permite administrar los Cuadros de Clasificación Documental de la entidad en el sistema','GEST');
-- Módulo "Cambio de Cuadro de Clasificación Documental Actual": módulo para cambiar de CCD vigente de la entidad en el sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (28, 'Cambio de Cuadro de Clasificación Documental Actual', 'Permite adoptar un nuevo Cuadro de Clasificación Documental de la entidad en el sistema','GEST');

-- Módulo "Tablas de Retención Documental": módulo para administrar las TABLAS DE RETENCIÓN DOCUMENTAL del sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (29, 'Tabla de Retención Documental', 'Permite administrar las Tablas de Retención Documental de la entidad en el sistema','GEST');
-- Módulo "Cambio de Tabla de Retención Documental Actual": módulo para cambiar de TRD vigente de la entidad en el sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (30, 'Cambio de Tabla de Retención Documental Actual', 'Permite adoptar una nueva Tabla de Retención Documental de la entidad en el sistema','GEST');

-- Módulo "Tablas de Control de Acceso": módulo para administrar las TABLAS DE CONTROL DE ACCESO del sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (31, 'Tabla de Control de Acceso', 'Permite administrar las Tablas de Control de Acceso de la entidad en el sistema','GEST');
-- Módulo "Cambio de Tabla de Control de Acceso Actual": módulo para cambiar de TCA vigente de la entidad en el sistema.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (32, 'Cambio de Tabla de Control de Acceso Actual', 'Permite adoptar una nueva Tabla de Control de Acceso de la entidad en el sistema','GEST');

-- Módulo "Catálogo de Bienes": módulo para administrar los Bienes de la entidad a manejar en el subsistema de Almacén.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (33, 'Catálogo de Bienes', 'Permite administrar el catálogo de los bienes de la entidad a manejar en el subsistema de Almacén','ALMA');


-- Módulo "Entrada de Bienes de Almacén": módulo para ingresar bienes al Almacén de la entidad.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (34, 'Entrada de Bienes de Almacén', 'Permite ingresar bienes al Almacén de la entidad para su control','ALMA');

-- Módulo "Solicitud de Bienes de Consumo": módulo para solicitar bienes de consumo por parte de la entidad al almacén de la misma.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (35, 'Solicitud de Bienes de Consumo', 'Permite solicitar bienes de consumo por parte de la entidad al almacén de la misma','ALMA');

-- Módulo "Solicitud de Bienes de Consumo para Vivero": módulo para solicitar bienes de consumo para uso en Viveros por parte del personal de Viveros al Almacén.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (36, 'Solicitud de Bienes de Consumo para Viveros', 'Permite solicitar bienes de consumo para uso en la actividad misional de Viveros por parte del personal de Viveros al Almacén de la entidad','ALMA');

-- Módulo "Aprobación de Solicitudes de Bienes": módulo para aprobar o rechazar solicitudes de bienes de las cuales se le elijió como resopnsable por parte del solicitante.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (37, 'Aprobación de Solicitudes de Bienes', 'Permite aprobar o rechazar solicitudes de bienes de las cuales se le elijió como responsable por parte del solicitante','ALMA');

-- Módulo "Aprobación de Solicitudes de Consumo para Vivero": módulo para aprobar o rechazar solicitudes de bienes de las cuales se le elijió como resopnsable por parte del solicitante.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (38, 'Aprobación de Solicitudes de Consumo para Vivero', 'Permite aprobar o rechazar solicitudes de bienes de Consumo para la actividad misional de Vivero y sobre las cuales se le elijió como responsable por parte del solicitante','ALMA');

-- Módulo "Rechazo de Solicitudes de Bienes desde Almacén": módulo para rechazar por parte de Almacén, solicitudes de bienes de las diferentes áreas de la entidad.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (39, 'Rechazo de Solicitudes de Bienes desde Almacén', 'Permite rechazar por parte de Almacén, solicitudes de bienes realizadas por las diferentes áreas de la entidad','ALMA');

-- Módulo "Listado de Solicitudes de Bienes Pendientes": módulo que lista todas las solicitudes realizadas por la empresa y que no han sido gestionadas por Almacén.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (40, 'Listado de Solicitudes de Bienes Pendientes por Despachar', 'Lista todas las solicitudes realizadas por la empresa y que no han sido gestionadas por Almacén','ALMA');

-- Módulo "Administración de Viveros": módulo para administrar los viveros de la entidad.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (41, 'Administración de Viveros', 'Permite administrar los Viveros de la entidad','CONS');

-- Módulo "Ingresar/Retirar de Cuarentena un Vivero": módulo que permite ingresar o sacar de cuarentena un vivero de la entidad.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (42, 'Ingresar/Retirar de Cuarentena un Vivero', 'módulo que permite ingresar o sacar de cuarentena un vivero de la entidad','CONS');

-- Módulo "Aperturar/Cerrar un Vivero": módulo que permite aperturar o cerrar un vivero de la entidad.
INSERT INTO public."TzModulos" ("TzIdModulo", "Tznombre", "Tzdescripcion", "Tzsubsistema")
OVERRIDING SYSTEM VALUE
VALUES (43, 'Aperturar/Cerrar un Vivero', 'módulo que permite aperturar o cerrar un vivero existente de la entidad','CONS');



-- PERMISOS POR MODULO
-- Módulo PERSONAS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (1, 1, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (2, 1, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (3, 1, 'CO');
-- Módulo USUARIOS
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (4, 2, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (5, 2, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (6, 2, 'CO');
-- Módulo ADMINISTRACION DE DATOS CUENTA USUARIO INTERNO
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (7, 3, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (8, 3, 'CO');
-- Módulo ADMINISTRACION DE DATOS CUENTA USUARIO EXTERNO
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (9, 4, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (10, 4, 'CO');
-- Módulo ROLES
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (11, 5, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (12, 5, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (13, 5, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (14, 5, 'BO');
-- Módulo ESTADO CIVIL
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (15, 6, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (16, 6, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (17, 6, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (18, 6, 'BO');
-- Módulo TIPO DE DOCUMENTO DE ID
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (19, 7, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (20, 7, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (21, 7, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (22, 7, 'BO');
-- Módulo CAMBIO DE ROL DE SUPERUSUARIO
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (23, 8, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (24, 8, 'EJ');

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
-- Módulo de Ejecución de Mantenimiento de Vehículos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (75, 25, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (76, 25, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (77, 25, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (78, 25, 'CO');
-- Módulo de Ejecución de Mantenimiento de Otros activos
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (79, 26, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (80, 26, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (81, 26, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (82, 26, 'CO');


-- Módulo CUADROS DE CLASIFICACIÓN DOCUMENTAL.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (86, 27, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (87, 27, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (88, 27, 'CO');
-- Módulo CAMBIO DE CUADROS DE CLASIFICACIÓN DOCUMENTAL.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (89, 28, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (90, 28, 'CO');

-- Módulo TABLAS DE RETENCIÓN DOCUMENTAL.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (91, 29, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (92, 29, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (93, 29, 'CO');
-- Módulo CAMBIO DE TABLAS DE RETENCIÓN DOCUMENTAL.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (94, 30, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (95, 30, 'CO');

-- Módulo TABLA DE CONTROL DE ACCESO.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (96, 31, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (97, 31, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (98, 31, 'CO');
-- Módulo CAMBIO DE TABLA DE CONTROL DE ACCESO.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (99, 32, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (100, 32, 'CO');

-- Módulo CATALOGO DE BIENES.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (101, 33, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (102, 33, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (103, 33, 'BO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (104, 33, 'CO');


-- Módulo ENTRADA DE BIENES DE ALMACEN
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (105, 34, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (106, 34, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (107, 34, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (108, 34, 'AN');

-- Módulo SOLICITUD DE BIENES DE CONSUMO.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (109, 35, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (110, 35, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (111, 35, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (112, 35, 'AN');

-- Módulo SOLICITUD DE BIENES DE CONSUMO PARA VIVERO
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (113, 36, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (114, 36, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (115, 36, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (116, 36, 'AN');

-- Módulo APROBACIÓN DE SOLICITUD DE BIENES
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (117, 37, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (118, 37, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (119, 37, 'AC');

-- Módulo APROBACIÓN DE SOLICITUDES DE CONSUMO PARA VIVERO
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (120, 38, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (121, 38, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (122, 38, 'AC');

-- Módulo RECHAZO DE SOLICITUDES DE BIENES DESDE ALMACÉN
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (123, 39, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (124, 39, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (125, 39, 'AC');

-- Módulo LISTADO DE SOLICTUDES DE BIENES PENDIENTES
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (126, 40, 'CO');

-- Módulo ADMINISTRACIÓN DE VIVEROS.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (127, 41, 'CR');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (128, 41, 'CO');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (129, 41, 'AC');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (130, 41, 'BO');

-- Módulo INGRESAR/RETIRAR DE CUARENTENA UN VIVERO.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (131, 42, 'CR');

-- Módulo APERTURAR/CERRAR UN VIVERO.
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (132, 43, 'CR');




-- ROLES
INSERT INTO public."TzRoles" ("TzIdRol", "Tznombre", "Tzdescripcion", "TzrolDelSistema")
OVERRIDING SYSTEM VALUE
VALUES (1, 'Rol Super Usuario', 'Rol exclusivo para creación y administración de usuarios',true);
INSERT INTO public."TzRoles" ("TzIdRol", "Tznombre", "Tzdescripcion", "TzrolDelSistema")
OVERRIDING SYSTEM VALUE
VALUES (2, 'Rol Usuarios Web', 'Rol exclusivo para usuarios externos creados vía portal de usuarios', true);


-- PERMISOS POR MODULO POR ROL
-- Rol del SuperUsuario, PERSONAS
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (1, 1, 1);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (2, 1, 2);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (3, 1, 3);
-- Rol del SuperUsuario, USUARIOS
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (4, 1, 4);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (5, 1, 5);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (6, 1, 6);
-- Rol del SuperUsuario, ADMINISTRACION DE DATOS CUENTA USUARIO INTERNO
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (7, 1, 7);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (8, 1, 8);
-- Rol del SuperUsuario, ADMINISTRACION DE DATOS CUENTA USUARIO EXTERNO
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (9, 1, 9);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (10, 1, 10);
-- Rol del SuperUsuario, ROLES
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (11, 1, 11);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (12, 1, 12);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (13, 1, 13);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (14, 1, 14);
-- Rol del SuperUsuario, CAMBIO DE ROL DE SUPERUSUARIO
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (15, 1, 23);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (16, 1, 24);

-- Rol de Usuarios Web, ADMINISTRACION DE DATOS CUENTA USUARIO EXTERNO
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (17, 2, 9);
INSERT INTO public."TzPermisos_Modulo_Rol" ("TzIdPermisos_Modulo_Rol", "TzId_Rol", "TzId_Permisos_Modulo") OVERRIDING SYSTEM VALUE VALUES (18, 2, 10);


-- CREANDO A LA PERSONA PARA EL SUPERUSUARIO
-- NOTA: Estos datos se deben cambiar por la persona real que se va a encargar de crear a los demás usuarios.
-- Este va a ser el primer usuario del sistema.
-- OJO, El email debe ser el real para que pueda enviarse el correo para activación del usuario correspondiente.
INSERT INTO public."T010Personas" ("T010IdPersona", "T010Cod_TipoDocumentoID", "T010nroDocumentoID", "T010TipoPersona", "T010primerNombre", 
"T010primerApellido", "T010emailNotificacion", "T010telCelularPersona", "T010Cod_PaisNacimiento", "T010Cod_Sexo", "T010aceptaNotificacionSMS", 
"T010aceptaNotificacionEMail", "T010aceptaTratamientoDeDatos")
OVERRIDING SYSTEM VALUE
VALUES (1, 'CC', '1', 'N', 'SUPERUSUARIO NOMBRE', 'SUPERUSUARIO APELL', 'cambiarEMail@hotmail.com', 'IntroCelReal', 'CO', 'H', true, true, true);


-- CREANDO EL USUARIO PARA EL SUPERUSUARIO.
INSERT INTO public."TzUsuarios" ("TzIdUsuario", "TznombreUsuario", "TzId_Persona", "Tzcontrasegna", "Tzactivo", "Tzbloqueado", 
"TzcreadoPorPortal", "TzfechaCreacion", "TztipoUsuario")
OVERRIDING SYSTEM VALUE
VALUES (1, 'SuperUsuario', 1, '***CambiarContrasegna***', 'n', 'n', 'n', '2022-10-01', 'I');


-- USUARIOS POR ROL
-- Se agrega al usuario nuevo el ROL de "Rol SuperUsuario".
INSERT INTO public."TzUsuarios_Rol" ("TzIdUsuarios_Rol", "TzId_Rol", "TzId_Usuario") OVERRIDING SYSTEM VALUE VALUES (1, 1, 1);