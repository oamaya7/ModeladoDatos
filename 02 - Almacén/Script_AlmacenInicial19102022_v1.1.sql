--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén - Ultima Actualizacion 21/10/2022.
--****************************************************************

--CAMBIO GITHUB LS.

--****************************************************************
-- CREACIÓN DE TABLAS.
--****************************************************************
CREATE TABLE public."T051EstadosArticulo" (
    "T051Cod_Estado" character(1) NOT NULL,
    "T051nombre" character varying(255) NOT NULL
);

ALTER TABLE public."T051EstadosArticulo" OWNER TO postgres;

ALTER TABLE ONLY public."T051EstadosArticulo"
    ADD CONSTRAINT "T051EstadosArticulo_pkey" PRIMARY KEY ("T051Cod_Estado");



CREATE TABLE public."T052Marcas" (
    "T052IdMarca" smallint NOT NULL,
    "T052nombre" character varying(75) NOT NULL
);

ALTER TABLE public."T052Marcas" OWNER TO postgres;

ALTER TABLE ONLY public."T052Marcas"
    ADD CONSTRAINT "T052Marcas_pkey" PRIMARY KEY ("T052IdMarca");

ALTER TABLE public."T052Marcas" ALTER COLUMN "T052IdMarca" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."T052Marcas_T052IdMarca_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE public."T053PorcentajesIVA" (
    "T053IdPorcentajeIVA" smallint NOT NULL,
    "T053porcentaje" numeric(5,2) NOT NULL,
    "T053observación " character varying(255),
    "T053registroPrecargado" boolean NOT NULL
);

ALTER TABLE public."T053PorcentajesIVA" OWNER TO postgres;

ALTER TABLE ONLY public."T053PorcentajesIVA"
    ADD CONSTRAINT "T053PorcentajesIVA_pkey" PRIMARY KEY ("T053IdPorcentajeIVA");

ALTER TABLE public."T053PorcentajesIVA" ALTER COLUMN "T053IdPorcentajeIVA" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."T053PorcentajesIVA_T053IdPorcentajeIVA_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE public."T054Magnitudes" (
    "T054IdMagnitud" smallint NOT NULL,
    "T054nombre" character varying(50) NOT NULL
);

ALTER TABLE public."T054Magnitudes" OWNER TO postgres;

ALTER TABLE ONLY public."T054Magnitudes"
    ADD CONSTRAINT "T054Magnitudes_pkey" PRIMARY KEY ("T054IdMagnitud");

ALTER TABLE public."T054Magnitudes" ALTER COLUMN "T054IdMagnitud" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."T054Magnitudes_T054IdMagnitud_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE public."T055UnidadesMedida" (
    "T055IdUnidadMedida" smallint NOT NULL,
    "T055nombre" character varying(255) NOT NULL,
    "T055abreviatura" character(5) NOT NULL,
    "T055Id_Magnitud" smallint NOT NULL,
    "T055registroPrecargado" boolean NOT NULL
);


ALTER TABLE public."T055UnidadesMedida" OWNER TO postgres;

ALTER TABLE ONLY public."T055UnidadesMedida"
    ADD CONSTRAINT "T055UnidadesMedida_pkey" PRIMARY KEY ("T055IdUnidadMedida");

ALTER TABLE public."T055UnidadesMedida" ALTER COLUMN "T055IdUnidadMedida" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."T055UnidadesMedida_T055IdUnidadMedida_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE public."T056Bodegas" (
    "T056IdBodega" smallint NOT NULL,
    "T056nombre" character varying(255),
    "T056Cod_Municipio" character(5) NOT NULL,
    "T056direccion" character varying(255) NOT NULL,
    "T056Id_Responsable" integer NOT NULL,
    "T056esPrincipal" boolean NOT NULL
);

ALTER TABLE public."T056Bodegas" OWNER TO postgres;





ALTER TABLE public."T056Bodegas" ALTER COLUMN "T056IdBodega" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."T056Bodegas_T056IdBodega_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1
);
--Solución PK DE BODEGAS. @@@@@
ALTER TABLE ONLY public."T056Bodegas"
    ADD CONSTRAINT "T056Bodegas_pkey" PRIMARY KEY ("T056Bodegas");

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
    ADD CONSTRAINT "T055UnidadesMedida_T055Id_Magnitud_fkey" FOREIGN KEY ("T055Id_Magnitud") REFERENCES public."T054Magnitudes"("T054IdMagnitud");



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
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (2, 'kilómetro', 'Km', 1, true);
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
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (18, 'gruesa', 'gru', 3, true);
INSERT INTO public."T055UnidadesMedida" ("T055IdUnidadMedida", "T055nombre", "T055abreviatura", "T055Id_Magnitud", "T055registroPrecargado") OVERRIDING SYSTEM VALUE VALUES (19, 'millar', 'mill', 3, true);




--@@@CREO QUE ESTE BLOQUE NO IRIAAAA.
SELECT pg_catalog.setval('public."T052Marcas_T052IdMarca_seq"', 1, false);

SELECT pg_catalog.setval('public."T053PorcentajesIVA_T053IdPorcentajeIVA_seq"', 1, false);

SELECT pg_catalog.setval('public."T054Magnitudes_T054IdMagnitud_seq"', 1, false);

SELECT pg_catalog.setval('public."T055UnidadesMedida_T055IdUnidadMedida_seq"', 1, false);

SELECT pg_catalog.setval('public."T056Bodegas_T056IdBodega_seq"', 1, false);