BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON EMPLOYEES TO SYS';
END; 
/
BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON EMPLOYEES TO SYS;';
END;
/
CREATE OR REPLACE PROCEDURE prc_create_table_dynamic 
    (p_table_name IN VARCHAR2, p_col_specs IN VARCHAR2) IS
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE '||p_table_name||' ('||p_col_specs||')';
END;
/
EXEC prc_create_table_dynamic('dynamic_temp_table', 'id NUMBER PRIMARY KEY, name VARCHAR2(100)');
/
SELECT * FROM dynamic_temp_table;
/
CREATE OR REPLACE PROCEDURE prc_generic (p_dynamic_sql IN VARCHAR2) IS
BEGIN
    EXECUTE IMMEDIATE p_dynamic_sql;
END;
/
EXEC prc_generic('drop table dynamic_temp_table');
/
EXEC prc_generic('drop procedure PRC_CREATE_TABLE_DYNAMIC');
/
DROP PROCEDURE prc_generic;


------EXECUTE IMMEDIATE STATEMENT with the USING Clause (Code Samples)

CREATE TABLE names (ID NUMBER PRIMARY KEY, NAME VARCHAR2(100));
/
CREATE OR REPLACE FUNCTION insert_values (ID IN VARCHAR2, NAME IN VARCHAR2) RETURN PLS_INTEGER IS
BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO names VALUES(:a, :b)' USING ID,NAME;
    RETURN SQL%rowcount;
END;
/
SET SERVEROUTPUT ON;
DECLARE 
    v_affected_rows PLS_INTEGER;
BEGIN
    v_affected_rows := insert_values(2,'John');
    dbms_output.put_line(v_affected_rows|| ' row inserted!');
END;
/
SELECT * FROM names;
/
ALTER TABLE names ADD (last_name VARCHAR2(100));
/
CREATE OR REPLACE FUNCTION update_names (ID IN VARCHAR2, last_name IN VARCHAR2) RETURN PLS_INTEGER IS
    v_dynamic_sql VARCHAR2(200);
BEGIN
    v_dynamic_sql := 'UPDATE names SET last_name = :1 WHERE id = :2' ;
    EXECUTE IMMEDIATE v_dynamic_sql USING last_name, ID;
    RETURN SQL%rowcount;
END;
/
DECLARE 
    v_affected_rows PLS_INTEGER;
BEGIN
    v_affected_rows := update_names(2,'Brown');
    dbms_output.put_line(v_affected_rows|| ' row updated!');
END;
/
CREATE OR REPLACE FUNCTION update_names (ID IN VARCHAR2, last_name IN OUT VARCHAR2) RETURN PLS_INTEGER IS
    v_dynamic_sql VARCHAR2(200);
BEGIN
    v_dynamic_sql := 'UPDATE names SET last_name = :1 WHERE id = :2' ;
    EXECUTE IMMEDIATE v_dynamic_sql USING IN OUT last_name, ID;
    RETURN SQL%rowcount;
END;
/
CREATE OR REPLACE FUNCTION update_names (ID IN VARCHAR2, last_name IN VARCHAR2, first_name OUT VARCHAR2) RETURN PLS_INTEGER IS
    v_dynamic_sql VARCHAR2(200);
BEGIN
    v_dynamic_sql := 'UPDATE names SET last_name = :1 WHERE id = :2 :3' ;
    EXECUTE IMMEDIATE v_dynamic_sql USING last_name, ID, OUT first_name;
    RETURN SQL%rowcount;
END;
/
DECLARE 
    v_affected_rows PLS_INTEGER;
    v_first_name VARCHAR2(100);
BEGIN
    v_affected_rows := update_names(2,'KING',v_first_name);
    dbms_output.put_line(v_affected_rows|| ' row updated!');
    dbms_output.put_line(v_first_name);
END;
/
CREATE OR REPLACE FUNCTION update_names (ID IN VARCHAR2, last_name IN VARCHAR2, first_name OUT VARCHAR2) RETURN PLS_INTEGER IS
    v_dynamic_sql VARCHAR2(200);
BEGIN
    v_dynamic_sql := 'UPDATE names SET last_name = :1 WHERE id = :2 RETURNING name INTO :3' ;
    EXECUTE IMMEDIATE v_dynamic_sql USING last_name, ID RETURNING INTO first_name;
    RETURN SQL%rowcount;
END;
/
DROP TABLE names;
DROP FUNCTION insert_values;
DROP FUNCTION update_names;


-----------EXECUTE IMMEDIATE STATEMENT with the USING and INTO Clauses (Code Samples)

CREATE OR REPLACE FUNCTION get_count (table_name IN VARCHAR2) RETURN PLS_INTEGER IS
    v_count PLS_INTEGER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || table_name INTO v_count;
    RETURN v_count;
END;
/
SET SERVEROUTPUT ON;
BEGIN
    dbms_output.put_line('There are '||get_count('employees')||' rows in the employees table!');
END;
/
DECLARE
    v_table_name VARCHAR2(50);
BEGIN
    FOR r_table IN (SELECT table_name FROM user_tables) LOOP
        dbms_output.put_line('There are '||get_count(r_table.table_name)||' rows in the '||r_table.table_name||' table!');
    END LOOP;
END;
/
DECLARE
    v_table_name VARCHAR2(50);
BEGIN
    FOR r_table IN (SELECT table_name FROM user_tables) LOOP
        IF get_count(r_table.table_name) > 100 THEN
            dbms_output.put_line('There are '||get_count(r_table.table_name)||' rows in the '||r_table.table_name||' table!');
            dbms_output.put_line('It should be considered for partitioning');
        END IF;
    END LOOP;
END;
/
 
CREATE TABLE stock_managers AS SELECT * FROM employees WHERE job_id = 'ST_MAN';
/
CREATE TABLE stock_clerks AS SELECT * FROM employees WHERE job_id = 'ST_CLERK';
/
CREATE OR REPLACE FUNCTION get_avg_sals (p_table IN VARCHAR2, p_dept_id IN NUMBER) RETURN PLS_INTEGER IS
    v_average PLS_INTEGER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT AVG(salary) FROM :1 WHERE department_id = :2' INTO v_average USING p_table, p_dept_id;
    RETURN v_average;
END;
/
SELECT get_avg_sals('stock_clerks','50') FROM dual;
/
CREATE OR REPLACE FUNCTION get_avg_sals (p_table IN VARCHAR2, p_dept_id IN NUMBER) RETURN PLS_INTEGER IS
    v_average PLS_INTEGER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT AVG(salary) FROM '||p_table||' WHERE department_id = :2' INTO v_average USING p_dept_id;
    RETURN v_average;
END;
/
SELECT get_avg_sals('stock_managers','50') FROM dual;
/
DROP FUNCTION get_count;
DROP FUNCTION get_avg_sals;
DROP TABLE stock_clerks;
DROP TABLE stock_managers;

----Execute Immediate with Bulk Collect (Code Samples)


DECLARE
   TYPE t_name IS TABLE OF VARCHAR2(20);
   names   t_name;
BEGIN
    EXECUTE IMMEDIATE 'SELECT distinct first_name FROM employees'
        BULK COLLECT INTO names;
    FOR i IN 1..names.COUNT LOOP
        dbms_output.put_line(names(i));
    END LOOP;
END;
/
CREATE TABLE employees_copy AS SELECT * FROM employees; 
/
DECLARE
   TYPE t_name IS TABLE OF VARCHAR2(20);
   names   t_name;
BEGIN
    EXECUTE IMMEDIATE 'UPDATE employees_copy SET salary = salary + 1000 WHERE department_id = 30 RETURNING first_name INTO :a'
        RETURNING BULK COLLECT INTO names;
    FOR i IN 1..names.COUNT LOOP
        dbms_output.put_line(names(i));
    END LOOP;
END;
/
DROP TABLE employees_copy;

