create or replace type t_phone_number as record (p_type varchar2(10),p_number varchar2(50));
/*as records cannot be created at schema level we have to use object which can be created at schema level*/
create or replace type t_phone_number as object (p_type varchar2(10),p_number varchar2(50));
/
create or replace type v_phone_numbers as varray(3) of t_phone_number; /*VARRAY*/
/
create table emps_with_phones (employee_id number,
                               first_name varchar(50),
                               last_name varchar2(50),
                               phone_number v_phone_numbers);
/
select * from emps_with_phones2;
/
insert into emps_with_phones values (10,'Alex','Brown',v_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                                                        t_phone_number('WORK','222.755.8454'),
                                                                        t_phone_number('MOB1','333.767.9767')));
/
insert into emps_with_phones values (10,'Alex','Brown',v_phone_numbers(t_phone_number('HOME','777.711.1111'),
                                                                        t_phone_number('WORK','322.733.2222')));
/*To print the result in beautified way. Run the previous code with script runner button*/
select e.last_name,e.first_name,p.p_type,p.p_number from emps_with_phones e, table(e.phone_number) p; /*Used Table Operato r*/


/*NESTED TABLES */



create or replace type t_phone_number as object (p_type varchar2(10),p_number varchar2(50));
/
create or replace type n_phone_numbers as table of t_phone_number; /*NESTED TABLE*/
/
create table emps_with_phones2 (employee_id number,
                               first_name varchar(50),
                               last_name varchar2(50),
                               phone_number n_phone_numbers)
                               NESTED TABLE phone_number STORE AS phone_numbers_table;
/
select * from emps_with_phones2;
/
insert into emps_with_phones2 values (10,'Alex','Brown',n_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                                                        t_phone_number('WORK','222.755.8454'),
                                                                        t_phone_number('MOB1','333.767.9767')));
/
insert into emps_with_phones2 values (11,'Alex','Brown',n_phone_numbers(t_phone_number('HOME','777.711.1111'),
                                                                        t_phone_number('WORK','322.733.2222')));
                                                                        
insert into emps_with_phones2 values (10,'Alex','Brown',n_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                                                        t_phone_number('WORK','222.755.8454'),
                                                                        t_phone_number('MOB1','333.767.9767'),
                                                                        t_phone_number('MOB2','323.867.9767'),
                                                                        t_phone_number('MOB3','353.767.9787'),
                                                                        t_phone_number('MOB4','313.167.9667'),
                                                                        t_phone_number('MOB5','563.267.6767'),
                                                                        t_phone_number('MOB6','373.787.9888')));
/*To print the result in beautified way. Run the previous code with script runner button*/
select e.last_name,e.first_name,p.p_type,p.p_number from emps_with_phones2 e, table(e.phone_number) p; /*Used Table Operato r*/


/*What if you want to add new values to nested tables? We use update query*/

update emps_with_phones2 set phone_number = n_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                                                        t_phone_number('WORK7','222.755.8454'),
                                                                        t_phone_number('MOB7','333.767.9767'),
                                                                        t_phone_number('MOB8','323.867.9767')) where employee_id =11;
                                                                        
/**/ 

declare
 p_num n_phone_numbers;
begin
    select phone_number into p_num from emps_with_phones2 where employee_id =  11;
    p_num.extend;
    p_num(3) := t_phone_number('FAX','999.99.999');
    update emps_with_phones2 set phone_number = p_num where employee_id = 11;
end;

