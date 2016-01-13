/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2015/3/27 14:55:49                           */
/*==============================================================*/



-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger "CompoundDeleteTrigger_am_asset"
/

drop trigger "CompoundInsertTrigger_am_asset"
/

drop trigger "CompoundUpdateTrigger_am_asset"
/

drop trigger "tib_am_asset_change_info"
/

drop trigger "CompoundDeleteTrigger_am_asset"
/

drop trigger "CompoundInsertTrigger_am_asset"
/

drop trigger "CompoundUpdateTrigger_am_asset"
/

drop trigger "tib_am_asset_damage_info"
/

drop trigger "CompoundDeleteTrigger_am_asset"
/

drop trigger "CompoundInsertTrigger_am_asset"
/

drop trigger "CompoundUpdateTrigger_am_asset"
/

drop trigger "tib_am_asset_info"
/

drop trigger "CompoundDeleteTrigger_am_asset"
/

drop trigger "CompoundInsertTrigger_am_asset"
/

drop trigger "CompoundUpdateTrigger_am_asset"
/

drop trigger "tib_am_asset_sale_info"
/

drop trigger "CompoundDeleteTrigger_am_dd"
/

drop trigger "CompoundInsertTrigger_am_dd"
/

drop trigger "CompoundUpdateTrigger_am_dd"
/

drop trigger "tib_am_dd"
/

drop trigger "CompoundDeleteTrigger_am_maint"
/

drop trigger "CompoundInsertTrigger_am_maint"
/

drop trigger "CompoundUpdateTrigger_am_maint"
/

drop trigger "tib_am_maintain_info"
/

drop trigger "CompoundDeleteTrigger_am_requi"
/

drop trigger "CompoundInsertTrigger_am_requi"
/

drop trigger "CompoundUpdateTrigger_am_requi"
/

drop trigger "tib_am_requisition_info"
/

alter table AM_ASSET_CHANGE_INFO
   drop constraint FK_AM_ASSET_REFERENCE_AM_ACI
/

alter table AM_ASSET_DAMAGE_INFO
   drop constraint FK_AM_ASSET_REFERENCE_AM_ADI
/

alter table AM_ASSET_INFO
   drop constraint FK_AM_ASSET_REFERENCE_AM_T1
/

alter table AM_ASSET_INFO
   drop constraint FK_AM_ASSET_REFERENCE_AM_T2
/

alter table AM_ASSET_SALE_INFO
   drop constraint FK_AM_ASSET_REFERENCE_AM_ASI
/

alter table AM_MAINTAIN_INFO
   drop constraint FK_AM_ASSET_REFERENCE_AM_AMI
/

alter table AM_REQUISITION_INFO
   drop constraint FK_AM_REQUI_REFERENCE_AM_RI
/

drop table AM_ASSET_CHANGE_INFO cascade constraints
/

drop table AM_ASSET_DAMAGE_INFO cascade constraints
/

drop table AM_ASSET_INFO cascade constraints
/

drop table AM_ASSET_SALE_INFO cascade constraints
/

drop table AM_DD cascade constraints
/

drop table AM_MAINTAIN_INFO cascade constraints
/

drop table AM_REQUISITION_INFO cascade constraints
/

drop sequence "Sequence_1"
/

drop sequence "Sequence_am_aci"
/

drop sequence "Sequence_am_adi"
/

drop sequence "Sequence_am_ai"
/

drop sequence "Sequence_am_asi"
/

drop sequence "Sequence_am_dd"
/

drop sequence "Sequence_am_mi"
/

drop sequence "Sequence_am_ri"
/

create sequence "Sequence_1"
/

create sequence "Sequence_am_aci"
start with 1
/

create sequence "Sequence_am_adi"
start with 1
/

create sequence "Sequence_am_ai"
start with 1
/

create sequence "Sequence_am_asi"
start with 1
/

create sequence "Sequence_am_dd"
start with 1
/

create sequence "Sequence_am_mi"
/

create sequence "Sequence_am_ri"
start with 1
/

/*==============================================================*/
/* Table: AM_ASSET_CHANGE_INFO                                  */
/*==============================================================*/
create table AM_ASSET_CHANGE_INFO 
(
   ID                   NUMBER(19)           not null,
   CHANGE_TIME          DATE,
   ASSET_ID             NUMBER(19),
   OLD_BM_ID            NUMBER(19),
   OLD_YH_ID            NUMBER(19),
   NOW_BM_ID            NUMBER(19),
   NOW_YH_ID            NUMBER(19),
   REMARK               VARCHAR2(500),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_ASSET_CHANGE_INFO primary key (ID)
)
/

/*==============================================================*/
/* Table: AM_ASSET_DAMAGE_INFO                                  */
/*==============================================================*/
create table AM_ASSET_DAMAGE_INFO 
(
   ID                   NUMBER(19)           not null,
   REMARK               VARCHAR2(500),
   DAMAGE_REASON        VARCHAR2(500),
   APPRAISAL_OPINION    VARCHAR2(500),
   APPRAISALER          VARCHAR2(20),
   APPRAISALER_TIME     DATE,
   APPROVE_OPINION      VARCHAR2(500),
   ASSET_ID             NUMBER(19),
   BM_ID                NUMBER(19),
   YH_ID                NUMBER(19),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_ASSET_DAMAGE_INFO primary key (ID)
)
/

/*==============================================================*/
/* Table: AM_ASSET_INFO                                         */
/*==============================================================*/
create table AM_ASSET_INFO 
(
   ID                   NUMBER(19)           not null,
   ASSET_NO             VARCHAR2(20),
   MODEL                VARCHAR2(30),
   EQUIP_NUMBER         VARCHAR2(50),
   NAME                 VARCHAR2(100),
   BELONGTO             VARCHAR2(20),
   MEASURE              VARCHAR2(10),
   PRODUCT_DATE         DATE,
   SUPPLY_UNIT          VARCHAR2(20),
   MONEY                NUMBER(19),
   PRODUCE_UNIT         VARCHAR2(50),
   STRAT_USE_TIME       DATE,
   DEPRECIATION         NUMBER(8,4),
   USED_YEARS           NUMBER(19),
   LIFE_YEARS           NUMBER(19),
   AM_ASSET_DUAL_TYPE_ID NUMBER(19),
   AM_ASSET_TYPE_ID     NUMBER(19),
   BM_ID                NUMBER(19),
   YH_ID                NUMBER(19),
   EQUIPMENT_ATTACH     VARCHAR2(500),
   REMARK               VARCHAR2(500),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_ASSET_INFO primary key (ID)
)
/

/*==============================================================*/
/* Table: AM_ASSET_SALE_INFO                                    */
/*==============================================================*/
create table AM_ASSET_SALE_INFO 
(
   ID                   NUMBER(19)           not null,
   PURCHANGE_UNIT       VARCHAR2(20),
   MONEY                NUMBER(8,2),
   PURCHANGE_TIME       DATE,
   CONTACT_MODE         VARCHAR2(50),
   ASSET_ID             NUMBER(19),
   BM_ID                NUMBER(19),
   REMARK               VARCHAR2(500),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_ASSET_SALE_INFO primary key (ID)
)
/

/*==============================================================*/
/* Table: AM_DD                                                 */
/*==============================================================*/
create table AM_DD 
(
   ID                   NUMBER(19)           not null,
   NAME                 VARCHAR2(50),
   CODE                 VARCHAR2(20),
   TYPE                 VARCHAR2(20),
   REMARK               VARCHAR2(200),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_DD primary key (ID)
)
/

/*==============================================================*/
/* Table: AM_MAINTAIN_INFO                                      */
/*==============================================================*/
create table AM_MAINTAIN_INFO 
(
   ID                   NUMBER(19)           not null,
   AM_LEVEL             VARCHAR2(20),
   AM_TIME              DATE,
   AM_DAYS              NUMBER(19),
   CONSTRUCT_UNIT       VARCHAR2(50),
   REASON               VARCHAR2(200),
   MATERIAL             VARCHAR2(100),
   MATERIAL_MONEY       NUMBER(8,2),
   LABORAGE_MONEY       NUMBER(8,2),
   MAINTAIN_MONEY       NUMBER(8,2),
   ASSET_ID             NUMBER(19),
   BM_ID                NUMBER(19),
   REMARK               VARCHAR2(200),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_MAINTAIN_INFO primary key (ID)
)
/

/*==============================================================*/
/* Table: AM_REQUISITION_INFO                                   */
/*==============================================================*/
create table AM_REQUISITION_INFO 
(
   ID                   NUMBER(19)           not null,
   RID                  VARCHAR2(50),
   AM_TIME              DATE,
   PRODUCE_UNIT         VARCHAR2(100),
   QUANTITY             NUMBER(19),
   MONEY                NUMBER(8,2),
   REASON               VARCHAR2(200),
   PURCHASE_CONDITION   VARCHAR2(200),
   PERSON_CONDITION     VARCHAR2(10),
   ECONMY_BENEFIT       NUMBER(8,2),
   USE_RATE             NUMBER(8,2),
   APPROVE_OPINION      VARCHAR2(20),
   APPROVE_REMARK       VARCHAR2(200),
   BM_ID                NUMBER(19),
   YH_ID                NUMBER(19),
   ASSET_ID             NUMBER(19),
   REMARK               VARCHAR2(200),
   LR_SJ                DATE,
   YH_XM                VARCHAR(50),
   BM_CCBH              VARCHAR2(50),
   YH_ZH                VARCHAR2(50),
   XG_SJ                DATE,
   XGYH_ZH              VARCHAR2(50),
   SC_SJ                DATE,
   SCYH_ZH              VARCHAR2(50),
   ZT                   VARCHAR2(1),
   constraint PK_AM_REQUISITION_INFO primary key (ID)
)
/

alter table AM_ASSET_CHANGE_INFO
   add constraint FK_AM_ASSET_REFERENCE_AM_ACI foreign key (ASSET_ID)
      references AM_ASSET_INFO (ID)
/

alter table AM_ASSET_DAMAGE_INFO
   add constraint FK_AM_ASSET_REFERENCE_AM_ADI foreign key (ASSET_ID)
      references AM_ASSET_INFO (ID)
/

alter table AM_ASSET_INFO
   add constraint FK_AM_ASSET_REFERENCE_AM_T1 foreign key (AM_ASSET_TYPE_ID)
      references AM_DD (ID)
/

alter table AM_ASSET_INFO
   add constraint FK_AM_ASSET_REFERENCE_AM_T2 foreign key (AM_ASSET_DUAL_TYPE_ID)
      references AM_DD (ID)
/

alter table AM_ASSET_SALE_INFO
   add constraint FK_AM_ASSET_REFERENCE_AM_ASI foreign key (ASSET_ID)
      references AM_ASSET_INFO (ID)
/

alter table AM_MAINTAIN_INFO
   add constraint FK_AM_ASSET_REFERENCE_AM_AMI foreign key (ASSET_ID)
      references AM_ASSET_INFO (ID)
/

alter table AM_REQUISITION_INFO
   add constraint FK_AM_REQUI_REFERENCE_AM_RI foreign key (ASSET_ID)
      references AM_ASSET_INFO (ID)
/


create or replace trigger "CompoundDeleteTrigger_am_asset"
for delete on AM_ASSET_CHANGE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_asset"
for insert on AM_ASSET_CHANGE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_asset"
for update on AM_ASSET_CHANGE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_asset_change_info" before insert
on AM_ASSET_CHANGE_INFO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_aci
    select Sequence_am_aci.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_am_asset"
for delete on AM_ASSET_DAMAGE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_asset"
for insert on AM_ASSET_DAMAGE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_asset"
for update on AM_ASSET_DAMAGE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_asset_damage_info" before insert
on AM_ASSET_DAMAGE_INFO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_adi
    select Sequence_am_adi.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_am_asset"
for delete on AM_ASSET_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_asset"
for insert on AM_ASSET_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_asset"
for update on AM_ASSET_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_asset_info" before insert
on AM_ASSET_INFO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_ai
    select Sequence_am_ai.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_am_asset"
for delete on AM_ASSET_SALE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_asset"
for insert on AM_ASSET_SALE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_asset"
for update on AM_ASSET_SALE_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_asset_sale_info" before insert
on AM_ASSET_SALE_INFO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_asi
    select Sequence_am_asi.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_am_dd"
for delete on AM_DD compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_dd"
for insert on AM_DD compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_dd"
for update on AM_DD compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_dd" before insert
on AM_DD for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_dd
    select Sequence_am_dd.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_am_maint"
for delete on AM_MAINTAIN_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_maint"
for insert on AM_MAINTAIN_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_maint"
for update on AM_MAINTAIN_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_maintain_info" before insert
on AM_MAINTAIN_INFO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_mi
    select Sequence_am_mi.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create or replace trigger "CompoundDeleteTrigger_am_requi"
for delete on AM_REQUISITION_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundInsertTrigger_am_requi"
for insert on AM_REQUISITION_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create or replace trigger "CompoundUpdateTrigger_am_requi"
for update on AM_REQUISITION_INFO compound trigger
// Declaration
// Body
  before statement is
  begin
     NULL;
  end before statement;

  before each row is
  begin
     NULL;
  end before each row;

  after each row is
  begin
     NULL;
  end after each row;

  after statement is
  begin
     NULL;
  end after statement;

END
/


create trigger "tib_am_requisition_info" before insert
on AM_REQUISITION_INFO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence Sequence_am_ri
    select Sequence_am_ri.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

DROP TRIGGER "CompoundDeleteTrigger_am_asset";
DROP TRIGGER "CompoundInsertTrigger_am_asset";
DROP TRIGGER "CompoundUpdateTrigger_am_asset";
DROP TRIGGER "tib_am_asset_change_info";

DROP TRIGGER "tib_am_asset_damage_info";

DROP TRIGGER "tib_am_asset_info";

DROP TRIGGER "tib_am_asset_sale_info";

DROP TRIGGER "CompoundDeleteTrigger_am_dd";
DROP TRIGGER "CompoundInsertTrigger_am_dd";
DROP TRIGGER "CompoundUpdateTrigger_am_dd";
DROP TRIGGER "tib_am_dd";


DROP TRIGGER "CompoundDeleteTrigger_am_maint";
DROP TRIGGER "CompoundInsertTrigger_am_maint";
DROP TRIGGER "CompoundUpdateTrigger_am_maint";
DROP TRIGGER "tib_am_maintain_info";


DROP TRIGGER "CompoundDeleteTrigger_am_requi";
DROP TRIGGER "CompoundInsertTrigger_am_requi";
DROP TRIGGER "CompoundUpdateTrigger_am_requi";
DROP TRIGGER "tib_am_requisition_info";

