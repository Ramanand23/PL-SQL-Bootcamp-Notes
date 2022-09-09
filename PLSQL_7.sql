set serveroutput on
/*CASE IS USED TO CHECK THE SALARY RAISE USING v_job_code. If you change the value of v_job_code the o/p will change*/
declare 
    v_job_code varchar2(10):= 'SA_MAN';
    v_salary_increase number;
begin
    v_salary_increase := case v_job_code
            when 'SA_MAN' then 0.2
            when 'SA_REP' then 0.3
            else 0
            end;
    dbms_output.put_line('Your salary increase is : '|| v_salary_increase);
end;


/**/
declare 
    v_job_code varchar2(10):= 'SA_MAN';
    v_salary_increase number;
    v_department varchar2(10) := 'IT';
begin
    v_salary_increase := case 
            when v_job_code = 'SA_MAN' then 0.2
            when v_job_code = 'SA_REP' then 0.3
            when v_job_code in ('SA_REP','IT_PROG') then 0.2
            when v_job_code = 'SA_REP' or v_job_code = 'IT_PROG' then 0.3
            when v_department = 'IT' and v_job_code = 'IT_PROG' then 0.3
            else 0
            end;
    dbms_output.put_line('Your salary increase is : '|| v_salary_increase);
end;




begin
    for someone in (select * from employees where employee_id <120 order by employee_id)
    LOOP
        dbms_output.put_line('First Name = ' || someone.first_name || ', Last Name = ' || someone.last_name);
    END LOOP;
end;
/


----------------------------CASE EXPRESSIONS--------------------------------
declare
  v_job_code varchar2(10) := 'SA_MAN';
  v_salary_increase number;
begin
  v_salary_increase := case v_job_code 
    when 'SA_MAN' then 0.2
    when 'SA_REP' then 0.3
    else 0
  end;
  dbms_output.put_line('Your salary increase is : '|| v_salary_increase);
end;
-------------------------SEARCHED CASE EXPRESSION----------------------------
declare
  v_job_code varchar2(10) := 'IT_PROG';
  v_department varchar2(10) := 'IT';
  v_salary_increase number;
begin
  v_salary_increase := case  
    when v_job_code = 'SA_MAN' then 0.2
    when v_department = 'IT' and v_job_code = 'IT_PROG' then 0.3
    else 0
  end;
  dbms_output.put_line('Your salary increase is : '|| v_salary_increase);
end;
---------------------------CASE STATEMENTS------------------------------------
declare
  v_job_code varchar2(10) := 'IT_PROG';
  v_department varchar2(10) := 'IT';
  v_salary_increase number;
begin
  case  
    when v_job_code = 'SA_MAN' then 
      v_salary_increase := 0.2;
      dbms_output.put_line('The salary increase for a Sales Manager is : '|| v_salary_increase);
    when v_department = 'IT' and v_job_code = 'IT_PROG' then 
      v_salary_increase := 0.2;
      dbms_output.put_line('The salary increase for a Sales Manager is : '|| v_salary_increase);
    else 
      v_salary_increase := 0;
      dbms_output.put_line('The salary increase for this job code is : '|| v_salary_increase);
  end CASE;
end;
-------------------------------------------------------------------------------