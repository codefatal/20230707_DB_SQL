SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE KDY_GUGUDAN
IS--DECLARE
    I NUMBER := 2;
    J NUMBER := 1;
BEGIN
    
    FOR J IN 1..9 LOOP
        FOR I IN 2..9 LOOP
            DBMS_OUTPUT.PUT(I||'*'||J||'='||(I*J)||' ' );
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/
EXEC KDY_GUGUDAN;

select * from user_source;