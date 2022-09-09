/*% USING TYPE ATTRIBUTE */
set serveroutput on
desc employees;
declare
v_type  employees.job_id%type;
V_TYPE2 V_TYPE%TYPE;
v_type3 employees.job_id%type;
begin
 v_type := 'IT_PROG';
 V_TYPE2 := 'SA_MAN';
 v_type3 := NULL;
 DBMS_OUTPUT.PUT_LINE(v_type);
 DBMS_OUTPUT.PUT_LINE(V_TYPE2);
 DBMS_OUTPUT.PUT_LINE(V_TYPE3 || 'HELLO');
END; 


---------------------%TYPE ATTRIBUTE---------------------
desc employees;
declare
V_TYPE employees.JOB_ID%TYPE;
V_TYPE2 V_TYPE%TYPE;
V_TYPE3 employees.JOB_ID%TYPE ;
begin
v_type := 'IT_PROG';
v_type2 := 'SA_MAN';
v_type3 := NULL;
dbms_output.put_line(v_type);
dbms_output.put_line(v_type2);
dbms_output.put_line('HELLO' || v_type3);
end;
---------------------------------------------------------

/* PL/SQL 4 */   
------------------DELIMITERS AND COMMENTING------------------
DECLARE
V_TEXT VARCHAR2(10):= 'PL/SQL';
BEGIN
--This is a single line comment
/* This is a 
    multi line
    comment */
--DBMS_OUTPUT.PUT_LINE(V_TEXT || ' is a good language');
null;
END;
-------------------------------------------------------------
  