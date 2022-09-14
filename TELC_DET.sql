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
