create table employees_copy as select * from employees;
select * from employees_copy;

DECLARE
  v_employee_id pls_integer := 0;
  v_salary_increase number := 400;
begin
  for i in 217..226 loop
       -- insert into employees_copy 
      --(employee_id,first_name,last_name,email,hire_date,job_id,salary)
    --values 
    --(i, 'employee#'||i,'temp_emp','abc@xmail.com',sysdate,'IT_PROG',1000);
    --update employees_copy 
     ---set salary = salary + v_salary_increase
     --where employee_id = i;
     delete from employees_copy
     where employee_id = i;
 end loop;
end;     