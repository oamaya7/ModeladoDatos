/****************************************************************
 Script de Creación de Base de Datos - Subsistema Gestión Documental - Última Actualizacion 10/11/2022.
****************************************************************/
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
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (98, 32, 'EJ');
INSERT INTO public."TzPermisos_Modulo" ("TzIdPermisos_Modulo", "TzId_Modulo", "TzCod_Permiso") OVERRIDING SYSTEM VALUE VALUES (100, 32, 'CO');