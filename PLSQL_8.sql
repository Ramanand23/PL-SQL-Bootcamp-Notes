set serveroutput on 
declare 
    v_counter number(2) := 1;
begin
    loop 
     dbms_output.put_line('My counter is :' || v_counter);
     v_counter := v_counter+1;
     if v_counter = 10 then 
       dbms_output.put_line ('Now i reached the maximum value : '|| v_counter);
       exit;
     end if;
    end loop;
end;


set serveroutput on 
declare 
    v_counter number(2) := 1;
begin
    loop 
     dbms_output.put_line('My counter is :' || v_counter);
     v_counter := v_counter+1;
     --exit when v_counter = 10;
     exit when v_counter > 10;       
    end loop;
end; 

-------------------------BASIC LOOPS--------------------------
declare
v_counter number(2) := 1;
begin
  loop
    dbms_output.put_line('My counter is : '|| v_counter);
    v_counter := v_counter + 1;
    --if v_counter = 10 then
    --  dbms_output.put_line('Now I reached : '|| v_counter);
    --  exit;
    --end if;
    exit when v_counter > 10;
  end loop;
end;
--------------------------------------------------------------
    