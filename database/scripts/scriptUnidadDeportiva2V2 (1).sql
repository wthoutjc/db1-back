/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     7/08/2022 3:17:53 p. m.                      */
/*==============================================================*/


ALTER TABLE asismiemequipo DROP CONSTRAINT fk_asismiem_asistenci_miembroe;

ALTER TABLE asismiemequipo DROP CONSTRAINT fk_asismiem_progasism_programa;

ALTER TABLE asistirresponsable DROP CONSTRAINT fk_asistirr_responsab_responsa;

ALTER TABLE deportetipoelem DROP CONSTRAINT fk_deportet_deporteti_tipoelem;

ALTER TABLE deportetipoelem DROP CONSTRAINT fk_deportet_deporteti_deporte;

ALTER TABLE elemendeportivo DROP CONSTRAINT fk_elemende_elementot_tipoelem;

ALTER TABLE elemendeportivo DROP CONSTRAINT fk_elemende_espacioel_espacio;

ALTER TABLE elemendeportivo DROP CONSTRAINT fk_elemende_estadoele_estado;

ALTER TABLE elemendeportivo DROP CONSTRAINT fk_elemende_marcaelem_marca;

ALTER TABLE empleadocargo DROP CONSTRAINT fk_empleado_cargoempc_cargo;

ALTER TABLE empleadocargo DROP CONSTRAINT fk_empleado_empempcar_empleado;

ALTER TABLE empleadocargo DROP CONSTRAINT fk_empleado_relations_espacio;

ALTER TABLE equipo DROP CONSTRAINT fk_equipo_deporteeq_deporte;

ALTER TABLE equipo DROP CONSTRAINT fk_equipo_entrenado_empleado;

ALTER TABLE espacio DROP CONSTRAINT fk_espacio_espacioes_espacio;

ALTER TABLE espacio DROP CONSTRAINT fk_espacio_espacioti_tipoespa;

ALTER TABLE espaciodeporte DROP CONSTRAINT fk_espaciod_espaciode_deporte;

ALTER TABLE espaciodeporte DROP CONSTRAINT fk_espaciod_espaciode_espacio;

ALTER TABLE estudiante DROP CONSTRAINT fk_estudian_espacioes_espacio;

ALTER TABLE inscritopraclibre DROP CONSTRAINT fk_inscrito_empleadop_empleado;

ALTER TABLE inscritopraclibre DROP CONSTRAINT fk_inscrito_estinscpr_estudian;

ALTER TABLE inscritopraclibre DROP CONSTRAINT fk_inscrito_inscritop_programa;

ALTER TABLE miembroequipo DROP CONSTRAINT fk_miembroe_equipomie_equipo;

ALTER TABLE miembroequipo DROP CONSTRAINT fk_miembroe_estudiant_estudian;

ALTER TABLE prestamo DROP CONSTRAINT fk_prestamo_asistirre_asistirr;

ALTER TABLE prestamo DROP CONSTRAINT fk_prestamo_prestamoe_elemende;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_deportepr_deporte;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_diaprogra_dia;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_progactiv_activida;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_progespac_espacio;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_proghoraf_hora;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_proghorai_hora;

ALTER TABLE programacion DROP CONSTRAINT fk_programa_progperio_periodo;

ALTER TABLE responsable DROP CONSTRAINT fk_responsa_empleador_empleado;

ALTER TABLE responsable DROP CONSTRAINT fk_responsa_estudiant_estudian;

ALTER TABLE responsable DROP CONSTRAINT fk_responsa_responsab_programa;

ALTER TABLE responsable DROP CONSTRAINT fk_responsa_rolrespon_rol;

DROP TABLE actividad CASCADE CONSTRAINTS;

DROP INDEX progasismiemequipo_fk;

DROP INDEX asistenciamiembro_fk;

DROP TABLE asismiemequipo CASCADE CONSTRAINTS;

DROP INDEX responsableasisitirresp_fk;

DROP TABLE asistirresponsable CASCADE CONSTRAINTS;

DROP TABLE cargo CASCADE CONSTRAINTS;

DROP TABLE deporte CASCADE CONSTRAINTS;

DROP INDEX deportetipoelem_fk;

DROP INDEX deportetipoelem2_fk;

DROP TABLE deportetipoelem CASCADE CONSTRAINTS;

DROP TABLE dia CASCADE CONSTRAINTS;

DROP INDEX elementotipoelemento_fk;

DROP INDEX estadoelemdep_fk;

DROP INDEX marcaelem_fk;

DROP INDEX espacioelemendeportivo_fk;

DROP TABLE elemendeportivo CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP INDEX relationship_36_fk;

DROP INDEX empempcargo_fk;

DROP INDEX cargoempcargo_fk;

DROP TABLE empleadocargo CASCADE CONSTRAINTS;

DROP INDEX entrenadorequipo_fk;

DROP INDEX deporteequipo_fk;

DROP TABLE equipo CASCADE CONSTRAINTS;

DROP INDEX espacioespacio_fk;

DROP INDEX espaciotipo_fk;

DROP TABLE espacio CASCADE CONSTRAINTS;

DROP INDEX espaciodeporte_fk;

DROP INDEX espaciodeporte2_fk;

DROP TABLE espaciodeporte CASCADE CONSTRAINTS;

DROP TABLE estado CASCADE CONSTRAINTS;

DROP INDEX espacioestudiante_fk;

DROP TABLE estudiante CASCADE CONSTRAINTS;

DROP TABLE hora CASCADE CONSTRAINTS;

DROP INDEX estinscpraclibre_fk;

DROP INDEX inscritopracticaprogram_fk;

DROP INDEX empleadopraclibre_fk;

DROP TABLE inscritopraclibre CASCADE CONSTRAINTS;

DROP TABLE marca CASCADE CONSTRAINTS;

DROP INDEX estudiantemiemequipo_fk;

DROP INDEX equipomiembroequipo_fk;

DROP TABLE miembroequipo CASCADE CONSTRAINTS;

DROP TABLE periodo CASCADE CONSTRAINTS;

DROP INDEX prestamoelemento_fk;

DROP INDEX asistirrepprestamo_fk;

DROP TABLE prestamo CASCADE CONSTRAINTS;

DROP INDEX progespacio_fk;

DROP INDEX proghorai_fk;

DROP INDEX progperiodo_fk;

DROP INDEX progactividad_fk;

DROP INDEX proghoraf_fk;

DROP INDEX diaprogram_fk;

DROP INDEX deporteprogramacion_fk;

DROP TABLE programacion CASCADE CONSTRAINTS;

DROP INDEX responsableprog_fk;

DROP INDEX estudianteresponsable_fk;

DROP INDEX empleadoresponsable_fk;

DROP INDEX rolresponsable_fk;

DROP TABLE responsable CASCADE CONSTRAINTS;

DROP TABLE rol CASCADE CONSTRAINTS;

DROP TABLE tipoelemento CASCADE CONSTRAINTS;

DROP TABLE tipoespacio CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: ACTIVIDAD                                             */
/*==============================================================*/
CREATE TABLE actividad (
    idactividad   VARCHAR2(2) NOT NULL,
    descactividad VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_actividad PRIMARY KEY ( idactividad )
);

/*==============================================================*/
/* Table: ASISMIEMEQUIPO                                        */
/*==============================================================*/
CREATE TABLE asismiemequipo (
    consecprogra  NUMBER(4, 0) NOT NULL,
    conmiemequipo NUMBER(4, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    conseequipo   NUMBER(3, 0) NOT NULL,
    itemmiembro   NUMBER(3, 0) NOT NULL,
    CONSTRAINT pk_asismiemequipo PRIMARY KEY ( consecprogra,
                                               conmiemequipo )
);

/*==============================================================*/
/* Index: ASISTENCIAMIEMBRO_FK                                  */
/*==============================================================*/
CREATE INDEX asistenciamiembro_fk ON
    asismiemequipo (
        conseequipo
    ASC,
        itemmiembro
    ASC );

/*==============================================================*/
/* Index: PROGASISMIEMEQUIPO_FK                                 */
/*==============================================================*/
CREATE INDEX progasismiemequipo_fk ON
    asismiemequipo (
        consecprogra
    ASC );

/*==============================================================*/
/* Table: ASISTIRRESPONSABLE                                    */
/*==============================================================*/
CREATE TABLE asistirresponsable (
    consecprogra  NUMBER(4, 0) NOT NULL,
    consecres     NUMBER(4, 0) NOT NULL,
    consecasisres NUMBER(4, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    fechaasisres  DATE NOT NULL,
    horaasisres   DATE NOT NULL,
    CONSTRAINT pk_asistirresponsable PRIMARY KEY ( consecprogra,
                                                   consecres,
                                                   consecasisres )
);

/*==============================================================*/
/* Index: RESPONSABLEASISITIRRESP_FK                            */
/*==============================================================*/
CREATE INDEX responsableasisitirresp_fk ON
    asistirresponsable (
        consecprogra
    ASC,
        consecres
    ASC );

/*==============================================================*/
/* Table: CARGO                                                 */
/*==============================================================*/
CREATE TABLE cargo (
    idcargo  VARCHAR2(2) NOT NULL,
    descargo VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_cargo PRIMARY KEY ( idcargo )
);

/*==============================================================*/
/* Table: DEPORTE                                               */
/*==============================================================*/
CREATE TABLE deporte (
    iddeporte  VARCHAR2(2) NOT NULL,
    nomdeporte VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_deporte PRIMARY KEY ( iddeporte )
);

/*==============================================================*/
/* Table: DEPORTETIPOELEM                                       */
/*==============================================================*/
CREATE TABLE deportetipoelem (
    idtipoelemento VARCHAR2(2) NOT NULL,
    iddeporte      VARCHAR2(2) NOT NULL,
    CONSTRAINT pk_deportetipoelem PRIMARY KEY ( idtipoelemento,
                                                iddeporte )
);

/*==============================================================*/
/* Index: DEPORTETIPOELEM2_FK                                   */
/*==============================================================*/
CREATE INDEX deportetipoelem2_fk ON
    deportetipoelem (
        iddeporte
    ASC );

/*==============================================================*/
/* Index: DEPORTETIPOELEM_FK                                    */
/*==============================================================*/
CREATE INDEX deportetipoelem_fk ON
    deportetipoelem (
        idtipoelemento
    ASC );

/*==============================================================*/
/* Table: DIA                                                   */
/*==============================================================*/
CREATE TABLE dia (
    iddia  VARCHAR2(1) NOT NULL,
    nomdia VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_dia PRIMARY KEY ( iddia )
);

/*==============================================================*/
/* Table: ELEMENDEPORTIVO                                       */
/*==============================================================*/
CREATE TABLE elemendeportivo (
    consecelemento NUMBER(5, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    codespacio     VARCHAR2(2) NOT NULL,
    idmarca        VARCHAR2(2) NOT NULL,
    idestado       VARCHAR2(2) NOT NULL,
    idtipoelemento VARCHAR2(2) NOT NULL,
    fecharegistro  DATE NOT NULL,
    CONSTRAINT pk_elemendeportivo PRIMARY KEY ( consecelemento )
);

/*==============================================================*/
/* Index: ESPACIOELEMENDEPORTIVO_FK                             */
/*==============================================================*/
CREATE INDEX espacioelemendeportivo_fk ON
    elemendeportivo (
        codespacio
    ASC );

/*==============================================================*/
/* Index: MARCAELEM_FK                                          */
/*==============================================================*/
CREATE INDEX marcaelem_fk ON
    elemendeportivo (
        idmarca
    ASC );

/*==============================================================*/
/* Index: ESTADOELEMDEP_FK                                      */
/*==============================================================*/
CREATE INDEX estadoelemdep_fk ON
    elemendeportivo (
        idestado
    ASC );

/*==============================================================*/
/* Index: ELEMENTOTIPOELEMENTO_FK                               */
/*==============================================================*/
CREATE INDEX elementotipoelemento_fk ON
    elemendeportivo (
        idtipoelemento
    ASC );

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
CREATE TABLE empleado (
    codempleado   VARCHAR2(4) NOT NULL,
    nomempleado   VARCHAR2(20) NOT NULL,
    apellempleado VARCHAR2(20) NOT NULL,
    fecharegistro DATE NOT NULL,
    correoud      VARCHAR2(30),
    CONSTRAINT pk_empleado PRIMARY KEY ( codempleado )
);

/*==============================================================*/
/* Table: EMPLEADOCARGO                                         */
/*==============================================================*/
CREATE TABLE empleadocargo (
    consec      NUMBER(3, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    idcargo     VARCHAR2(2) NOT NULL,
    codempleado VARCHAR2(4) NOT NULL,
    codespacio  VARCHAR2(2) NOT NULL,
    fechacargo  DATE NOT NULL,
    fechafincar DATE,
    CONSTRAINT pk_empleadocargo PRIMARY KEY ( consec )
);

/*==============================================================*/
/* Index: CARGOEMPCARGO_FK                                      */
/*==============================================================*/
CREATE INDEX cargoempcargo_fk ON
    empleadocargo (
        idcargo
    ASC );

/*==============================================================*/
/* Index: EMPEMPCARGO_FK                                        */
/*==============================================================*/
CREATE INDEX empempcargo_fk ON
    empleadocargo (
        codempleado
    ASC );

/*==============================================================*/
/* Index: RELATIONSHIP_36_FK                                    */
/*==============================================================*/
CREATE INDEX relationship_36_fk ON
    empleadocargo (
        codespacio
    ASC );

/*==============================================================*/
/* Table: EQUIPO                                                */
/*==============================================================*/
CREATE TABLE equipo (
    conseequipo NUMBER(3, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    iddeporte   VARCHAR2(2) NOT NULL,
    codempleado VARCHAR2(4) NOT NULL,
    fecharesol  DATE NOT NULL,
    CONSTRAINT pk_equipo PRIMARY KEY ( conseequipo )
);

/*==============================================================*/
/* Index: DEPORTEEQUIPO_FK                                      */
/*==============================================================*/
CREATE INDEX deporteequipo_fk ON
    equipo (
        iddeporte
    ASC );

/*==============================================================*/
/* Index: ENTRENADOREQUIPO_FK                                   */
/*==============================================================*/
CREATE INDEX entrenadorequipo_fk ON
    equipo (
        codempleado
    ASC );

/*==============================================================*/
/* Table: ESPACIO                                               */
/*==============================================================*/
CREATE TABLE espacio (
    codespacio     VARCHAR2(2) NOT NULL,
    idtipoespacio  VARCHAR2(2) NOT NULL,
    esp_codespacio VARCHAR2(2),
    nomespacio     VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_espacio PRIMARY KEY ( codespacio )
);

/*==============================================================*/
/* Index: ESPACIOTIPO_FK                                        */
/*==============================================================*/
CREATE INDEX espaciotipo_fk ON
    espacio (
        idtipoespacio
    ASC );

/*==============================================================*/
/* Index: ESPACIOESPACIO_FK                                     */
/*==============================================================*/
CREATE INDEX espacioespacio_fk ON
    espacio (
        esp_codespacio
    ASC );

/*==============================================================*/
/* Table: ESPACIODEPORTE                                        */
/*==============================================================*/
CREATE TABLE espaciodeporte (
    iddeporte  VARCHAR2(2) NOT NULL,
    codespacio VARCHAR2(2) NOT NULL,
    CONSTRAINT pk_espaciodeporte PRIMARY KEY ( iddeporte,
                                               codespacio )
);

/*==============================================================*/
/* Index: ESPACIODEPORTE2_FK                                    */
/*==============================================================*/
CREATE INDEX espaciodeporte2_fk ON
    espaciodeporte (
        codespacio
    ASC );

/*==============================================================*/
/* Index: ESPACIODEPORTE_FK                                     */
/*==============================================================*/
CREATE INDEX espaciodeporte_fk ON
    espaciodeporte (
        iddeporte
    ASC );

/*==============================================================*/
/* Table: ESTADO                                                */
/*==============================================================*/
CREATE TABLE estado (
    idestado   VARCHAR2(2) NOT NULL,
    descestado VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_estado PRIMARY KEY ( idestado )
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
CREATE TABLE estudiante (
    codestu      VARCHAR2(12) NOT NULL,
    codespacio   VARCHAR2(2) NOT NULL,
    nomestu      VARCHAR2(30) NOT NULL,
    apelestu     VARCHAR2(30) NOT NULL,
    fecharegestu DATE NOT NULL,
    correoudestu VARCHAR2(30) NOT NULL,
    fechanacestu DATE NOT NULL,
    CONSTRAINT pk_estudiante PRIMARY KEY ( codestu )
);

/*==============================================================*/
/* Index: ESPACIOESTUDIANTE_FK                                  */
/*==============================================================*/
CREATE INDEX espacioestudiante_fk ON
    estudiante (
        codespacio
    ASC );

/*==============================================================*/
/* Table: HORA                                                  */
/*==============================================================*/
CREATE TABLE hora (
    idhora VARCHAR2(5) NOT NULL,
    CONSTRAINT pk_hora PRIMARY KEY ( idhora )
);

/*==============================================================*/
/* Table: INSCRITOPRACLIBRE                                     */
/*==============================================================*/
CREATE TABLE inscritopraclibre (
    consecprogra NUMBER(4, 0) NOT NULL,
    consecpract  NUMBER(4)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    codempleado  VARCHAR2(4),
    codestu      VARCHAR2(12),
    CONSTRAINT pk_inscritopraclibre PRIMARY KEY ( consecprogra,
                                                  consecpract )
);

/*==============================================================*/
/* Index: EMPLEADOPRACLIBRE_FK                                  */
/*==============================================================*/
CREATE INDEX empleadopraclibre_fk ON
    inscritopraclibre (
        codempleado
    ASC );

/*==============================================================*/
/* Index: INSCRITOPRACTICAPROGRAM_FK                            */
/*==============================================================*/
CREATE INDEX inscritopracticaprogram_fk ON
    inscritopraclibre (
        consecprogra
    ASC );

/*==============================================================*/
/* Index: ESTINSCPRACLIBRE_FK                                   */
/*==============================================================*/
CREATE INDEX estinscpraclibre_fk ON
    inscritopraclibre (
        codestu
    ASC );

/*==============================================================*/
/* Table: MARCA                                                 */
/*==============================================================*/
CREATE TABLE marca (
    idmarca  VARCHAR2(2) NOT NULL,
    nommarca VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_marca PRIMARY KEY ( idmarca )
);

/*==============================================================*/
/* Table: MIEMBROEQUIPO                                         */
/*==============================================================*/
CREATE TABLE miembroequipo (
    conseequipo NUMBER(3, 0) NOT NULL,
    itemmiembro NUMBER(3, 0) NOT NULL,
    codestu     VARCHAR2(12) NOT NULL,
    CONSTRAINT pk_miembroequipo PRIMARY KEY ( conseequipo,
                                              itemmiembro )
);

/*==============================================================*/
/* Index: EQUIPOMIEMBROEQUIPO_FK                                */
/*==============================================================*/
CREATE INDEX equipomiembroequipo_fk ON
    miembroequipo (
        conseequipo
    ASC );

/*==============================================================*/
/* Index: ESTUDIANTEMIEMEQUIPO_FK                               */
/*==============================================================*/
CREATE INDEX estudiantemiemequipo_fk ON
    miembroequipo (
        codestu
    ASC );

/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
CREATE TABLE periodo (
    idperiodo VARCHAR2(5) NOT NULL,
    CONSTRAINT pk_periodo PRIMARY KEY ( idperiodo )
);

/*==============================================================*/
/* Table: PRESTAMO                                              */
/*==============================================================*/
CREATE TABLE prestamo (
    consecprestamo NUMBER(4, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    consecprogra   NUMBER(4, 0) NOT NULL,
    consecres      NUMBER(4, 0) NOT NULL,
    consecasisres  NUMBER(4, 0) NOT NULL,
    consecelemento NUMBER(5, 0) NOT NULL,
    CONSTRAINT pk_prestamo PRIMARY KEY ( consecprestamo )
);

/*==============================================================*/
/* Index: ASISTIRREPPRESTAMO_FK                                 */
/*==============================================================*/
CREATE INDEX asistirrepprestamo_fk ON
    prestamo (
        consecprogra
    ASC,
        consecres
    ASC,
        consecasisres
    ASC );

/*==============================================================*/
/* Index: PRESTAMOELEMENTO_FK                                   */
/*==============================================================*/
CREATE INDEX prestamoelemento_fk ON
    prestamo (
        consecelemento
    ASC );

/*==============================================================*/
/* Table: PROGRAMACION                                          */
/*==============================================================*/
CREATE TABLE programacion (
    consecprogra NUMBER(4, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    iddeporte    VARCHAR2(2) NOT NULL,
    iddia        VARCHAR2(1) NOT NULL,
    idhora       VARCHAR2(5) NOT NULL,
    idactividad  VARCHAR2(2) NOT NULL,
    idperiodo    VARCHAR2(5) NOT NULL,
    hor_idhora   VARCHAR2(5) NOT NULL,
    codespacio   VARCHAR2(2) NOT NULL,
    cupo         NUMBER(3, 0) NOT NULL,
    noinscrito   NUMBER(3, 0),
    CONSTRAINT pk_programacion PRIMARY KEY ( consecprogra )
);

/*==============================================================*/
/* Index: DEPORTEPROGRAMACION_FK                                */
/*==============================================================*/
CREATE INDEX deporteprogramacion_fk ON
    programacion (
        iddeporte
    ASC );

/*==============================================================*/
/* Index: DIAPROGRAM_FK                                         */
/*==============================================================*/
CREATE INDEX diaprogram_fk ON
    programacion (
        iddia
    ASC );

/*==============================================================*/
/* Index: PROGHORAF_FK                                          */
/*==============================================================*/
CREATE INDEX proghoraf_fk ON
    programacion (
        idhora
    ASC );

/*==============================================================*/
/* Index: PROGACTIVIDAD_FK                                      */
/*==============================================================*/
CREATE INDEX progactividad_fk ON
    programacion (
        idactividad
    ASC );

/*==============================================================*/
/* Index: PROGPERIODO_FK                                        */
/*==============================================================*/
CREATE INDEX progperiodo_fk ON
    programacion (
        idperiodo
    ASC );

/*==============================================================*/
/* Index: PROGHORAI_FK                                          */
/*==============================================================*/
CREATE INDEX proghorai_fk ON
    programacion (
        hor_idhora
    ASC );

/*==============================================================*/
/* Index: PROGESPACIO_FK                                        */
/*==============================================================*/
CREATE INDEX progespacio_fk ON
    programacion (
        codespacio
    ASC );

/*==============================================================*/
/* Table: RESPONSABLE                                           */
/*==============================================================*/
CREATE TABLE responsable (
    consecprogra NUMBER(4, 0) NOT NULL,
    consecres    NUMBER(4, 0)
        GENERATED AS IDENTITY ( START WITH 1 NOCYCLE NOORDER ),
    idrol        VARCHAR2(1),
    codempleado  VARCHAR2(4) NOT NULL,
    codestu      VARCHAR2(12),
    fechaini     DATE NOT NULL,
    fechafin     DATE NOT NULL,
    CONSTRAINT pk_responsable PRIMARY KEY ( consecprogra,
                                            consecres )
);

/*==============================================================*/
/* Index: ROLRESPONSABLE_FK                                     */
/*==============================================================*/
CREATE INDEX rolresponsable_fk ON
    responsable (
        idrol
    ASC );

/*==============================================================*/
/* Index: EMPLEADORESPONSABLE_FK                                */
/*==============================================================*/
CREATE INDEX empleadoresponsable_fk ON
    responsable (
        codempleado
    ASC );

/*==============================================================*/
/* Index: ESTUDIANTERESPONSABLE_FK                              */
/*==============================================================*/
CREATE INDEX estudianteresponsable_fk ON
    responsable (
        codestu
    ASC );

/*==============================================================*/
/* Index: RESPONSABLEPROG_FK                                    */
/*==============================================================*/
CREATE INDEX responsableprog_fk ON
    responsable (
        consecprogra
    ASC );

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
CREATE TABLE rol (
    idrol   VARCHAR2(1) NOT NULL,
    descrol VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_rol PRIMARY KEY ( idrol )
);

/*==============================================================*/
/* Table: TIPOELEMENTO                                          */
/*==============================================================*/
CREATE TABLE tipoelemento (
    idtipoelemento   VARCHAR2(2) NOT NULL,
    desctipoelemento VARCHAR2(40) NOT NULL,
    CONSTRAINT pk_tipoelemento PRIMARY KEY ( idtipoelemento )
);

/*==============================================================*/
/* Table: TIPOESPACIO                                           */
/*==============================================================*/
CREATE TABLE tipoespacio (
    idtipoespacio   VARCHAR2(2) NOT NULL,
    desctipoespacio VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_tipoespacio PRIMARY KEY ( idtipoespacio )
);

ALTER TABLE asismiemequipo
    ADD CONSTRAINT fk_asismiem_asistenci_miembroe FOREIGN KEY ( conseequipo,
                                                                itemmiembro )
        REFERENCES miembroequipo ( conseequipo,
                                   itemmiembro );

ALTER TABLE asismiemequipo
    ADD CONSTRAINT fk_asismiem_progasism_programa FOREIGN KEY ( consecprogra )
        REFERENCES programacion ( consecprogra );

ALTER TABLE asistirresponsable
    ADD CONSTRAINT fk_asistirr_responsab_responsa FOREIGN KEY ( consecprogra,
                                                                consecres )
        REFERENCES responsable ( consecprogra,
                                 consecres );

ALTER TABLE deportetipoelem
    ADD CONSTRAINT fk_deportet_deporteti_tipoelem FOREIGN KEY ( idtipoelemento )
        REFERENCES tipoelemento ( idtipoelemento );

ALTER TABLE deportetipoelem
    ADD CONSTRAINT fk_deportet_deporteti_deporte FOREIGN KEY ( iddeporte )
        REFERENCES deporte ( iddeporte );

ALTER TABLE elemendeportivo
    ADD CONSTRAINT fk_elemende_elementot_tipoelem FOREIGN KEY ( idtipoelemento )
        REFERENCES tipoelemento ( idtipoelemento );

ALTER TABLE elemendeportivo
    ADD CONSTRAINT fk_elemende_espacioel_espacio FOREIGN KEY ( codespacio )
        REFERENCES espacio ( codespacio );

ALTER TABLE elemendeportivo
    ADD CONSTRAINT fk_elemende_estadoele_estado FOREIGN KEY ( idestado )
        REFERENCES estado ( idestado );

ALTER TABLE elemendeportivo
    ADD CONSTRAINT fk_elemende_marcaelem_marca FOREIGN KEY ( idmarca )
        REFERENCES marca ( idmarca );

ALTER TABLE empleadocargo
    ADD CONSTRAINT fk_empleado_cargoempc_cargo FOREIGN KEY ( idcargo )
        REFERENCES cargo ( idcargo );

ALTER TABLE empleadocargo
    ADD CONSTRAINT fk_empleado_empempcar_empleado FOREIGN KEY ( codempleado )
        REFERENCES empleado ( codempleado );

ALTER TABLE empleadocargo
    ADD CONSTRAINT fk_empleado_relations_espacio FOREIGN KEY ( codespacio )
        REFERENCES espacio ( codespacio );

ALTER TABLE equipo
    ADD CONSTRAINT fk_equipo_deporteeq_deporte FOREIGN KEY ( iddeporte )
        REFERENCES deporte ( iddeporte );

ALTER TABLE equipo
    ADD CONSTRAINT fk_equipo_entrenado_empleado FOREIGN KEY ( codempleado )
        REFERENCES empleado ( codempleado );

ALTER TABLE espacio
    ADD CONSTRAINT fk_espacio_espacioes_espacio FOREIGN KEY ( esp_codespacio )
        REFERENCES espacio ( codespacio );

ALTER TABLE espacio
    ADD CONSTRAINT fk_espacio_espacioti_tipoespa FOREIGN KEY ( idtipoespacio )
        REFERENCES tipoespacio ( idtipoespacio );

ALTER TABLE espaciodeporte
    ADD CONSTRAINT fk_espaciod_espaciode_deporte FOREIGN KEY ( iddeporte )
        REFERENCES deporte ( iddeporte );

ALTER TABLE espaciodeporte
    ADD CONSTRAINT fk_espaciod_espaciode_espacio FOREIGN KEY ( codespacio )
        REFERENCES espacio ( codespacio );

ALTER TABLE estudiante
    ADD CONSTRAINT fk_estudian_espacioes_espacio FOREIGN KEY ( codespacio )
        REFERENCES espacio ( codespacio );

ALTER TABLE inscritopraclibre
    ADD CONSTRAINT fk_inscrito_empleadop_empleado FOREIGN KEY ( codempleado )
        REFERENCES empleado ( codempleado );

ALTER TABLE inscritopraclibre
    ADD CONSTRAINT fk_inscrito_estinscpr_estudian FOREIGN KEY ( codestu )
        REFERENCES estudiante ( codestu );

ALTER TABLE inscritopraclibre
    ADD CONSTRAINT fk_inscrito_inscritop_programa FOREIGN KEY ( consecprogra )
        REFERENCES programacion ( consecprogra );

ALTER TABLE miembroequipo
    ADD CONSTRAINT fk_miembroe_equipomie_equipo FOREIGN KEY ( conseequipo )
        REFERENCES equipo ( conseequipo );

ALTER TABLE miembroequipo
    ADD CONSTRAINT fk_miembroe_estudiant_estudian FOREIGN KEY ( codestu )
        REFERENCES estudiante ( codestu );

ALTER TABLE prestamo
    ADD CONSTRAINT fk_prestamo_asistirre_asistirr FOREIGN KEY ( consecprogra,
                                                                consecres,
                                                                consecasisres )
        REFERENCES asistirresponsable ( consecprogra,
                                        consecres,
                                        consecasisres );

ALTER TABLE prestamo
    ADD CONSTRAINT fk_prestamo_prestamoe_elemende FOREIGN KEY ( consecelemento )
        REFERENCES elemendeportivo ( consecelemento );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_deportepr_deporte FOREIGN KEY ( iddeporte )
        REFERENCES deporte ( iddeporte );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_diaprogra_dia FOREIGN KEY ( iddia )
        REFERENCES dia ( iddia );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_progactiv_activida FOREIGN KEY ( idactividad )
        REFERENCES actividad ( idactividad );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_progespac_espacio FOREIGN KEY ( codespacio )
        REFERENCES espacio ( codespacio );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_proghoraf_hora FOREIGN KEY ( idhora )
        REFERENCES hora ( idhora );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_proghorai_hora FOREIGN KEY ( hor_idhora )
        REFERENCES hora ( idhora );

ALTER TABLE programacion
    ADD CONSTRAINT fk_programa_progperio_periodo FOREIGN KEY ( idperiodo )
        REFERENCES periodo ( idperiodo );

ALTER TABLE responsable
    ADD CONSTRAINT fk_responsa_empleador_empleado FOREIGN KEY ( codempleado )
        REFERENCES empleado ( codempleado );

ALTER TABLE responsable
    ADD CONSTRAINT fk_responsa_estudiant_estudian FOREIGN KEY ( codestu )
        REFERENCES estudiante ( codestu );

ALTER TABLE responsable
    ADD CONSTRAINT fk_responsa_responsab_programa FOREIGN KEY ( consecprogra )
        REFERENCES programacion ( consecprogra );

ALTER TABLE responsable
    ADD CONSTRAINT fk_responsa_rolrespon_rol FOREIGN KEY ( idrol )
        REFERENCES rol ( idrol );



-- MARCA
INSERT INTO marca VALUES (
    'ni',
    'nike'
);

INSERT INTO marca VALUES (
    'ad',
    'adidas'
);

INSERT INTO marca VALUES (
    'pu',
    'puma'
);

INSERT INTO marca VALUES (
    're',
    'reebok'
);

INSERT INTO marca VALUES (
    'fi',
    'fila'
);

INSERT INTO marca VALUES (
    'as',
    'asics'
);

INSERT INTO marca VALUES (
    'ka',
    'kappa'
);

INSERT INTO marca VALUES (
    'nf',
    'the north face'
);

INSERT INTO marca VALUES (
    'ua',
    'under armour'
);

INSERT INTO marca VALUES (
    'co',
    'converse'
);

INSERT INTO marca VALUES (
    'ti',
    'ti colombia'
);


-- ACTIVIDAD
INSERT INTO actividad VALUES (
    'CU',
    'curso'
);

INSERT INTO actividad VALUES (
    'PR',
    'practica'
);

INSERT INTO actividad VALUES (
    'EN',
    'entrenamiento'
);


-- TIPO ELEMENTO
INSERT INTO tipoelemento VALUES (
    'bb',
    'balon baloncesto'
);

INSERT INTO tipoelemento VALUES (
    'bf',
    'balon futbol'
);

INSERT INTO tipoelemento VALUES (
    'bv',
    'balon voleibol'
);

INSERT INTO tipoelemento VALUES (
    'tm',
    'pelota tenis mesa'
);

INSERT INTO tipoelemento VALUES (
    'tc',
    'pelota tenis campo'
);

INSERT INTO tipoelemento VALUES (
    'co',
    'colchoneta'
);

INSERT INTO tipoelemento VALUES (
    'ls',
    'lazo salto'
);

INSERT INTO tipoelemento VALUES (
    'gb',
    'guantes box'
);

INSERT INTO tipoelemento VALUES (
    'mv',
    'malla volibol'
);

INSERT INTO tipoelemento VALUES (
    'sb',
    'saco boxeo'
);

INSERT INTO tipoelemento VALUES (
    'hh',
    'aros hula-hula'
);

INSERT INTO tipoelemento VALUES (
    'cb',
    'chaleco boxeo'
);

INSERT INTO tipoelemento VALUES (
    'mp',
    'malla pimpon'
);

-- TIPO ESPACIO
INSERT INTO tipoespacio VALUES (
    'un',
    'unidad'
);

INSERT INTO tipoespacio VALUES (
    'se',
    'sede'
);

INSERT INTO tipoespacio VALUES (
    'ca',
    'campo'
);

INSERT INTO tipoespacio VALUES (
    'pi',
    'pista'
);

INSERT INTO tipoespacio VALUES (
    'sa',
    'salon'
);

INSERT INTO tipoespacio VALUES (
    'pa',
    'piscina'
);

INSERT INTO tipoespacio VALUES (
    'sm',
    'sala de maquinas'
);

INSERT INTO tipoespacio VALUES (
    'me',
    'muro de escalar'
);


-- DEPORTE
INSERT INTO deporte VALUES (
    'at',
    'atletismo'
);

INSERT INTO deporte VALUES (
    'te',
    'tenis'
);

INSERT INTO deporte VALUES (
    'tm',
    'tenis de mesa'
);

INSERT INTO deporte VALUES (
    'na',
    'natacion'
);

INSERT INTO deporte VALUES (
    'vo',
    'voleibol'
);

INSERT INTO deporte VALUES (
    'fu',
    'futbol'
);

INSERT INTO deporte VALUES (
    'fs',
    'futbol sala'
);

INSERT INTO deporte VALUES (
    'ba',
    'badminton'
);

INSERT INTO deporte VALUES (
    'ae',
    'aerobicos'
);

INSERT INTO deporte VALUES (
    'bo',
    'boxeo'
);

INSERT INTO deporte VALUES (
    'am',
    'artes marciales'
);

INSERT INTO deporte VALUES (
    'go',
    'gimnasia olimpica'
);

-- ESTADO
INSERT INTO estado VALUES (
    'ac',
    'activo'
);

INSERT INTO estado VALUES (
    'pr',
    'prestado'
);

INSERT INTO estado VALUES (
    'da',
    'daniado'
);

INSERT INTO estado VALUES (
    'pe',
    'perdido'
);

INSERT INTO estado VALUES (
    'ba',
    'de baja'
);

-- Periodo
INSERT INTO periodo VALUES ( '20191' );

INSERT INTO periodo VALUES ( '20192' );

INSERT INTO periodo VALUES ( '20193' );

INSERT INTO periodo VALUES ( '20201' );

INSERT INTO periodo VALUES ( '20202' );

INSERT INTO periodo VALUES ( '20203' );

INSERT INTO periodo VALUES ( '20211' );

INSERT INTO periodo VALUES ( '20212' );

INSERT INTO periodo VALUES ( '20213' );

INSERT INTO periodo VALUES ( '20221' );


-- ROL
INSERT INTO rol VALUES (
    '1',
    'director deportivo'
);

INSERT INTO rol VALUES (
    '2',
    'docente'
);

INSERT INTO rol VALUES (
    '3',
    'entrenador'
);

--Cargo
INSERT INTO cargo VALUES (
    'au',
    'auxiliar'
);

INSERT INTO cargo VALUES (
    'do',
    'docente'
);

INSERT INTO cargo VALUES (
    'dd',
    'director deportivo'
);

INSERT INTO cargo VALUES (
    'ad',
    'admin deportivo'
);

INSERT INTO cargo VALUES (
    'fi',
    'fisioterapeuta'
);

INSERT INTO cargo VALUES (
    'en',
    'entrenador'
);






-- 10 Espacios 1 unidad, 3 sedes, de cada sede un campo, una pista, una piscina, 10 salones y una sala mï¿½quinas.
INSERT INTO espacio VALUES (
    'a0',
    'un',
    NULL,
    'Unidad deportiva UD'
);

INSERT INTO espacio VALUES (
    'a1',
    'se',
    'a0',
    'Sede Chapinero'
);

INSERT INTO espacio VALUES (
    'a2',
    'ca',
    'a1',
    'Campo s1'
);

INSERT INTO espacio VALUES (
    'a3',
    'ca',
    'a1',
    'Campo 2 s1'
);

INSERT INTO espacio VALUES (
    'a4',
    'pi',
    'a1',
    'pista s1'
);

INSERT INTO espacio VALUES (
    'a5',
    'pa',
    'a1',
    'piscina s1'
);

INSERT INTO espacio VALUES (
    'a6',
    'sa',
    'a1',
    '101'
);

INSERT INTO espacio VALUES (
    'a7',
    'sa',
    'a1',
    '102'
);

INSERT INTO espacio VALUES (
    'a8',
    'sa',
    'a1',
    '103'
);

INSERT INTO espacio VALUES (
    'a9',
    'sa',
    'a1',
    '104'
);

INSERT INTO espacio VALUES (
    'b0',
    'sa',
    'a1',
    '201'
);

INSERT INTO espacio VALUES (
    'b1',
    'sa',
    'a1',
    '202'
);

INSERT INTO espacio VALUES (
    'b2',
    'sa',
    'a1',
    '203'
);

INSERT INTO espacio VALUES (
    'b3',
    'sa',
    'a1',
    '301'
);

INSERT INTO espacio VALUES (
    'b4',
    'sa',
    'a1',
    '302'
);

INSERT INTO espacio VALUES (
    'b5',
    'sa',
    'a1',
    '303'
);

INSERT INTO espacio VALUES (
    'b6',
    'sm',
    'a1',
    'Sala maquinas s1'
);

INSERT INTO espacio VALUES (
    'b7',
    'se',
    'a0',
    'Sede Macarena'
);

INSERT INTO espacio VALUES (
    'b8',
    'ca',
    'b7',
    'Campo s2'
);

INSERT INTO espacio VALUES (
    'b9',
    'pi',
    'b7',
    'pista s2'
);

INSERT INTO espacio VALUES (
    'c1',
    'pa',
    'b7',
    'piscina s1'
);

INSERT INTO espacio VALUES (
    'c2',
    'sa',
    'b7',
    '101'
);

INSERT INTO espacio VALUES (
    'c3',
    'sa',
    'b7',
    '102'
);

INSERT INTO espacio VALUES (
    'c4',
    'sa',
    'b7',
    '103'
);

INSERT INTO espacio VALUES (
    'c5',
    'sa',
    'b7',
    '104'
);

INSERT INTO espacio VALUES (
    'c6',
    'sa',
    'b7',
    '201'
);

INSERT INTO espacio VALUES (
    'c7',
    'sa',
    'b7',
    '202'
);

INSERT INTO espacio VALUES (
    'c8',
    'sa',
    'b7',
    '203'
);

INSERT INTO espacio VALUES (
    'c9',
    'sa',
    'b7',
    '301'
);

INSERT INTO espacio VALUES (
    'd1',
    'sa',
    'b7',
    '302'
);

INSERT INTO espacio VALUES (
    'd2',
    'sa',
    'b7',
    '303'
);

INSERT INTO espacio VALUES (
    'd3',
    'sm',
    'b7',
    'Sala maquinas s2'
);

INSERT INTO espacio VALUES (
    'd4',
    'se',
    'a0',
    'Sede Porvenir'
);

INSERT INTO espacio VALUES (
    'd5',
    'ca',
    'd4',
    'Campo s3'
);

INSERT INTO espacio VALUES (
    'd6',
    'pi',
    'd4',
    'pista s3'
);

INSERT INTO espacio VALUES (
    'd7',
    'pa',
    'd4',
    'piscina s3'
);

INSERT INTO espacio VALUES (
    'd8',
    'sa',
    'd4',
    '101'
);

INSERT INTO espacio VALUES (
    'd9',
    'sa',
    'd4',
    '102'
);

INSERT INTO espacio VALUES (
    'e0',
    'sa',
    'd4',
    '103'
);

INSERT INTO espacio VALUES (
    'e1',
    'sa',
    'd4',
    '104'
);

INSERT INTO espacio VALUES (
    'e2',
    'sa',
    'd4',
    '201'
);

INSERT INTO espacio VALUES (
    'e3',
    'sa',
    'd4',
    '202'
);

INSERT INTO espacio VALUES (
    'e4',
    'sa',
    'd4',
    '203'
);

INSERT INTO espacio VALUES (
    'e5',
    'sa',
    'd4',
    '301'
);

INSERT INTO espacio VALUES (
    'e6',
    'sa',
    'd4',
    '302'
);

INSERT INTO espacio VALUES (
    'e7',
    'sa',
    'd4',
    '303'
);

INSERT INTO espacio VALUES (
    'e8',
    'sm',
    'd4',
    'Sala maquinas s3'
);

--HORA
INSERT INTO hora VALUES ( '6:00' );

INSERT INTO hora VALUES ( '7:00' );

INSERT INTO hora VALUES ( '8:00' );

INSERT INTO hora VALUES ( '9:00' );

INSERT INTO hora VALUES ( '10:00' );

INSERT INTO hora VALUES ( '11:00' );

INSERT INTO hora VALUES ( '12:00' );

INSERT INTO hora VALUES ( '13:00' );

INSERT INTO hora VALUES ( '14:00' );

INSERT INTO hora VALUES ( '15:00' );

INSERT INTO hora VALUES ( '16:00' );

INSERT INTO hora VALUES ( '17:00' );

INSERT INTO hora VALUES ( '18:00' );

INSERT INTO hora VALUES ( '19:00' );

INSERT INTO hora VALUES ( '20:00' );

INSERT INTO hora VALUES ( '21:00' );

INSERT INTO hora VALUES ( '22:00' );

--DIA
INSERT INTO dia VALUES (
    '1',
    'lunes'
);

INSERT INTO dia VALUES (
    '2',
    'martes'
);

INSERT INTO dia VALUES (
    '3',
    'miercoles'
);

INSERT INTO dia VALUES (
    '4',
    'jueves'
);

INSERT INTO dia VALUES (
    '5',
    'viernes'
);

INSERT INTO dia VALUES (
    '6',
    'sabado'
);

--Incluir empleados: 1 directores deportivos de 2 sedes, 4 docentes, 2 auxiliares, 3 entrenadores
INSERT INTO empleado VALUES (
    '0001',
    'Jose',
    'Abella',
    current_date,
    'jabella@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'ad',
'0001',
'a0',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0002',
    'Hilda',
    'Navarrete',
    current_date,
    'hnavarrete@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'dd',
'0002',
'a1',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0003',
    'Jairo',
    'Niño',
    current_date,
    'jnino@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'dd',
'0003',
'b7',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0004',
    'Paula',
    'Castro',
    current_date,
    'pcastro@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'do',
'0004',
'a1',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0005',
    'Fabiï¿½n',
    'Aguirre',
    current_date,
    'faguirre@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'do',
'0005',
'b7',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0006',
    'Monica',
    'Galindo',
    current_date,
    'mgalindo@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'do',
'0006',
'a1',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0007',
    'Armando',
    'Paredes',
    current_date,
    'aparedes@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'ad',
'0007',
'd4',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0008',
    'Julia',
    'Torres',
    current_date,
    'jtorres@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'au',
'0008',
'd4',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0009',
    'Felix',
    'Contento',
    current_date,
    'fcontento@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'ad',
'0009',
'a1',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0010',
    'Mauro',
    'Pascal',
    current_date,
    'mpascal@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'en',
'0010',
'a1',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0011',
    'Sindy',
    'Zuleta',
    current_date,
    'szuleta@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'en',
'0011',
'b7',
current_date,
NULL );

INSERT INTO empleado VALUES (
    '0012',
    'Carlos',
    'Gomez',
    current_date,
    'cgomez@udistrital.edu.co'
);

INSERT INTO empleadocargo VALUES ( DEFAULT,
'en',
'0012',
'd4',
current_date,
NULL );


-- EQUIPO   

INSERT INTO equipo VALUES ( DEFAULT,
'at',
'0012',
current_date );

INSERT INTO equipo VALUES ( 
    DEFAULT,
    'tm',
    '0010',
    current_date );

INSERT INTO equipo VALUES (
    DEFAULT,
    'na',
    '0012',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'vo',
    '0011',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'fu',
    '0011',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'am',
    '0010',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'fs',
    '0011',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'ae',
    '0010',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'bo',
    '0011',
    current_date 
);

INSERT INTO equipo VALUES (
    DEFAULT,
    'go',
    '0012',
    current_date 
);


--Incluir 10 estudiantes de diferentes sedes 07/08/22
INSERT INTO estudiante VALUES (
    '20181020135',
    'a1',
    'Ariel',
    'Forero',
    current_date,
    'aeforerom@udistrital.edu.co',
    TO_DATE('26/08/00', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20181020089',
    'a1',
    'Camilo',
    'Ramirez',
    current_date,
    'jcramirezr@udistrital.edu.co',
    TO_DATE('21/06/00', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20181020015',
    'a1',
    'Pablo',
    'Espinoza',
    current_date,
    'peespinozag@udistrital.edu.co',
    TO_DATE('4/04/00', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20171015135',
    'b7',
    'Laura',
    'Gï¿½mez',
    current_date,
    'lgomez@udistrital.edu.co',
    TO_DATE('26/12/99', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20151005135',
    'b7',
    'Marï¿½a',
    'Duarte',
    current_date,
    'mduarte@udistrital.edu.co',
    TO_DATE('13/07/98', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20172010004',
    'b7',
    'Maelo',
    'Ruiz',
    current_date,
    'mruiz@udistrital.edu.co',
    TO_DATE('5/11/98', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20181020136',
    'b7',
    'Lana',
    'Murillo',
    current_date,
    'lmurillo@udistrital.edu.co',
    TO_DATE('26/08/00', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20192015152',
    'd4',
    'Ciro',
    'Nuï¿½ez',
    current_date,
    'cnunez@udistrital.edu.co',
    TO_DATE('13/05/01', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20201009048',
    'd4',
    'Nina',
    'Bohï¿½rquez',
    current_date,
    'nbohorquez@udistrital.edu.co',
    TO_DATE('26/12/02', 'dd/mm/yy')
);

INSERT INTO estudiante VALUES (
    '20211017017',
    'd4',
    'Juana',
    'Lopez',
    current_date,
    'jlopez@udistrital.edu.co',
    TO_DATE('28/03/02', 'dd/mm/yy')
);

--AQUIIIII COMPLETAR y aniadir registros de responsable, inscrito practica libre, equipo, miembroequibo, rol
--Incluir registros para la programacion: 4 registros de cursos, 4 registros de equipos entrenamiento, 4 registros
--practica libre


-- Cursos

--Curso 1
INSERT INTO programacion VALUES ( DEFAULT,
'tm',
'3',
'16:00',
'CU',
'20221',
'18:00',
'c3',
10,
NULL );
--Curso 2
INSERT INTO programacion VALUES ( DEFAULT,
'at',
'4',
'8:00',
'CU',
'20221',
'10:00',
'a4',
10,
NULL );
--Curso 3
INSERT INTO programacion VALUES ( DEFAULT,
'vo',
'5',
'12:00',
'CU',
'20221',
'14:00',
'a2',
10,
NULL );
--Curso 4
INSERT INTO programacion VALUES ( DEFAULT,
'fs',
'5',
'8:00',
'CU',
'20221',
'10:00',
'a3',
10,
NULL );


-- Entrenamientos

--Entrenamiento 1
INSERT INTO programacion VALUES ( DEFAULT,
'tm',
'3',
'14:00',
'EN',
'20221',
'16:00',
'c3',
10,
NULL );
--Entrenamiento 2
INSERT INTO programacion VALUES ( DEFAULT,
'at',
'4',
'12:00',
'EN',
'20221',
'14:00',
'a4',
10,
NULL );
--Entrenamiento 3
INSERT INTO programacion VALUES ( DEFAULT,
'vo',
'5',
'10:00',
'EN',
'20221',
'12:00',
'a2',
10,
NULL );
--Entrenamiento 4
INSERT INTO programacion VALUES ( DEFAULT,
'fs',
'5',
'10:00',
'EN',
'20221',
'12:00',
'a3',
10,
NULL );

-- Practicas libres

--Practica 1
INSERT INTO programacion VALUES ( DEFAULT,
'tm',
'3',
'10:00',
'PR',
'20221',
'12:00',
'c3',
10,
NULL );
--Practica 2
INSERT INTO programacion VALUES ( DEFAULT,
'at',
'4',
'14:00',
'PR',
'20221',
'16:00',
'a4',
10,
NULL );
--Practica 3
INSERT INTO programacion VALUES ( DEFAULT,
'vo',
'5',
'8:00',
'PR',
'20221',
'10:00',
'a2',
10,
NULL );
--Practica 4
INSERT INTO programacion VALUES ( DEFAULT,
'fs',
'5',
'14:00',
'PR',
'20221',
'16:00',
'a3',
10,
NULL );


--Incluir 10 registros en la tabla espacio-deporte
-- 1
INSERT INTO espaciodeporte VALUES (
    'tm',
    'c3'
);
-- 2
INSERT INTO espaciodeporte VALUES (
    'at',
    'a4'
);
-- 3
INSERT INTO espaciodeporte VALUES (
    'vo',
    'a2'
);
-- 4
INSERT INTO espaciodeporte VALUES (
    'fs',
    'a3'
);
-- 5
INSERT INTO espaciodeporte VALUES (
    'na',
    'a5'
);
-- 6
INSERT INTO espaciodeporte VALUES (
    'fu',
    'b8'
);
-- 7
INSERT INTO espaciodeporte VALUES (
    'am',
    'a3'
);
-- 8
INSERT INTO espaciodeporte VALUES (
    'bo',
    'b6'
);
-- 9
INSERT INTO espaciodeporte VALUES (
    'ae',
    'd3'
);
-- 10
INSERT INTO espaciodeporte VALUES (
    'go',
    'e8'
);


--Incluir 10 registros en la tabla ElemenDeprotivo con estado activo y prestado para las 2 sedes
-- 1
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'b7',
'ni',
'pr',
'bf',
current_date );
-- 2
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'd4',
'ad',
'ac',
'bb',
current_date );
-- 3
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'b7',
're',
'pr',
'bv',
current_date );
-- 4
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'd4',
'ni',
'ac',
'bf',
current_date );
-- 5
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'a1',
'pu',
'pr',
'tm',
current_date );
-- 6
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'a1',
'fi',
'ac',
'co',
current_date );
-- 7
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'a1',
'pu',
'pr',
'mp',
current_date );
-- 8
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'b7',
'ua',
'ac',
'gb',
current_date );
-- 9
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'b7',
'ua',
'ac',
'sb',
current_date );
-- 10
INSERT INTO elemendeportivo VALUES ( DEFAULT,
'b7',
'ua',
'ac',
'cb',
current_date );


-- Responsables
-- 1
--INSERT INTO responsable VALUES ( CONSECPROGRA,
--CONSECRES,
--IDROL,
--CODEMPLEADO,
--CODESTU,
--FECHAINI,
--FECHAFIN);

--1
INSERT INTO responsable VALUES (
    1, DEFAULT,
    '1',
    '0003',
    NULL,
    current_date,
    current_date + 4
);
--2
INSERT INTO responsable VALUES (
    2, DEFAULT,
    '1',
    '0002',
    NULL,
    current_date,
    current_date + 4
);
--3
INSERT INTO responsable VALUES (
    3, DEFAULT,
    '1',
    '0002',
    NULL,
    current_date,
    current_date + 5
);
--4
INSERT INTO responsable VALUES (
    4, DEFAULT,
    '1',
    '0002',
    NULL,
    current_date,
    current_date + 3
);
--5 En1
INSERT INTO responsable VALUES (
    5, DEFAULT,
    '3',
    '0011',
    NULL,
    current_date,
    current_date + 6
);
--6 En2
INSERT INTO responsable VALUES (
    6, DEFAULT,
    '3',
    '0010',
    NULL,
    current_date,
    current_date + 2
);
--7 En3
INSERT INTO responsable VALUES (
    7, DEFAULT,
    '3',
    '0010',
    NULL,
    current_date,
    current_date + 7
);
--8 En4
INSERT INTO responsable VALUES (
    8, DEFAULT,
    '3',
    '0010',
    NULL,
    current_date,
    current_date + 8
);
--9 Pr1
INSERT INTO responsable VALUES (
    9, DEFAULT,
    '2',
    '0005',
    NULL,
    current_date,
    current_date + 6
);
--10 Pr2
INSERT INTO responsable VALUES (
    10, DEFAULT,
    '2',
    '0004',
    NULL,
    current_date,
    current_date + 3
);
--11 Pr3
INSERT INTO responsable VALUES (
    11, DEFAULT,
    '2',
    '0006',
    NULL,
    current_date,
    current_date + 6
);
--12 Pr4
INSERT INTO responsable VALUES (
    12, DEFAULT,
    '2',
    '0006',
    NULL,
    current_date,
    current_date + 8
);
      
    
