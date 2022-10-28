--****************************************************************
-- Script de Creación de Base de Datos - Subsistema Almacén Parte 2 - Ultima Actualizacion 28/10/2022.
--****************************************************************

--****************************************************************
-- CREACIÓN DE TABLAS.
--****************************************************************

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