--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén - Ultima Actualizacion 21/10/2022.
--****************************************************************



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



CREATE TABLE public."T052Marcas" (
    "T052IdMarca" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T052nombre" character varying(50) NOT NULL
);

ALTER TABLE public."T052Marcas" OWNER TO postgres;

ALTER TABLE ONLY public."T052Marcas"
    ADD CONSTRAINT "PK_T052Marcas" PRIMARY KEY ("T052IdMarca");



CREATE TABLE public."T053PorcentajesIVA" (
    "T053IdPorcentajeIVA" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T053porcentaje" numeric(5,2) NOT NULL,
    "T053observación " character varying(255),
    "T053registroPrecargado" boolean NOT NULL
);

ALTER TABLE public."T053PorcentajesIVA" OWNER TO postgres;

ALTER TABLE ONLY public."T053PorcentajesIVA"
    ADD CONSTRAINT "PK_T053PorcentajesIVA" PRIMARY KEY ("T053IdPorcentajeIVA");


CREATE TABLE public."T054Magnitudes" (
    "T054IdMagnitud" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T054nombre" character varying(50) NOT NULL
);

ALTER TABLE public."T054Magnitudes" OWNER TO postgres;

ALTER TABLE ONLY public."T054Magnitudes"
    ADD CONSTRAINT "PK_T054Magnitudes" PRIMARY KEY ("T054IdMagnitud");



CREATE TABLE public."T055UnidadesMedida" (
    "T055IdUnidadMedida" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T055nombre" character varying(50) NOT NULL,
    "T055abreviatura" character(5) NOT NULL,
    "T055Id_Magnitud" smallint NOT NULL,
    "T055registroPrecargado" boolean NOT NULL
);


ALTER TABLE public."T055UnidadesMedida" OWNER TO postgres;

ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "PK_T055UnidadesMedida" PRIMARY KEY ("T055IdUnidadMedida");


CREATE TABLE public."T056Bodegas" (
    "T056IdBodega" smallint GENERATED ALWAYS AS IDENTITY NOT NULL,
    "T056nombre" character varying(255),
    "T056Cod_Municipio" character(5) NOT NULL,
    "T056direccion" character varying(255) NOT NULL,
    "T056Id_Responsable" integer NOT NULL,
    "T056esPrincipal" boolean NOT NULL
);

ALTER TABLE public."T056Bodegas" OWNER TO postgres;


--Solución PK DE BODEGAS. @@@@@
ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "PK_T056Bodegas" PRIMARY KEY ("T056IdBodega");


CREATE TABLE public."T057Articulos" (
    "T057idArticulo" integer NOT NULL,
    "T057consecItemArticulo" integer,
    "T057codigoArticulo" integer NOT NULL,
    "T057Cod_TipoArticulo" smallint NOT NULL,
    "T057nombre" character varying(50) NOT NULL,
    "T057descripcion" character varying(255) NOT NULL,
    "T057docIdentidad" character varying(50),
    "T057Id_UnidadMedida" smallint NOT NULL,
    "T057Id_PorcentajeIVA" smallint NOT NULL,
    "T057Cod_MetodoValoracion" character(5) NOT NULL,
    "T057nombreCientifico" character varying(100),
    "T057Id_Marca" smallint,
    "T057itemDeMovimiento" boolean NOT NULL,
    "T057stockMinimo" integer,
    "T057stockMaximo" integer,
    "T057solicitablePorVivero" boolean NOT NULL,
    "T057Cod_TipoDepreciacion" character(5) NOT NULL,
    "T057vidaUtil" integer NOT NULL,
    "T057Cod_UnidadMedidaVidaUtil" character(5) NOT NULL,
    "T057valorResidual" integer,
    "T057tieneHojaDeVida" boolean NOT NULL,
    "T057Cod_TipoHojaDeVida" character(5)
);

ALTER TABLE public."T057Articulos" OWNER TO postgres;



--****************************************************************
-- LAS FOREIGN KEYS
--****************************************************************
ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "FK_T055UnidadesMedida_T055Id_Magnitud" FOREIGN KEY ("T055Id_Magnitud") REFERENCES public."T054Magnitudes"("T054IdMagnitud");



--****************************************************************
-- INSERCIÓN DE DATOS INICIALES.
--****************************************************************
-- ESTADOS.
INSERT INTO public."T051EstadosArticulo" ("T051Cod_Estado", "T051nombre") VALUES ('O', 'Óptimo');
INSERT INTO public."T051EstadosArticulo" ("T051Cod_Estado", "T051nombre") VALUES ('D', 'Defectuoso');
INSERT INTO public."T051EstadosArticulo" ("T051Cod_Estado", "T051nombre") VALUES ('A', 'Averiado');


-- PORCENTAJES DE IVA.
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observación ", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (1, 0.00, 'Bienes exentos del IVA', true);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observación ", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (2, 5.00, 'Tarifa del 5 %', true);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observación ", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (3, 16.00, 'Tarifa general IVA antes del año 2017, IVA del 16 %', true);
INSERT INTO public."T053PorcentajesIVA" ("T053IdPorcentajeIVA", "T053porcentaje", "T053observación ", "T053registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (4, 19.00, 'Tarifa general del IVA artículo 468, IVA del 19 %', true);


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




-- MODULOS
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
