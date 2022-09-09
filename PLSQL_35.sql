create table logs (log_source varchar2(100), log_message varchar2(1000), log_date date);
set serveroutput on;
exec DBMS_OUTPUT.PUT_LINE(emp_pkg.get_avg_sal(80));

select * from logs;

exec DBMS_OUTPUT.PUT_LINE(emp_pkg.v_salary_increase_rate);
