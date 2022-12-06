/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     7/08/2022 3:17:53 p. m.                      */
/*==============================================================*/


alter table ASISMIEMEQUIPO
   drop constraint FK_ASISMIEM_ASISTENCI_MIEMBROE;

alter table ASISMIEMEQUIPO
   drop constraint FK_ASISMIEM_PROGASISM_PROGRAMA;

alter table ASISTIRRESPONSABLE
   drop constraint FK_ASISTIRR_RESPONSAB_RESPONSA;

alter table DEPORTETIPOELEM
   drop constraint FK_DEPORTET_DEPORTETI_TIPOELEM;

alter table DEPORTETIPOELEM
   drop constraint FK_DEPORTET_DEPORTETI_DEPORTE;

alter table ELEMENDEPORTIVO
   drop constraint FK_ELEMENDE_ELEMENTOT_TIPOELEM;

alter table ELEMENDEPORTIVO
   drop constraint FK_ELEMENDE_ESPACIOEL_ESPACIO;

alter table ELEMENDEPORTIVO
   drop constraint FK_ELEMENDE_ESTADOELE_ESTADO;

alter table ELEMENDEPORTIVO
   drop constraint FK_ELEMENDE_MARCAELEM_MARCA;

alter table EMPLEADOCARGO
   drop constraint FK_EMPLEADO_CARGOEMPC_CARGO;

alter table EMPLEADOCARGO
   drop constraint FK_EMPLEADO_EMPEMPCAR_EMPLEADO;

alter table EMPLEADOCARGO
   drop constraint FK_EMPLEADO_RELATIONS_ESPACIO;

alter table EQUIPO
   drop constraint FK_EQUIPO_DEPORTEEQ_DEPORTE;

alter table EQUIPO
   drop constraint FK_EQUIPO_ENTRENADO_EMPLEADO;

alter table ESPACIO
   drop constraint FK_ESPACIO_ESPACIOES_ESPACIO;

alter table ESPACIO
   drop constraint FK_ESPACIO_ESPACIOTI_TIPOESPA;

alter table ESPACIODEPORTE
   drop constraint FK_ESPACIOD_ESPACIODE_DEPORTE;

alter table ESPACIODEPORTE
   drop constraint FK_ESPACIOD_ESPACIODE_ESPACIO;

alter table ESTUDIANTE
   drop constraint FK_ESTUDIAN_ESPACIOES_ESPACIO;

alter table INSCRITOPRACLIBRE
   drop constraint FK_INSCRITO_EMPLEADOP_EMPLEADO;

alter table INSCRITOPRACLIBRE
   drop constraint FK_INSCRITO_ESTINSCPR_ESTUDIAN;

alter table INSCRITOPRACLIBRE
   drop constraint FK_INSCRITO_INSCRITOP_PROGRAMA;

alter table MIEMBROEQUIPO
   drop constraint FK_MIEMBROE_EQUIPOMIE_EQUIPO;

alter table MIEMBROEQUIPO
   drop constraint FK_MIEMBROE_ESTUDIANT_ESTUDIAN;

alter table PRESTAMO
   drop constraint FK_PRESTAMO_ASISTIRRE_ASISTIRR;

alter table PRESTAMO
   drop constraint FK_PRESTAMO_PRESTAMOE_ELEMENDE;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_DEPORTEPR_DEPORTE;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_DIAPROGRA_DIA;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_PROGACTIV_ACTIVIDA;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_PROGESPAC_ESPACIO;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_PROGHORAF_HORA;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_PROGHORAI_HORA;

alter table PROGRAMACION
   drop constraint FK_PROGRAMA_PROGPERIO_PERIODO;

alter table RESPONSABLE
   drop constraint FK_RESPONSA_EMPLEADOR_EMPLEADO;

alter table RESPONSABLE
   drop constraint FK_RESPONSA_ESTUDIANT_ESTUDIAN;

alter table RESPONSABLE
   drop constraint FK_RESPONSA_RESPONSAB_PROGRAMA;

alter table RESPONSABLE
   drop constraint FK_RESPONSA_ROLRESPON_ROL;

drop table ACTIVIDAD cascade constraints;

drop index PROGASISMIEMEQUIPO_FK;

drop index ASISTENCIAMIEMBRO_FK;

drop table ASISMIEMEQUIPO cascade constraints;

drop index RESPONSABLEASISITIRRESP_FK;

drop table ASISTIRRESPONSABLE cascade constraints;

drop table CARGO cascade constraints;

drop table DEPORTE cascade constraints;

drop index DEPORTETIPOELEM_FK;

drop index DEPORTETIPOELEM2_FK;

drop table DEPORTETIPOELEM cascade constraints;

drop table DIA cascade constraints;

drop index ELEMENTOTIPOELEMENTO_FK;

drop index ESTADOELEMDEP_FK;

drop index MARCAELEM_FK;

drop index ESPACIOELEMENDEPORTIVO_FK;

drop table ELEMENDEPORTIVO cascade constraints;

drop table EMPLEADO cascade constraints;

drop index RELATIONSHIP_36_FK;

drop index EMPEMPCARGO_FK;

drop index CARGOEMPCARGO_FK;

drop table EMPLEADOCARGO cascade constraints;

drop index ENTRENADOREQUIPO_FK;

drop index DEPORTEEQUIPO_FK;

drop table EQUIPO cascade constraints;

drop index ESPACIOESPACIO_FK;

drop index ESPACIOTIPO_FK;

drop table ESPACIO cascade constraints;

drop index ESPACIODEPORTE_FK;

drop index ESPACIODEPORTE2_FK;

drop table ESPACIODEPORTE cascade constraints;

drop table ESTADO cascade constraints;

drop index ESPACIOESTUDIANTE_FK;

drop table ESTUDIANTE cascade constraints;

drop table HORA cascade constraints;

drop index ESTINSCPRACLIBRE_FK;

drop index INSCRITOPRACTICAPROGRAM_FK;

drop index EMPLEADOPRACLIBRE_FK;

drop table INSCRITOPRACLIBRE cascade constraints;

drop table MARCA cascade constraints;

drop index ESTUDIANTEMIEMEQUIPO_FK;

drop index EQUIPOMIEMBROEQUIPO_FK;

drop table MIEMBROEQUIPO cascade constraints;

drop table PERIODO cascade constraints;

drop index PRESTAMOELEMENTO_FK;

drop index ASISTIRREPPRESTAMO_FK;

drop table PRESTAMO cascade constraints;

drop index PROGESPACIO_FK;

drop index PROGHORAI_FK;

drop index PROGPERIODO_FK;

drop index PROGACTIVIDAD_FK;

drop index PROGHORAF_FK;

drop index DIAPROGRAM_FK;

drop index DEPORTEPROGRAMACION_FK;

drop table PROGRAMACION cascade constraints;

drop index RESPONSABLEPROG_FK;

drop index ESTUDIANTERESPONSABLE_FK;

drop index EMPLEADORESPONSABLE_FK;

drop index ROLRESPONSABLE_FK;

drop table RESPONSABLE cascade constraints;

drop table ROL cascade constraints;

drop table TIPOELEMENTO cascade constraints;

drop table TIPOESPACIO cascade constraints;

/*==============================================================*/
/* Table: ACTIVIDAD                                             */
/*==============================================================*/
create table ACTIVIDAD (
   IDACTIVIDAD          VARCHAR2(2)           not null,
   DESCACTIVIDAD        VARCHAR2(30)          not null,
   constraint PK_ACTIVIDAD primary key (IDACTIVIDAD)
);

/*==============================================================*/
/* Table: ASISMIEMEQUIPO                                        */
/*==============================================================*/
create table ASISMIEMEQUIPO (
   CONSECPROGRA         NUMBER(4,0)           not null,
   CONMIEMEQUIPO        NUMBER(4,0)           
      generated as identity ( start with 1 nocycle noorder),
   CONSEEQUIPO          NUMBER(3,0)           not null,
   ITEMMIEMBRO          NUMBER(3,0)           not null,
   constraint PK_ASISMIEMEQUIPO primary key (CONSECPROGRA, CONMIEMEQUIPO)
);

/*==============================================================*/
/* Index: ASISTENCIAMIEMBRO_FK                                  */
/*==============================================================*/
create index ASISTENCIAMIEMBRO_FK on ASISMIEMEQUIPO (
   CONSEEQUIPO ASC,
   ITEMMIEMBRO ASC
);

/*==============================================================*/
/* Index: PROGASISMIEMEQUIPO_FK                                 */
/*==============================================================*/
create index PROGASISMIEMEQUIPO_FK on ASISMIEMEQUIPO (
   CONSECPROGRA ASC
);

/*==============================================================*/
/* Table: ASISTIRRESPONSABLE                                    */
/*==============================================================*/
create table ASISTIRRESPONSABLE (
   CONSECPROGRA         NUMBER(4,0)           not null,
   CONSECRES            NUMBER(4,0)           not null,
   CONSECASISRES        NUMBER(4,0)           
      generated as identity ( start with 1 nocycle noorder),
   FECHAASISRES         DATE                  not null,
   HORAASISRES          DATE                  not null,
   constraint PK_ASISTIRRESPONSABLE primary key (CONSECPROGRA, CONSECRES, CONSECASISRES)
);

/*==============================================================*/
/* Index: RESPONSABLEASISITIRRESP_FK                            */
/*==============================================================*/
create index RESPONSABLEASISITIRRESP_FK on ASISTIRRESPONSABLE (
   CONSECPROGRA ASC,
   CONSECRES ASC
);

/*==============================================================*/
/* Table: CARGO                                                 */
/*==============================================================*/
create table CARGO (
   IDCARGO              VARCHAR2(2)           not null,
   DESCARGO             VARCHAR2(20)          not null,
   constraint PK_CARGO primary key (IDCARGO)
);

/*==============================================================*/
/* Table: DEPORTE                                               */
/*==============================================================*/
create table DEPORTE (
   IDDEPORTE            VARCHAR2(2)           not null,
   NOMDEPORTE           VARCHAR2(20)          not null,
   constraint PK_DEPORTE primary key (IDDEPORTE)
);

/*==============================================================*/
/* Table: DEPORTETIPOELEM                                       */
/*==============================================================*/
create table DEPORTETIPOELEM (
   IDTIPOELEMENTO       VARCHAR2(2)           not null,
   IDDEPORTE            VARCHAR2(2)           not null,
   constraint PK_DEPORTETIPOELEM primary key (IDTIPOELEMENTO, IDDEPORTE)
);

/*==============================================================*/
/* Index: DEPORTETIPOELEM2_FK                                   */
/*==============================================================*/
create index DEPORTETIPOELEM2_FK on DEPORTETIPOELEM (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Index: DEPORTETIPOELEM_FK                                    */
/*==============================================================*/
create index DEPORTETIPOELEM_FK on DEPORTETIPOELEM (
   IDTIPOELEMENTO ASC
);

/*==============================================================*/
/* Table: DIA                                                   */
/*==============================================================*/
create table DIA (
   IDDIA                VARCHAR2(1)           not null,
   NOMDIA               VARCHAR2(10)          not null,
   constraint PK_DIA primary key (IDDIA)
);

/*==============================================================*/
/* Table: ELEMENDEPORTIVO                                       */
/*==============================================================*/
create table ELEMENDEPORTIVO (
   CONSECELEMENTO       NUMBER(5,0)           
      generated as identity ( start with 1 nocycle noorder),
   CODESPACIO           VARCHAR2(2)           not null,
   IDMARCA              VARCHAR2(2)           not null,
   IDESTADO             VARCHAR2(2)           not null,
   IDTIPOELEMENTO       VARCHAR2(2)           not null,
   FECHAREGISTRO        DATE                  not null,
   constraint PK_ELEMENDEPORTIVO primary key (CONSECELEMENTO)
);

/*==============================================================*/
/* Index: ESPACIOELEMENDEPORTIVO_FK                             */
/*==============================================================*/
create index ESPACIOELEMENDEPORTIVO_FK on ELEMENDEPORTIVO (
   CODESPACIO ASC
);

/*==============================================================*/
/* Index: MARCAELEM_FK                                          */
/*==============================================================*/
create index MARCAELEM_FK on ELEMENDEPORTIVO (
   IDMARCA ASC
);

/*==============================================================*/
/* Index: ESTADOELEMDEP_FK                                      */
/*==============================================================*/
create index ESTADOELEMDEP_FK on ELEMENDEPORTIVO (
   IDESTADO ASC
);

/*==============================================================*/
/* Index: ELEMENTOTIPOELEMENTO_FK                               */
/*==============================================================*/
create index ELEMENTOTIPOELEMENTO_FK on ELEMENDEPORTIVO (
   IDTIPOELEMENTO ASC
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   CODEMPLEADO          VARCHAR2(4)           not null,
   NOMEMPLEADO          VARCHAR2(20)          not null,
   APELLEMPLEADO        VARCHAR2(20)          not null,
   FECHAREGISTRO        DATE                  not null,
   CORREOUD             VARCHAR2(30),
   constraint PK_EMPLEADO primary key (CODEMPLEADO)
);

/*==============================================================*/
/* Table: EMPLEADOCARGO                                         */
/*==============================================================*/
create table EMPLEADOCARGO (
   CONSEC               NUMBER(3,0)           
      generated as identity ( start with 1 nocycle noorder),
   IDCARGO              VARCHAR2(2)           not null,
   CODEMPLEADO          VARCHAR2(4)           not null,
   CODESPACIO           VARCHAR2(2)           not null,
   FECHACARGO           DATE                  not null,
   FECHAFINCAR          DATE,
   constraint PK_EMPLEADOCARGO primary key (CONSEC)
);

/*==============================================================*/
/* Index: CARGOEMPCARGO_FK                                      */
/*==============================================================*/
create index CARGOEMPCARGO_FK on EMPLEADOCARGO (
   IDCARGO ASC
);

/*==============================================================*/
/* Index: EMPEMPCARGO_FK                                        */
/*==============================================================*/
create index EMPEMPCARGO_FK on EMPLEADOCARGO (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_36_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_36_FK on EMPLEADOCARGO (
   CODESPACIO ASC
);

/*==============================================================*/
/* Table: EQUIPO                                                */
/*==============================================================*/
create table EQUIPO (
   CONSEEQUIPO          NUMBER(3,0)           
      generated as identity ( start with 1 nocycle noorder),
   IDDEPORTE            VARCHAR2(2)           not null,
   CODEMPLEADO          VARCHAR2(4)           not null,
   FECHARESOL           DATE                  not null,
   constraint PK_EQUIPO primary key (CONSEEQUIPO)
);

/*==============================================================*/
/* Index: DEPORTEEQUIPO_FK                                      */
/*==============================================================*/
create index DEPORTEEQUIPO_FK on EQUIPO (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Index: ENTRENADOREQUIPO_FK                                   */
/*==============================================================*/
create index ENTRENADOREQUIPO_FK on EQUIPO (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Table: ESPACIO                                               */
/*==============================================================*/
create table ESPACIO (
   CODESPACIO           VARCHAR2(2)           not null,
   IDTIPOESPACIO        VARCHAR2(2)           not null,
   ESP_CODESPACIO       VARCHAR2(2),
   NOMESPACIO           VARCHAR2(30)          not null,
   constraint PK_ESPACIO primary key (CODESPACIO)
);

/*==============================================================*/
/* Index: ESPACIOTIPO_FK                                        */
/*==============================================================*/
create index ESPACIOTIPO_FK on ESPACIO (
   IDTIPOESPACIO ASC
);

/*==============================================================*/
/* Index: ESPACIOESPACIO_FK                                     */
/*==============================================================*/
create index ESPACIOESPACIO_FK on ESPACIO (
   ESP_CODESPACIO ASC
);

/*==============================================================*/
/* Table: ESPACIODEPORTE                                        */
/*==============================================================*/
create table ESPACIODEPORTE (
   IDDEPORTE            VARCHAR2(2)           not null,
   CODESPACIO           VARCHAR2(2)           not null,
   constraint PK_ESPACIODEPORTE primary key (IDDEPORTE, CODESPACIO)
);

/*==============================================================*/
/* Index: ESPACIODEPORTE2_FK                                    */
/*==============================================================*/
create index ESPACIODEPORTE2_FK on ESPACIODEPORTE (
   CODESPACIO ASC
);

/*==============================================================*/
/* Index: ESPACIODEPORTE_FK                                     */
/*==============================================================*/
create index ESPACIODEPORTE_FK on ESPACIODEPORTE (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Table: ESTADO                                                */
/*==============================================================*/
create table ESTADO (
   IDESTADO             VARCHAR2(2)           not null,
   DESCESTADO           VARCHAR2(20)          not null,
   constraint PK_ESTADO primary key (IDESTADO)
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE (
   CODESTU              VARCHAR2(12)          not null,
   CODESPACIO           VARCHAR2(2)           not null,
   NOMESTU              VARCHAR2(30)          not null,
   APELESTU             VARCHAR2(30)          not null,
   FECHAREGESTU         DATE                  not null,
   CORREOUDESTU         VARCHAR2(30)          not null,
   FECHANACESTU         DATE                  not null,
   constraint PK_ESTUDIANTE primary key (CODESTU)
);

/*==============================================================*/
/* Index: ESPACIOESTUDIANTE_FK                                  */
/*==============================================================*/
create index ESPACIOESTUDIANTE_FK on ESTUDIANTE (
   CODESPACIO ASC
);

/*==============================================================*/
/* Table: HORA                                                  */
/*==============================================================*/
create table HORA (
   IDHORA               VARCHAR2(5)           not null,
   constraint PK_HORA primary key (IDHORA)
);

/*==============================================================*/
/* Table: INSCRITOPRACLIBRE                                     */
/*==============================================================*/
create table INSCRITOPRACLIBRE (
   CONSECPROGRA         NUMBER(4,0)           not null,
   CONSECPRACT          NUMBER(4)             
      generated as identity ( start with 1 nocycle noorder),
   CODEMPLEADO          VARCHAR2(4),
   CODESTU              VARCHAR2(12),
   constraint PK_INSCRITOPRACLIBRE primary key (CONSECPROGRA, CONSECPRACT)
);

/*==============================================================*/
/* Index: EMPLEADOPRACLIBRE_FK                                  */
/*==============================================================*/
create index EMPLEADOPRACLIBRE_FK on INSCRITOPRACLIBRE (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Index: INSCRITOPRACTICAPROGRAM_FK                            */
/*==============================================================*/
create index INSCRITOPRACTICAPROGRAM_FK on INSCRITOPRACLIBRE (
   CONSECPROGRA ASC
);

/*==============================================================*/
/* Index: ESTINSCPRACLIBRE_FK                                   */
/*==============================================================*/
create index ESTINSCPRACLIBRE_FK on INSCRITOPRACLIBRE (
   CODESTU ASC
);

/*==============================================================*/
/* Table: MARCA                                                 */
/*==============================================================*/
create table MARCA (
   IDMARCA              VARCHAR2(2)           not null,
   NOMMARCA             VARCHAR2(20)          not null,
   constraint PK_MARCA primary key (IDMARCA)
);

/*==============================================================*/
/* Table: MIEMBROEQUIPO                                         */
/*==============================================================*/
create table MIEMBROEQUIPO (
   CONSEEQUIPO          NUMBER(3,0)           not null,
   ITEMMIEMBRO          NUMBER(3,0)           not null,
   CODESTU              VARCHAR2(12)          not null,
   constraint PK_MIEMBROEQUIPO primary key (CONSEEQUIPO, ITEMMIEMBRO)
);

/*==============================================================*/
/* Index: EQUIPOMIEMBROEQUIPO_FK                                */
/*==============================================================*/
create index EQUIPOMIEMBROEQUIPO_FK on MIEMBROEQUIPO (
   CONSEEQUIPO ASC
);

/*==============================================================*/
/* Index: ESTUDIANTEMIEMEQUIPO_FK                               */
/*==============================================================*/
create index ESTUDIANTEMIEMEQUIPO_FK on MIEMBROEQUIPO (
   CODESTU ASC
);

/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
create table PERIODO (
   IDPERIODO            VARCHAR2(5)           not null,
   constraint PK_PERIODO primary key (IDPERIODO)
);

/*==============================================================*/
/* Table: PRESTAMO                                              */
/*==============================================================*/
create table PRESTAMO (
   CONSECPRESTAMO       NUMBER(4,0)           
      generated as identity ( start with 1 nocycle noorder),
   CONSECPROGRA         NUMBER(4,0)           not null,
   CONSECRES            NUMBER(4,0)           not null,
   CONSECASISRES        NUMBER(4,0)           not null,
   CONSECELEMENTO       NUMBER(5,0)           not null,
   constraint PK_PRESTAMO primary key (CONSECPRESTAMO)
);

/*==============================================================*/
/* Index: ASISTIRREPPRESTAMO_FK                                 */
/*==============================================================*/
create index ASISTIRREPPRESTAMO_FK on PRESTAMO (
   CONSECPROGRA ASC,
   CONSECRES ASC,
   CONSECASISRES ASC
);

/*==============================================================*/
/* Index: PRESTAMOELEMENTO_FK                                   */
/*==============================================================*/
create index PRESTAMOELEMENTO_FK on PRESTAMO (
   CONSECELEMENTO ASC
);

/*==============================================================*/
/* Table: PROGRAMACION                                          */
/*==============================================================*/
create table PROGRAMACION (
   CONSECPROGRA         NUMBER(4,0)          
      generated as identity ( start with 1 nocycle noorder),
   IDDEPORTE            VARCHAR2(2)           not null,
   IDDIA                VARCHAR2(1)           not null,
   IDHORA               VARCHAR2(5)           not null,
   IDACTIVIDAD          VARCHAR2(2)           not null,
   IDPERIODO            VARCHAR2(5)           not null,
   HOR_IDHORA           VARCHAR2(5)           not null,
   CODESPACIO           VARCHAR2(2)           not null,
   CUPO                 NUMBER(3,0)           not null,
   NOINSCRITO           NUMBER(3,0),
   constraint PK_PROGRAMACION primary key (CONSECPROGRA)
);

/*==============================================================*/
/* Index: DEPORTEPROGRAMACION_FK                                */
/*==============================================================*/
create index DEPORTEPROGRAMACION_FK on PROGRAMACION (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Index: DIAPROGRAM_FK                                         */
/*==============================================================*/
create index DIAPROGRAM_FK on PROGRAMACION (
   IDDIA ASC
);

/*==============================================================*/
/* Index: PROGHORAF_FK                                          */
/*==============================================================*/
create index PROGHORAF_FK on PROGRAMACION (
   IDHORA ASC
);

/*==============================================================*/
/* Index: PROGACTIVIDAD_FK                                      */
/*==============================================================*/
create index PROGACTIVIDAD_FK on PROGRAMACION (
   IDACTIVIDAD ASC
);

/*==============================================================*/
/* Index: PROGPERIODO_FK                                        */
/*==============================================================*/
create index PROGPERIODO_FK on PROGRAMACION (
   IDPERIODO ASC
);

/*==============================================================*/
/* Index: PROGHORAI_FK                                          */
/*==============================================================*/
create index PROGHORAI_FK on PROGRAMACION (
   HOR_IDHORA ASC
);

/*==============================================================*/
/* Index: PROGESPACIO_FK                                        */
/*==============================================================*/
create index PROGESPACIO_FK on PROGRAMACION (
   CODESPACIO ASC
);

/*==============================================================*/
/* Table: RESPONSABLE                                           */
/*==============================================================*/
create table RESPONSABLE (
   CONSECPROGRA         NUMBER(4,0)           not null,
   CONSECRES            NUMBER(4,0)           
      generated as identity ( start with 1 nocycle noorder),
   IDROL                VARCHAR2(1),
   CODEMPLEADO          VARCHAR2(4)           not null,
   CODESTU              VARCHAR2(12),
   FECHAINI             DATE                  not null,
   FECHAFIN             DATE                  not null,
   constraint PK_RESPONSABLE primary key (CONSECPROGRA, CONSECRES)
);

/*==============================================================*/
/* Index: ROLRESPONSABLE_FK                                     */
/*==============================================================*/
create index ROLRESPONSABLE_FK on RESPONSABLE (
   IDROL ASC
);

/*==============================================================*/
/* Index: EMPLEADORESPONSABLE_FK                                */
/*==============================================================*/
create index EMPLEADORESPONSABLE_FK on RESPONSABLE (
   CODEMPLEADO ASC
);

/*==============================================================*/
/* Index: ESTUDIANTERESPONSABLE_FK                              */
/*==============================================================*/
create index ESTUDIANTERESPONSABLE_FK on RESPONSABLE (
   CODESTU ASC
);

/*==============================================================*/
/* Index: RESPONSABLEPROG_FK                                    */
/*==============================================================*/
create index RESPONSABLEPROG_FK on RESPONSABLE (
   CONSECPROGRA ASC
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   IDROL                VARCHAR2(1)           not null,
   DESCROL              VARCHAR2(15)          not null,
   constraint PK_ROL primary key (IDROL)
);

/*==============================================================*/
/* Table: TIPOELEMENTO                                          */
/*==============================================================*/
create table TIPOELEMENTO (
   IDTIPOELEMENTO       VARCHAR2(2)           not null,
   DESCTIPOELEMENTO     VARCHAR2(40)          not null,
   constraint PK_TIPOELEMENTO primary key (IDTIPOELEMENTO)
);

/*==============================================================*/
/* Table: TIPOESPACIO                                           */
/*==============================================================*/
create table TIPOESPACIO (
   IDTIPOESPACIO        VARCHAR2(2)           not null,
   DESCTIPOESPACIO      VARCHAR2(30)          not null,
   constraint PK_TIPOESPACIO primary key (IDTIPOESPACIO)
);

alter table ASISMIEMEQUIPO
   add constraint FK_ASISMIEM_ASISTENCI_MIEMBROE foreign key (CONSEEQUIPO, ITEMMIEMBRO)
      references MIEMBROEQUIPO (CONSEEQUIPO, ITEMMIEMBRO);

alter table ASISMIEMEQUIPO
   add constraint FK_ASISMIEM_PROGASISM_PROGRAMA foreign key (CONSECPROGRA)
      references PROGRAMACION (CONSECPROGRA);

alter table ASISTIRRESPONSABLE
   add constraint FK_ASISTIRR_RESPONSAB_RESPONSA foreign key (CONSECPROGRA, CONSECRES)
      references RESPONSABLE (CONSECPROGRA, CONSECRES);

alter table DEPORTETIPOELEM
   add constraint FK_DEPORTET_DEPORTETI_TIPOELEM foreign key (IDTIPOELEMENTO)
      references TIPOELEMENTO (IDTIPOELEMENTO);

alter table DEPORTETIPOELEM
   add constraint FK_DEPORTET_DEPORTETI_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table ELEMENDEPORTIVO
   add constraint FK_ELEMENDE_ELEMENTOT_TIPOELEM foreign key (IDTIPOELEMENTO)
      references TIPOELEMENTO (IDTIPOELEMENTO);

alter table ELEMENDEPORTIVO
   add constraint FK_ELEMENDE_ESPACIOEL_ESPACIO foreign key (CODESPACIO)
      references ESPACIO (CODESPACIO);

alter table ELEMENDEPORTIVO
   add constraint FK_ELEMENDE_ESTADOELE_ESTADO foreign key (IDESTADO)
      references ESTADO (IDESTADO);

alter table ELEMENDEPORTIVO
   add constraint FK_ELEMENDE_MARCAELEM_MARCA foreign key (IDMARCA)
      references MARCA (IDMARCA);

alter table EMPLEADOCARGO
   add constraint FK_EMPLEADO_CARGOEMPC_CARGO foreign key (IDCARGO)
      references CARGO (IDCARGO);

alter table EMPLEADOCARGO
   add constraint FK_EMPLEADO_EMPEMPCAR_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table EMPLEADOCARGO
   add constraint FK_EMPLEADO_RELATIONS_ESPACIO foreign key (CODESPACIO)
      references ESPACIO (CODESPACIO);

alter table EQUIPO
   add constraint FK_EQUIPO_DEPORTEEQ_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table EQUIPO
   add constraint FK_EQUIPO_ENTRENADO_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table ESPACIO
   add constraint FK_ESPACIO_ESPACIOES_ESPACIO foreign key (ESP_CODESPACIO)
      references ESPACIO (CODESPACIO);

alter table ESPACIO
   add constraint FK_ESPACIO_ESPACIOTI_TIPOESPA foreign key (IDTIPOESPACIO)
      references TIPOESPACIO (IDTIPOESPACIO);

alter table ESPACIODEPORTE
   add constraint FK_ESPACIOD_ESPACIODE_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table ESPACIODEPORTE
   add constraint FK_ESPACIOD_ESPACIODE_ESPACIO foreign key (CODESPACIO)
      references ESPACIO (CODESPACIO);

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_ESPACIOES_ESPACIO foreign key (CODESPACIO)
      references ESPACIO (CODESPACIO);

alter table INSCRITOPRACLIBRE
   add constraint FK_INSCRITO_EMPLEADOP_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table INSCRITOPRACLIBRE
   add constraint FK_INSCRITO_ESTINSCPR_ESTUDIAN foreign key (CODESTU)
      references ESTUDIANTE (CODESTU);

alter table INSCRITOPRACLIBRE
   add constraint FK_INSCRITO_INSCRITOP_PROGRAMA foreign key (CONSECPROGRA)
      references PROGRAMACION (CONSECPROGRA);

alter table MIEMBROEQUIPO
   add constraint FK_MIEMBROE_EQUIPOMIE_EQUIPO foreign key (CONSEEQUIPO)
      references EQUIPO (CONSEEQUIPO);

alter table MIEMBROEQUIPO
   add constraint FK_MIEMBROE_ESTUDIANT_ESTUDIAN foreign key (CODESTU)
      references ESTUDIANTE (CODESTU);

alter table PRESTAMO
   add constraint FK_PRESTAMO_ASISTIRRE_ASISTIRR foreign key (CONSECPROGRA, CONSECRES, CONSECASISRES)
      references ASISTIRRESPONSABLE (CONSECPROGRA, CONSECRES, CONSECASISRES);

alter table PRESTAMO
   add constraint FK_PRESTAMO_PRESTAMOE_ELEMENDE foreign key (CONSECELEMENTO)
      references ELEMENDEPORTIVO (CONSECELEMENTO);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_DEPORTEPR_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_DIAPROGRA_DIA foreign key (IDDIA)
      references DIA (IDDIA);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_PROGACTIV_ACTIVIDA foreign key (IDACTIVIDAD)
      references ACTIVIDAD (IDACTIVIDAD);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_PROGESPAC_ESPACIO foreign key (CODESPACIO)
      references ESPACIO (CODESPACIO);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_PROGHORAF_HORA foreign key (IDHORA)
      references HORA (IDHORA);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_PROGHORAI_HORA foreign key (HOR_IDHORA)
      references HORA (IDHORA);

alter table PROGRAMACION
   add constraint FK_PROGRAMA_PROGPERIO_PERIODO foreign key (IDPERIODO)
      references PERIODO (IDPERIODO);

alter table RESPONSABLE
   add constraint FK_RESPONSA_EMPLEADOR_EMPLEADO foreign key (CODEMPLEADO)
      references EMPLEADO (CODEMPLEADO);

alter table RESPONSABLE
   add constraint FK_RESPONSA_ESTUDIANT_ESTUDIAN foreign key (CODESTU)
      references ESTUDIANTE (CODESTU);

alter table RESPONSABLE
   add constraint FK_RESPONSA_RESPONSAB_PROGRAMA foreign key (CONSECPROGRA)
      references PROGRAMACION (CONSECPROGRA);

alter table RESPONSABLE
   add constraint FK_RESPONSA_ROLRESPON_ROL foreign key (IDROL)
      references ROL (IDROL);



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


-- EQUIPO   
INSERT INTO equipo VALUES (
    'at',
    'atletismo'
);

INSERT INTO equipo VALUES (
    'tm',
    'tenis mesa'
);

INSERT INTO equipo VALUES (
    'na',
    'natacion'
);

INSERT INTO equipo VALUES (
    'vo',
    'voleibol'
);

INSERT INTO equipo VALUES (
    'fu',
    'futbol'
);

INSERT INTO equipo VALUES (
    'am',
    'artes marciales'
);

INSERT INTO equipo VALUES (
    'fs',
    'futbol sala'
);

INSERT INTO equipo VALUES (
    'ae',
    'aerobicos'
);

INSERT INTO equipo VALUES (
    'bo',
    'boxeo'
);

INSERT INTO equipo VALUES (
    'go',
    'gimnasia olimpica'
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
    '20181020135',
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
INSERT INTO responsable VALUES ( 1,
DEFAULT,
'1',
'0003',
NULL,
current_date,
current_date+4);
--2
INSERT INTO responsable VALUES ( 2,
DEFAULT,
'1',
'0002',
NULL,
current_date,
current_date+4);
--3
INSERT INTO responsable VALUES ( 3,
DEFAULT,
'1',
'0002',
NULL,
current_date,
current_date+5);
--4
INSERT INTO responsable VALUES ( 4,
DEFAULT,
'1',
'0002',
NULL,
current_date,
current_date+3);
--5 En1
INSERT INTO responsable VALUES ( 5,
DEFAULT,
'3',
'0011',
NULL,
current_date,
current_date+6);
--6 En2
INSERT INTO responsable VALUES ( 6,
DEFAULT,
'3',
'0010',
NULL,
current_date,
current_date+2);
--7 En3
INSERT INTO responsable VALUES ( 7,
DEFAULT,
'3',
'0010',
NULL,
current_date,
current_date+7);
--8 En4
INSERT INTO responsable VALUES ( 8,
DEFAULT,
'3',
'0010',
NULL,
current_date,
current_date+8);
--9 Pr1
INSERT INTO responsable VALUES ( 9,
DEFAULT,
'2',
'0005',
NULL,
current_date,
current_date+6);
--10 Pr2
INSERT INTO responsable VALUES ( 10,
DEFAULT,
'2',
'0004',
NULL,
current_date,
current_date+3);
--11 Pr3
INSERT INTO responsable VALUES ( 11,
DEFAULT,
'2',
'0006',
NULL,
current_date,
current_date+6);
--12 Pr4
INSERT INTO responsable VALUES ( 12,
DEFAULT,
'2',
'0006',
NULL,
current_date,
current_date+8);
      
    
