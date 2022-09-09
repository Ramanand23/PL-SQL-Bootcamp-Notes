create table employee_copy_1 as select * from employees;
select * from employee_copy_1

create sequence employee_id_seq start with 207 increment by 1;


begin
  for i in 1..10 loop
       insert into employee_copy_1 
      (employee_id,first_name,last_name,email,hire_date,job_id,salary)
    values 
    (employee_id_seq.nextval, 'employee#'||employee_id_seq.nextval,'temp_emp','abc@xmail.com',sysdate,'IT_PROG',1000);
 end loop;
end;        


declare
  v_seq_num number;
begin
  select employee_id_seq.nextval into v_seq_num from dual;
  dbms_output.put_line(v_seq_num);
end;
----------------------------
declare
  v_seq_num number;
begin
  select employee_id_seq.nextval into v_seq_num from employees_copy where rownum = 1;
  dbms_output.put_line(v_seq_num);
end;
----------------------------
declare
  v_seq_num number;
begin
  v_seq_num := employee_id_seq.nextval; 
  dbms_output.put_line(v_seq_num);
end;
----------------------------
begin
  dbms_output.put_line(employee_id_seq.nextval);
end;
----------------------------
begin
  dbms_output.put_line(employee_id_seq.currval);
end;