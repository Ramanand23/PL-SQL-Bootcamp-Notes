EXEC dbms_output.put_line('Test No:1');
/
SET SERVEROUTPUT ON;
EXEC dbms_output.put_line('Test No:2');
/
EXEC dbms_output.put('Test No:3');
/
EXEC dbms_output.put_line('Test No:4');
/
SET SERVEROUTPUT OFF
/
CREATE TABLE temp_table(ID NUMBER GENERATED ALWAYS AS IDENTITY, text VARCHAR2(1000));
/
EXEC dbms_output.enable;
EXEC dbms_output.put_line('Hi');
/
DECLARE
    v_buffer VARCHAR2(1000);
    v_status INTEGER;
BEGIN
    dbms_output.put('...');
    dbms_output.put_line('Hello');
    dbms_output.put_line('How are you');
    FOR I IN 1..10 LOOP
        dbms_output.get_line(v_buffer,v_status);
        IF v_status = 0 THEN 
            INSERT INTO temp_table(text) VALUES (v_buffer);
        END IF;
    END LOOP;
END;
/
SELECT * FROM temp_table;
/
SET SERVEROUTPUT ON;
DECLARE
    v_buffer VARCHAR2(1000);
    v_status INTEGER;
BEGIN
    dbms_output.put('...');
    dbms_output.put_line('Hello');
    dbms_output.put_line('How are you');
    dbms_output.get_line(v_buffer,v_status);
END;
/
SET SERVEROUTPUT OFF;
EXEC dbms_output.enable;
/
DECLARE
    v_buffer dbms_output.chararr;
    v_num_lines INTEGER:= 30;
BEGIN
    dbms_output.put('...');
    dbms_output.put_line('Hello');
    dbms_output.put_line('How are you');
    dbms_output.get_lines(v_buffer,v_num_lines);
    FOR i IN 1..v_num_lines LOOP
        INSERT INTO temp_table(text) VALUES (v_buffer(I));
    END LOOP;
END;
/
DROP TABLE temp_table;