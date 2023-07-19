SET SERVEROUTPUT ON;
SET SERVEROUTPUT OFF;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');   
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD2');   
    DBMS_OUTPUT.PUT('HELLO WORLD3');   
    DBMS_OUTPUT.PUT('HELLO WORLD4');
    DBMS_OUTPUT.PUT_LINE();
--���� ���� -
--ORA-06550: �� 6, ��5:PLS-00306: 'PUT_LINE' ȣ�� �� �μ��� ������ ������ �߸��Ǿ����ϴ�
--ORA-06550: �� 6, ��5:PL/SQL: Statement ignored
--06550. 00000 -  "line %s, column %s:\n%s"
END;
/
create or replace procedure pro_dept_insert
--DECLARE
is
    maxdno dept.deptno%type;
    dno dept.deptno%type;
--    dnm dept.dname%type;
--    dloc dept.loc%type;
BEGIN
    select max(deptno) into maxdno from dept;
    insert into emp (ename, empno, deptno) values ('EJ5', maxdno+10, 20);
    insert into emp (ename, empno, deptno) values ('EJ5', maxdno+10, 20);
    -- procedure �� update, delete, select �� ��� Ȱ�� ������.
    commit;
END;
/
select * from user_procedures;
-- ROWTYPE
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/
-- TYPE - IS TABLE OF
-- TYPE - IS RECORD


DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0) 
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    IF BONUS = 0  THEN
        DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
        DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
END;
/
DECLARE
    SCORE INT;
    GRADE VARCHAR2(2);
BEGIN
    SCORE := '&SCORE';
    IF SCORE >= 90 THEN 
        GRADE := 'A';
        DBMS_OUTPUT.PUT_LINE('������ 90�� �̻����� A�����Դϴ�.');
    ELSIF SCORE >= 80 THEN 
        GRADE := 'B';
        DBMS_OUTPUT.PUT_LINE('������ 80 �̻����� B�����Դϴ�.');
    ELSIF SCORE >= 70 THEN 
        GRADE := 'C';
        DBMS_OUTPUT.PUT_LINE('������ 70 �̻����� C�����Դϴ�.');
    ELSIF SCORE >= 60 THEN 
        GRADE := 'D';
        DBMS_OUTPUT.PUT_LINE('������ 60 �̻����� D�����Դϴ�.');
    ELSE 
        GRADE := 'F';
        DBMS_OUTPUT.PUT_LINE('������ 60 �̸����� F�����Դϴ�.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�,  ������ ' || GRADE || '�����Դϴ�.');
END;

/
BEGIN
    FOR N IN (select emp_name, salary from employee) LOOP
        DBMS_OUTPUT.PUT_LINE(N.emp_name || ', '||N.salary);
    END LOOP;
END;

/
BEGIN
    FOR EMP_LIST IN (
        SELECT EMPNO, ENAME 
            FROM EMP
            WHERE EMPNO < 8000
            ORDER BY EMPNO
        )
    LOOP
        DBMS_OUTPUT.PUT_LINE('�����ȣ:' || EMP_LIST.EMPNO || ', ����̸�:' || EMP_LIST.ENAME);
    END LOOP;
END;
/
--CREATE OR REPLACE PROCEDURE KDY_GUGUDAN
--/
DECLARE
    DUP_EMPNO EXCEPTION;
    PRAGMA EXCEPTION_INIT(DUP_EMPNO, -00001);
    NOTEXIST_TABLEVIEW EXCEPTION;
    PRAGMA EXCEPTION_INIT(NOTEXIST_TABLEVIEW, -00942);
BEGIN
    UPDATE EMPLOYEE    SET EMP_ID = '&���'    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_EMPNO THEN 
        DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
        DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�!!!.');
    WHEN NOTEXIST_TABLEVIEW THEN 
        DBMS_OUTPUT.PUT_LINE('���� ���̺� �Դϴ�.');
        DBMS_OUTPUT.PUT_LINE('���� view ������ �����');
END;
/
--���� ���� -
--ORA-00001: ���Ἲ ���� ����(KH.EMPLOYEE_PK)�� ����˴ϴ�
UPDATE EMPLOYEE    SET EMP_ID = '&���'    WHERE EMP_ID = 200;
--SQL ����: ORA-00942: ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�
--00942. 00000 -  "table or view does not exist"
UPDATE EMPLOYEEa    SET EMP_ID = '&���'    WHERE EMP_ID = 200;


select * from user_source;

-- procedure �����
-- �����ȣ�� ���޹޾Ƽ� �̸�, �޿�, ������ ��ȯ��.
create or replace procedure PRO_EMP_ARG_TEST
        ( ARG_EMPNO in EMP.EMPNO%TYPE
        , ARG_ENAME out EMP.ename%TYPE
        , ARG_SAL out EMP.sal%TYPE
        , ARG_JOB out EMP.job%TYPE        )
is
begin
    dbms_output.put_line('ARG_EMPNO: '|| ARG_EMPNO);
    select ename, sal, job
    into ARG_ENAME, ARG_SAL, ARG_JOB
    from emp
    where empno=ARG_EMPNO;
    
    dbms_output.put_line('ARG_ENAME: '|| ARG_ENAME);
    -- procedure �� return ����.- ��� �Ű������� IN / OUT �� �����ؼ� OUT�� �����ϸ� �װ��� return ��.
    -- function���� return ����.
end;
/
-- ���ε庯������
VARIABLE VAR_ENAME varchar2(30);
VARIABLE VAR_SAL varchar2(30);
VARIABLE VAR_JOB varchar2(30);
-- procedure ����
exec PRO_EMP_ARG_TEST(7902 , :VAR_ENAME, :VAR_SAL, :VAR_JOB  );
-- ���
print VAR_ENAME;
print VAR_SAL;
print VAR_JOB;

DECLARE
    VAR_ENAME varchar2(30);
    VAR_SAL varchar2(30);
BEGIN
    I_USER_ID := 'LSG';

    TEST03(I_USER_ID,O_USER_ID);
    DBMS_OUTPUT.PUT_LINE('O_USER_ID : ' || O_USER_ID);    
END;

/
create or replace procedure select_empid
        ( arg_emp_id in employee.emp_id%type
        , arg_emp_name out employee.emp_name%type
        , arg_salary out employee.salary%type
        , arg_bonus out employee.bonus%type
        , arg_phone out employee.phone%type
        )
is
begin
    dbms_output.put_line('arg_emp_id: '|| arg_emp_id);
    select emp_name, salary, bonus, phone
    
        from employee
        where emp_id = 202;
end;
/

--variable var_emp_id varchar2(30);
variable var_emp_name varchar2(30);
variable var_salary number;
variable var_bonus number;

exec select_empid(200, :var_emp_name, :var_salary, :var_bonus);

print var_emp_name;
print var_salary;
print var_bonus;

desc employee;
select * from emp;


create or replace procedure pro_all_emp
is
begin
    for e in (select * from employee) loop
--        DBMS_OUTPUT.PUT_LINE(e.emp_name);
        select_empid(e.emp_id, e.emp_name, e.salary, e.bonus, e.phone);
        DBMS_OUTPUT.PUT_LINE(e.emp_name ||', '|| e.salary||', '|| e.bonus||', '|| e.phone);
    end loop;
end;
/
exec pro_all_emp;
select emp_name, salary, bonus, phone
    from employee
    where emp_code = 200;



---------------------------------------
---------------------------------------
-- ���
--IF ���ǽ�1 THEN
--    ���������϶� ����1;
--    ���������϶� ����1;
--ELSIF ���ǽ�2 THEN
--    ���ǽ�2�����϶� ����;
--    ���ǽ�2�����϶� ����;
--ELSIF ���ǽ�3 THEN
--    ���ǽ�2�����϶� ����;
--ELSE
--    �����̰����϶� ����2;
--    �����̰����϶� ����2;
--END IF;

-- �Ű���������
CREATE OR REPLACE PROCEDURE 
    DEPT_SEARCH (P_EMPNO  IN    EMP.EMPNO%TYPE
--    , P_ENAME IN EMP.ENAME%TYPE
    )
IS --DECLARE
    V_DEPTNO EMP.DEPTNO%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;    -- �޽������� Ȱ��ȭ
    
    SELECT DEPTNO
        INTO V_DEPTNO
        FROM EMP
        WHERE EMPNO = P_EMPNO;
    IF V_DEPTNO = 10 THEN
        DBMS_OUTPUT.PUT_LINE('ACCOUNTING �μ� ����Դϴ�.');
    END IF;
    IF V_DEPTNO = 20 THEN
        DBMS_OUTPUT.PUT_LINE('RESEARCH �μ� ����Դϴ�.');
    END IF;
    IF V_DEPTNO = 30 THEN
        DBMS_OUTPUT.PUT_LINE('SALES �μ� ����Դϴ�.');
    END IF;
    IF V_DEPTNO = 40 THEN
        DBMS_OUTPUT.PUT_LINE('OPERATIONS �μ� ����Դϴ�.');
    END IF;
--EXCEPTION
--    DBMS_OUTPUT.PUT_LINE('����ġ ���� ������ �߻��Ͽ����ϴ�. �ٽ� �õ��� �ּ���.');
END;
/