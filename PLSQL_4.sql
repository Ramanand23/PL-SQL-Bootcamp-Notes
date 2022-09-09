set serveroutput on

DECLARE
    v_outer VARCHAR(50) := 'Outer !!';
BEGIN
    BEGIN
        dbms_output.put_line('Inside inner block ->' || v_outer);
    END;
    dbms_output.put_line(v_outer);
END;

/*now using the nested block with new variable*/

DECLARE
    v_outer VARCHAR(50) := 'Outer !!';
BEGIN
    declare
    v_inner varchar2(30) := 'Inner Variable';
    BEGIN
        dbms_output.put_line('Inside block ->' || v_outer);
        dbms_output.put_line('Inside_inner block ->' || v_inner);
    END;
    dbms_output.put_line('Outside_ inner ->' || v_inner);
    dbms_output.put_line(v_outer);
END;



/*SAME NAME VARIABLES ONCE INSIDE THE BOX AND NEXT OUTSIDE THE BOX*/

DECLARE
    v_text varchar2(30) := 'Out-text';
    --v_outer VARCHAR(50) := 'Outer !!';
BEGIN
    declare
    --v_inner varchar2(30) := 'Inner Variable';
    v_text varchar2(30) := 'In-text';
    BEGIN
        --dbms_output.put_line('Inside block ->' || v_outer);
        --dbms_output.put_line('Inside_inner block ->' || v_text);
        dbms_output.put_line('Inside_innerr block ->'  || v_text);
        dbms_output.put_line('Inside_outer block  ->'  || v_text);
    END;
    --dbms_output.put_line('Outside_ inner ->' || v_inner);
    --dbms_output.put_line(v_outer);
    dbms_output.put_line('Outside -> '|| v_text);
END;





/*TO REACH OUTER VARIABLE FROM INNER BLOCK*/

begin  <<outer>>
DECLARE
    v_text varchar2(30) := 'Out-text';
    --v_outer VARCHAR(50) := 'Outer !!';
BEGIN
    declare
    --v_inner varchar2(30) := 'Inner Variable';
    v_text varchar2(30) := 'In-text';
    BEGIN
        --dbms_output.put_line('Inside block ->' || v_outer);
        --dbms_output.put_line('Inside_inner block ->' || v_text);
        dbms_output.put_line('Inside_innerr block ->'  || v_text);
        dbms_output.put_line('Inside_outer block  ->'  || outer.v_text);
    END;
    --dbms_output.put_line('Outside_ inner ->' || v_inner);
    --dbms_output.put_line(v_outer);
    dbms_output.put_line('Outside -> '|| v_text);
END;
end outer;


------------------------VARIABLE SCOPE--------------------------
begin <<outer>>
DECLARE
  --v_outer VARCHAR2(50) := 'Outer Variable!';
  v_text  VARCHAR2(20) := 'Out-text';
BEGIN 
  DECLARE
    v_text  VARCHAR2(20) := 'In-text';
    v_inner VARCHAR2(30) := 'Inner Variable';
  BEGIN
    --dbms_output.put_line('inside -> ' || v_outer);
    --dbms_output.put_line('inside -> ' || v_inner);
      dbms_output.put_line('inner -> ' || v_text);
      dbms_output.put_line('outer -> ' || outer.v_text);
  END;
  --dbms_output.put_line('inside -> ' || v_inner);
  --dbms_output.put_line(v_outer);
  dbms_output.put_line(v_text);
END;
END outer;
----------------------------------------------------------------
  







