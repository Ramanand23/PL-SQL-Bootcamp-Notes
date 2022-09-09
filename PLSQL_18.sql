declare 
    CURSOR c_emps is select first_name,last_name from employees;
    v_firstname employees.first_name%type;
    v_lastname employees.last_name%type;
begin
    open c_emps ;
    fetch c_emps into v_firstname,v_lastname;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname);
    close c_emps;
end;    
set serveroutput on;
/*When two fetches is done. The second fetch returns the next row because it is queried,fetched next o/p*/
declare 
    CURSOR c_emps is select first_name,last_name from employees;
    v_firstname employees.first_name%type;
    v_lastname employees.last_name%type;
begin
    open c_emps ;
    fetch c_emps into v_firstname,v_lastname;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname);
    fetch c_emps into v_firstname,v_lastname;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname);
    close c_emps;
end;    

declare 
    CURSOR c_emps is select first_name,last_name from employees;
    v_firstname employees.first_name%type;
    v_lastname employees.last_name%type;
begin
    open c_emps ;
    fetch c_emps into v_firstname,v_lastname;
    fetch c_emps into v_firstname,v_lastname;
    fetch c_emps into v_firstname,v_lastname;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname);
    fetch c_emps into v_firstname,v_lastname;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname);
    close c_emps;
end;    

--- Cursor using JOins


declare 
    CURSOR c_emps is select first_name,last_name,department_name from employees join departments using (department_id) where department_id between 30 and 60;
    v_firstname employees.first_name%type;
    v_lastname employees.last_name%type;
    v_department_name departments.department_name%type;
begin
    open c_emps ;
    fetch c_emps into v_firstname,v_lastname,v_department_name;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname || ' in the department of ' || v_department_name);
    fetch c_emps into v_firstname,v_lastname,v_department_name;
    DBMS_OUTPUT.PUT_LINE(v_firstname || ' ' || v_lastname || ' in the department of ' || v_department_name);
    close c_emps;
end;   