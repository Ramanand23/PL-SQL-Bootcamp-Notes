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
