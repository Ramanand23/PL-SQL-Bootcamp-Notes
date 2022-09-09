set SERVEROUTPUT ON
declare
    v_num number := null;
begin
    if v_num < 10 then
        DBMS_OUTPUT.PUT_LINE(' I am smaller than 10');
    elsif v_num < 20 then
        dbms_output.put_line( ' I am smaller than 20');
    elsif v_num <30 then 
        dbms_output.put_line(' I am smaller than 30');
    else
        dbms_output.put_line('I am equal or greater than 30');
    end if;
end;
/* We can add as many statements as we want inside IF,ELSIF,ELSE control structures*/
/* Another IF statment inside our IF statement*/

declare
    v_num number := null;
begin
    if v_num < 10 then
        DBMS_OUTPUT.PUT_LINE(' I am smaller than 10');
    elsif v_num < 20 then
        dbms_output.put_line( ' I am smaller than 20');
    elsif v_num <30 then
        dbms_output.put_line(' I am smaller than 30');
    else
      if v_num is null then  
        dbms_output.put_line('The number is null');
      else
        dbms_output.put_line('I am equal or greater than 30');
      end if;  
    end if;
end;


/* Adding Multiple checks */

declare
    v_num number := 10;
    v_name char(20) := 'Jai Shree Krishna';
begin
    if v_num < 10 and v_name = 'Jai Shree Ram' then
        DBMS_OUTPUT.PUT_LINE(' I am smaller than 10');
    elsif v_num < 20 then
        dbms_output.put_line( ' I am smaller than 20');
    elsif v_num <30 then
        dbms_output.put_line(' I am smaller than 30');
    else
      if v_num is null then  
        dbms_output.put_line('The number is null');
      else
        dbms_output.put_line('I am equal or greater than 30');
      end if;  
    end if;
end;


------------------------------IF STATEMENTS--------------------------------
set serveroutput on;
declare
v_number number := 30;
begin
  if v_number < 10 then
    dbms_output.put_line('I am smaller than 10');
  elsif v_number < 20 then
    dbms_output.put_line('I am smaller than 20');
  elsif v_number < 30 then
    dbms_output.put_line('I am smaller than 30');
  else
    dbms_output.put_line('I am equal or greater than 30');
  end if;
end;
---------------------------------------------------------------------------
declare
v_number number := 5;
v_name varchar2(30) := 'Adam';
begin
  if v_number < 10 or v_name = 'Carol' then
    dbms_output.put_line('HI');
    dbms_output.put_line('I am smaller than 10');
  elsif v_number < 20 then
    dbms_output.put_line('I am smaller than 20');
  elsif v_number < 30 then
    dbms_output.put_line('I am smaller than 30');
  else
    if v_number is null then 
      dbms_output.put_line('The number is null..');
    else
      dbms_output.put_line('I am equal or greater than 30');
    end if;
  end if;
end;
---------------------------------------------------------------------------