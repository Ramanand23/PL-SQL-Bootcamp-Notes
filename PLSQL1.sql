Set SERVEROUTPUT ON
BEGIN
dbms_output.put_line('Hello world');
END;
/

begin
dbms_output.put_line('hello world');
  begin
  DBMS_OUTPUT.PUT_LINE('This string breaks here.');
  END;
end;