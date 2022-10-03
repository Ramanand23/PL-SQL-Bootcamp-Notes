---------------------------------------------------------------------------------------------
-------------------------------:NEW & :OLD QUALIFIERS IN TRIGGERS----------------------------
---------------------------------------------------------------------------------------------
create or replace trigger before_row_emp_cpy 
before insert or update or delete on employees_copy 
referencing old as O new as N
for each row
begin
  dbms_output.put_line('Before Row Trigger is Fired!.');
  dbms_output.put_line('The Salary of Employee '||:o.employee_id
    ||' -> Before:'|| :o.salary||' After:'||:n.salary);
end;

---------------------------------------------------------------------------------------------
--------------------------------USING CONDITIONAL PREDICATES --------------------------------
---------------------------------------------------------------------------------------------
create or replace trigger before_row_emp_cpy 
before insert or update or delete on employees_copy 
referencing old as O new as N
for each row
begin
  dbms_output.put_line('Before Row Trigger is Fired!.');
  dbms_output.put_line('The Salary of Employee '||:o.employee_id
    ||' -> Before:'|| :o.salary||' After:'||:n.salary);
  if inserting then
    dbms_output.put_line('An INSERT occurred on employees_copy table');
  elsif deleting then
    dbms_output.put_line('A DELETE occurred on employees_copy table');
  elsif updating ('salary') then
    dbms_output.put_line('A Updating occurred on the salary column');
  elsif updating then
    dbms_output.put_line('An UPDATE occurred on employees_copy table');
  end if;
end;



---------------------------------------------------------------------------------------------
------------------------USING RAISE_APPLICATION_ERROR PROCEDURE WITH TRIGGERS----------------
---------------------------------------------------------------------------------------------
create or replace trigger before_row_emp_cpy 
before insert or update or delete on employees_copy 
referencing old as O new as N
for each row
begin
  dbms_output.put_line('Before Row Trigger is Fired!.');
  dbms_output.put_line('The Salary of Employee '||:o.employee_id
    ||' -> Before:'|| :o.salary||' After:'||:n.salary);
  if inserting then
    if :n.hire_date > sysdate then
      raise_application_error(-20000,'You cannot enter a future hire..');
    end if;
  elsif deleting then
    raise_application_error(-20001,'You cannot delete from the employees_copy table..');
  elsif updating ('salary') then
    if :n.salary > 50000 then
      raise_application_error(-20002,'A salary cannot be higher than 50000..');
    end if;
  elsif updating then
    dbms_output.put_line('An UPDATE occurred on employees_copy table');
  end if;
end;

---------------------------------------------------------------------------------------------
--------------------------------USING UPDATE OF EVENT IN TRIGGERS----------------------------
---------------------------------------------------------------------------------------------
create or replace trigger prevent_updates_of_constant_columns
before update of hire_date,salary on employees_copy 
for each row
begin
  raise_application_error(-20005,'You cannot modify the hire_date and salary columns');
end;



---------------------------------------------------------------------------------------------
----------------------------------USING WHEN CLAUSE ON TRIGGERS------------------------------
---------------------------------------------------------------------------------------------
create or replace trigger prevent_high_salary
before insert or update of salary on employees_copy 
for each row
when (new.salary > 50000)
begin
  raise_application_error(-20006,'A salary cannot be higher than 50000!.');
end;
set serveroutput on;
update employees_copy set salary = salary + 100;
delete from employees_copy;

update employees_copy set salary = salary + 100
where employee_id = 30;

alter table employees_copy disable all triggers;
/
update employees_copy set salary = salary + 100
where department_id = 30;
/
delete from employees_copy;
/
 desc employees_copy
/ 
insert into employees_copy select * from employees;
/
update employees_copy set salary = 60000;
/
update employees_copy set hire_date=sysdate;
/
