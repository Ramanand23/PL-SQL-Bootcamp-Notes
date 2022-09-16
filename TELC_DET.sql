desc all_tables


set serveroutput on
declare 
    cursor t_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%';
    v_g_date t_date%rowtype;
    --v_b_date t_date.TABLE_DATE%type;
begin
    open t_date;
    loop 
        fetch t_date into v_g_date;
        exit when t_date%notfound; 
        dbms_output.put_line(v_g_date.TABLE_DATE);
        IF ((to_number(to_char(to_date(v_g_date.TABLE_DATE,'YYYYMMDD'),'J')-2415020) - 44279) < 0) THEN
        --IF (( 1 - 2 ) > 0) THEN
            dbms_output.put_line(v_g_date.TABLE_DATE);
        ELSE 
            dbms_output.put_line('Negative number');
            EXIT;
        END IF;    
    end loop;
    close t_date;
end;

---------------------------------------------------------------------------------------------------------------------------------------------------------

declare
    cursor t_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%';
    v_g_date t_date%rowtype;
    --v_b_date t_date.TABLE_DATE%type;
begin
    open t_date;
    loop
        fetch t_date into v_g_date;
       --exit when t_date%notfound;
       --dbms_output.put_line(v_g_date.TABLE_DATE);
        IF ((to_number(to_char(to_date(v_g_date.TABLE_DATE,'YYYYMMDD'),'J')-2415020) - 44279) > 0) THEN
            dbms_output.put_line(v_g_date.TABLE_DATE);
        /*ELSE
            dbms_output.put_line('Negative number');
            EXIT;*/
        END IF;
        exit when t_date%notfound;
    end loop;
    close t_date;
end;



set serveroutput on
declare
    cursor t_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%';
    v_table_name all_tables.table_name%type;
begin
    for i in t_date loop
        if (to_number(to_char(to_date(i.TABLE_DATE,'YYYYMMDD'),'J')-2415020) - 44113) > 0 then
                dbms_output.put_line(i.TABLE_NAME);
        end if;
    end loop;
    dbms_output.put_line(v_table_name);
end;
/

----------------------------------------------------------------------------------------------------------------------------------
set serveroutput on
declare
    type v_table_name is table of all_tables%rowtype;
    v_telc_tab v_table_name;
    cursor t_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%';
begin
    for t_date in (select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%') loop
        if (to_number(to_char(to_date(t_date.TABLE_DATE,'YYYYMMDD'),'J')-2415020) - 44113) > 0 then
                v_telc_tab(t_date.table_name) := t_date; 
        end if;
    end loop;
end;
/
------------------------------------------------------------------------------------------------------------------------------------

Using package

create or replace package tellr_det as 
  type v_table_name is table of all_tables%rowtype index by VARCHAR2(64);
  cursor tab_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%'; 
  procedure teller_tables; 
  function get_telc_tables return v_table_name;
  
end tellr_det;

set serveroutput on
create or replace PACKAGE BODY tellr_det_body AS

  /*
    This function returns all the employees in employees table
  */
BEGIN  
    
    begin 
    null;
    end;
    
    
    function get_telc_tables return v_table_name is
    v_telc_tab v_table_name;
    begin
        for tab_date in (select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%') loop
            if (to_number(to_char(to_date(t_date.TABLE_DATE,'YYYYMMDD'),'J')-2415020) - 44113) > 0 then
              v_telc_tab(t_date.table_name) := t_date; 
              dbms_output.put_line(v_telc_tab);
            end if;
        end loop;
        
        return v_telc_tab;
    end;
end tellr_det_body;    


declare
    type telc_table_name is table of all_tables.table_name%type index by BINARY_INTEGER;
    type telc_table_date is table of varchar(64) index by BINARY_INTEGER;

    v_table_name telc_table_name;
    v_table_date telc_table_date;

    cursor t_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%';
begin
    open t_date;
       fetch t_date bulk collect into v_table_name,v_table_date;
       dbms_output.put_line('Checking out loop ');
       for i in 1..v_table_name.count
       LOOP
       IF ((to_number(to_char(to_date(v_table_date(i),'YYYYMMDD'),'J')-2415020) - 44279) > 0) THEN
        
        execute immediate 'select count(*) from '|| v_table_name(i) into row_count;    
        dbms_output.put_line('v_table_name : ' || v_table_name(i) || ' v_table_date : ' || v_table_date(i) || ' v_table_count : ' || row_count)  ;
        dbms_output.put_line('v_table_name : ' || v_table_name(i) || ' v_table_date : ' || v_table_date(i));
       
       END IF;
       end loop;
    close t_date;
end;

------------------------------------------------------------------------------------------------------------------------------

insert into DATE_WISE_TELLER_DETAILS
            (TELLR_ID,
            BRH_NO,                  /*inserting into columns and fetching column name  should not be same. Should be differenct*/
            FIRST_LOGIN_TIME,
            LAST_LOGOUT_TIME,
            DT)
select TELLER_ID,
            BRANCH_NO,
            MIN(CHANGE_TIME),
            MAX(CHANGE_TIME),
            CHANGE_DT from table(v_table_name(i)) where SOC_NO = '003' and TRAN_NO = '009001' group by TELLER_ID,BRANCH_NO,TRUNC(CHANGE_TIME) order by TELLER_ID,BRANCH_NO,TRUNC(CHANGE_TIME);
----------------------------------------------------



declare
    type telc_table_name is table of all_tables.table_name%type index by BINARY_INTEGER;
    type telc_table_date is table of varchar(64) index by BINARY_INTEGER;

    v_table_name telc_table_name;
    v_table_date telc_table_date;
    
    socno char(3) := '003';
    login_tran char(6) := '009001';
    logout_tran char(6) := '009003';
    login_query VARCHAR2(2000);

    cursor t_date is select TABLE_NAME,TO_NUMBER((substr(TABLE_NAME,6,8)),99999999) "TABLE_DATE" from all_tables where TABLE_NAME like 'TELC%';
begin
    open t_date;
       fetch t_date bulk collect into v_table_name,v_table_date;
       dbms_output.put_line('Checking out loop ');
       for i in 1..v_table_name.count
       LOOP
       IF ((to_number(to_char(to_date(v_table_date(i),'YYYYMMDD'),'J')-2415020) - 44279) > 0) THEN
        
        --insrt := 'insert into DATE_WISE_TELLER_DETAILS(TELLER_ID,BRANCH_NO,FIRST_LOGIN_TIME,FIRST_LOGIN_TIME,LAST_LOGOUT_TIME,DT)';
        login_query  := 'select TELLER_ID,BRANCH_NO,MIN(CHANGE_TIME),CHANGE_DT from ' || v_table_name(i) || ' where SOC_NO = ''' || socno || ''' and TRAN_NO = ''' || login_tran || ''' group by TELLER_ID,BRANCH_NO,CHANGE_TIME order by TELLER_ID,BRANCH_NO,CHANGE_TIME';
        execute immediate 'insert into DATE_WISE_TELLER_DETAILS(TELLR_ID,BRH_NO,FIRST_LOGIN_TIME,DT) ' || login_query ;        
        dbms_output.put_line('v_table_name : ' || v_table_name(i) || ' v_table_date : ' || v_table_date(i) || ' v_table_count : ')  ;
        dbms_output.put_line('v_table_name : ' || v_table_name(i) || ' v_table_date : ' || v_table_date(i));
       
       END IF;
       end loop;
    close t_date;
end;

desc DATE_WISE_TELLER_DETAILS

desc telc
@/app/oracle/product/19.3.0/dbhome_1/rdbms/admin/catproc.sql


insert into DATE_WISE_TELLER_DETAILS (TELLR_ID,BRH_NO,FIRST_LOGIN_TIME,LAST_LOGOUT_TIME,DT) 
select TELLER_ID,BRANCH_NO,MIN(CHANGE_TIME),MAX(CHANGE_TIME),CHANGE_DT from telc where SOC_NO = '003' and TRAN_NO = '009001' group by TELLER_ID,BRANCH_NO,CHANGE_TIME,CHANGE_DT order by TELLER_ID,BRANCH_NO,CHANGE_TIME,CHANGE_DT;

'select TELLER_ID,BRANCH_NO,CHANGE_TIME,CHANGE_DT from ' || v_table_name(i) || ' where SOC_NO = ''' || socno || ''' and TRAN_NO = ''' || login_tran || ''' group by TELLER_ID,BRANCH_NO,CHANGE_TIME order by TELLER_ID,BRANCH_NO,CHANGE_TIME';

truncate table DATE_WISE_TELLER_DETAILS;
select * from DATE_WISE_TELLER_DETAILS;

SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Diag Trace';

SELECT TELLER_ID,
CASE
  WHEN TRAN_NO = 009001 THEN MIN(CHANGE_TIME)
  WHEN TRAN_NO = 009003  THEN MAX(CHANGE_TIME) 
  ELSE 'The owner is another value'
END
FROM TELC group by teller_id,change_time,tran_no;


select * from TELC where  tran_no = '009003';

--------------------------------------------------------------------------------------------
select 
TELLER_ID,
BRANCH_NO,
MIN(CHANGE_TIME),
--MAX(CHANGE_TIME),
CHANGE_DT 
from telc 
where SOC_NO = '003' and TRAN_NO = '009001'
group by TELLER_ID,BRANCH_NO,TRUNC(CHANGE_TIME),CHANGE_DT order by TELLER_ID,BRANCH_NO,TRUNC(CHANGE_TIME),CHANGE_DT;
--------------------------------------------------------------------------------------------------

select A.TELLER_ID,A.BRANCH_NO,A.CHANGE_DT,A.LOGIN_TIME,B.LOGOFF_TIME from 
(select TELLER_ID,BRANCH_NO,CHANGE_DT,MIN(CHANGE_TIME) LOGIN_TIME from archsbi.TELC_20220828 where TRAN_NO = '009001' and CHANGE_DT = '01082022' and TELLER_ID = '0000000003305619' group by TELLER_ID,BRANCH_NO,CHANGE_DT) A
LEFT JOIN 
(select TELLER_ID,BRANCH_NO,CHANGE_DT,MAX(CHANGE_TIME) LOGOFF_TIME from archsbi.TELC_20220828 where TRAN_NO = '009003' and CHANGE_DT = '01082022' and TELLER_ID = '0000000003305619' group by TELLER_ID,BRANCH_NO,CHANGE_DT) B ON A.TELLER_ID=B.TELLER_ID AND A.BRANCH_NO=B.BRANCH_NO and A.CHANGE_DT=B.CHANGE_DT ;

SELECT TELLER_ID,BRANCH_NO,CHANGE_DT,
CASE WHEN TRAN_NO = '009001' THEN (MIN(CHANGE_TIME))
END AS LOGIN_TIME,
CASE WHEN TRAN_NO = '009003' THEN (MAX(CHANGE_TIME))
END AS LOGOUT_TIME
FROM archsbi.TELC_20220828 group by TELLER_ID,BRANCH_NO,CHANGE_DT,TRAN_NO order by TELLER_ID,BRANCH_NO,CHANGE_DT;
------------------------------------------------------------------------------------------------------

select brhm.BR_NAME,brhm.CIRCLE_CODE,DATE_WISE_TELLER_DETAILS.BRH_NO from brhm inner join DATE_WISE_TELLER_DETAILS on substr(brhm.key_1,15,5) = DATE_WISE_TELLER_DETAILS.BRH_NO;


select to_number(to_char(to_date(20220419,'YYYYMMDD'),'J')-2415020) from dual;


select brhm.BR_NAME,brhm.CIRCLE_CODE,DATE_WISE_TELLER_DETAILS.BRH_NO from brhm,DATE_WISE_TELLER_DETAILS where substr(brhm.key_1,15,5) = DATE_WISE_TELLER_DETAILS.BRH_NO;   


select substr(brhm.key_1,15,5) from brhm;

-------------------------------------------------------------------------------------------------------------------
