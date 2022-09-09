begin 
    update employees_copy set email = null where employee_id = 100;
end;    

-----------------------------------Handling a nonpredefined exception
declare
 cannot_update_to_null exception;
 pragma exception_init(cannot_update_to_null,-01407);
begin
 update employees_copy set email = null where employee_id = 100;
exception 
 when cannot_update_to_null then
    dbms_output.put_line ('You cannot update with a null!');
end;