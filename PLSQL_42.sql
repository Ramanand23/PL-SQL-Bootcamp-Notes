---------------------------------------------------------------------------------------------
-----------------------------------USING INSTEAD OF TRIGGERS---------------------------------
---------------------------------------------------------------------------------------------
----------------- creating a complex view -----------------
CREATE OR REPLACE VIEW VW_EMP_DETAILS AS
  SELECT UPPER(DEPARTMENT_NAME) DNAME, MIN(SALARY) MIN_SAL, MAX(SALARY) MAX_SAL 
    FROM EMPLOYEES_COPY JOIN DEPARTMENTS_COPY
    USING (DEPARTMENT_ID)
    GROUP BY DEPARTMENT_NAME;
	
	
/  
create table DEPARTMENTS_COPY as select * from departments;
/
UPDATE vw_emp_details set dname = 'EXEC DEPT' where UPPER(DNAME) = 'EXECUTIVE';
/*shows error as you cannot do update on complex view*/
/
SELECT * FROM DEPARTMENTS_COPY;
/
SELECT * FROM VW_EMP_DETAILS;
/
DELETE FROM VW_EMP_DETAILS WHERE DNAME = 'EXEC DEPT';
/
INSERT INTO VW_EMP_DETAILS VALUES ('EXECUTION',NULL,NULL);
/
UPDATE VW_EMP_DETAILS SET MIN_SAL = 5000 WHERE DNAME = 'ACCOUNTING';
----------------- updating the complex view -----------------



UPDATE VW_EMP_DETAILS SET DNAME = 'EXEC DEPT' WHERE
  UPPER(DNAME) = 'EXECUTIVE';
----------------- Instead of trigger -----------------


CREATE OR REPLACE TRIGGER EMP_DETAILS_VW_DML
  INSTEAD OF INSERT OR UPDATE OR DELETE ON VW_EMP_DETAILS
  FOR EACH ROW
  DECLARE
    V_DEPT_ID PLS_INTEGER;
  BEGIN
  
  IF INSERTING THEN
    SELECT MAX(DEPARTMENT_ID) + 10 INTO V_DEPT_ID FROM DEPARTMENTS_COPY;
    INSERT INTO DEPARTMENTS_COPY VALUES (V_DEPT_ID, :NEW.DNAME,NULL,NULL);
  ELSIF DELETING THEN
    DELETE FROM DEPARTMENTS_COPY WHERE UPPER(DEPARTMENT_NAME) = UPPER(:OLD.DNAME);
  ELSIF UPDATING('DNAME') THEN
    UPDATE DEPARTMENTS_COPY SET DEPARTMENT_NAME = :NEW.DNAME
      WHERE UPPER(DEPARTMENT_NAME) = UPPER(:OLD.DNAME);
  ELSE
    RAISE_APPLICATION_ERROR(-20007,'You cannot update any data other than department name!.');
  END IF;
END;
---------------------------------------------------------------------------------------------
-----------------------------------CREATING DISABLED TRIGGERS--------------------------------
---------------------------------------------------------------------------------------------  
create or replace trigger prevent_high_salary
before insert or update of salary on employees_copy 
for each row
disable
when (new.salary > 50000)
begin
  raise_application_error(-20006,'A salary cannot be higher than 50000!.');
end;
/
SELECT * FROM USER_TRIGGERS;
/
ALTER TABLE EMPLOYEES_COPY DISABLE ALL TRIGGERS;
