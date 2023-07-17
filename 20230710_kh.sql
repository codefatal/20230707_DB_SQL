select * from  EMPLOYEE;
select * from  DEPARTMENT;
select * from  JOB;
select * from  LOCATION;
select * from  NATIONAL;
select * from  SAL_GRADE;

select emp_name, length(emp_name) len, lengthb(emp_name) byteLen
    from employee
    ;
select * from employee where emp_name = '����';

--
--ORA-00911: ���ڰ� �������մϴ�
--00911. 00000 -  "invalid character"
--SELECT EMAIL, INSTR(EMAIL, '@', -1, 1) ��ġ
--SELECT EMAIL, INSTR(EMAIL, '@') ��ġ
-- instr - 1���ͽ���
SELECT EMAIL, INSTR(EMAIL, '@', 2) ��ġ
    FROM EMPLOYEE
;
-- email �� @ ���Ŀ� . 1�� �̻��־�� ��.
SELECT EMAIL, INSTR(EMAIL, '@'), INSTR(EMAIL, '.', INSTR(EMAIL, '@')) ��ġ
    FROM EMPLOYEE
    where INSTR(EMAIL, '.', INSTR(EMAIL, '@')) <> 0
;
--
select INSTR('AORACLEWELCOME', 'O', 1)   from dual;
select INSTR('AORACLEWELCOME', 'O', 1, 2)    from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 1, 3)    from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3)   from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3, 2)    from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3, 3)    from dual;

-- �޿��� 3500000���� ���� �ް� 6000000���� ���� �޴� �����̸��� �޿� ��ȸ
-- '��'�� ���� ���� ���� �̸��� �޿� ��ȸ
-- �ڵ����� �� �� �ڸ� �� ù ��ȣ�� 7�� ���� �̸��� ��ȭ��ȣ ��ȸ
-- EMAIL ID �� '_'�� ���� 3�ڸ��� ���� �̸�, �̸��� ��ȸ
-- like '__*_' escape '*'
-- '��'�� ���� �ƴ� ���� ���, �̸�, �̸��� ��ȸ
-- �����ڵ� ���� �μ� ��ġ�� ���� ���� ���� ��ȸ
-- �μ� ��ġ�� ���� �ʾ����� ���ʽ��� ���޹޴� ���� ��ȸ
-- D6 �μ��� D8 �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
-- 'J2' �Ǵ� 'J7' ���� �ڵ� �� �޿��� 2000000���� ���� �޴� ������ �̸�, �޿�, �����ڵ� ��ȸ

-- ��� ������� ��, �� ������ �Բ� �̸��� �ֹι�ȣ
select emp_name, emp_no, 
        decode(substr(emp_no, 8,1), 2, '��', 4, '��', 1, '��', 3, '��', '�׿�')
        as "�� ��"
    from employee
;
select emp_name, emp_no, 
        case
            when substr(emp_no, 8,1) = 2 then '��'
            when substr(emp_no, 8,1) > 1 then '��'
            when substr(emp_no, 8,1) > 4 then '��'
            when substr(emp_no, 8,1) > 3 then '��'
            else '�׿�'
        end
        as "�� ��"
    from employee
;
select emp_name, emp_no, 
        case substr(emp_no, 8,1)
            when '2' then '��'
            when '1' then '��'
            when '4' then '��'
            when '3' then '��'
            else '�׿�'
        end
        as "�� ��"
    from employee
;
select emp_name, emp_no, 
--ORA-00932: �ϰ��� ���� ������ ����: CHAR��(��) �ʿ������� NUMBER��
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"
--ORA-00932: �ϰ��� ���� ������ ����: NUMBER��(��) �ʿ������� CHAR��
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"
        case to_number(substr(emp_no, 8,1))
            when 2 then '��'
            when 1 then '��'
            when 4 then '��'
            when 3 then '��'
            else '�׿�'
        end
        as "�� ��"
    from employee
;
-- java, js ���׿�����
-- string a = ( substr(emp_no, 8,1) == 2 ? "��" : "��";
--if(substr(emp_no, 8,1) == 2){
--    return "��";
--} else {
--    return "��";
--}
--if(substr(emp_no, 8,1) == 2){
--    return "��";
--} else if(substr(emp_no, 8,1) == 4) {
--    return "��";
--} else if(substr(emp_no, 8,1) == 1) {
--    return "��";
--} else if(substr(emp_no, 8,1) == 3) {
--    return "��";
--} else {
--    return "�׿�";
--}
--switch(substr(emp_no, 8,1)){
--    case 1:
--        return "��";
--    case 2:
--        return "��";
--    case 3:
--        return "��";
--    case 4:
--        return "��";
--    default:
--        return "�׿�";
--}



select substr(emp_no, 8,3) from employee;

-- �������� ��� �޿��� ������ ��ȸ
select (avg(salary)) ��ձ޿� from employee;
select floor(avg(salary)) ��ձ޿� from employee;
select trunc(avg(salary), 4) ��ձ޿� from employee;
select round(avg(salary)) ��ձ޿� from employee;
select ceil(avg(salary)) ��ձ޿� from employee;

SELECT COUNT(DISTINCT DEPT_CODE) 
    FROM EMPLOYEE;
SELECT COUNT(DEPT_CODE) 
    FROM EMPLOYEE;  -- 21
SELECT COUNT(*) 
    FROM EMPLOYEE; -- 23
SELECT * --COUNT(*) 
    FROM EMPLOYEE 
    where dept_code is null;
-- count �� resultset�� row���� null �̸� count ���� ����.
-- count(*) row ����
SELECT COUNT(dept_code), count(bonus), count(emp_id), count(manager_id), count(*)
    FROM EMPLOYEE 
    where dept_code is null;
    
SELECT COUNT(DEPT_CODE), COUNT(distinct DEPT_CODE)
    FROM EMPLOYEE; 

SELECT DEPT_CODE    FROM EMPLOYEE; 
SELECT distinct DEPT_CODE    FROM EMPLOYEE; 

SELECT distinct DEPT_CODE    FROM EMPLOYEE
    order by dept_code asc
; 
-- EMPLOYEE���� �μ��ڵ�, �׷� �� �޿��� �հ�, �׷� �� �޿��� ���(����ó��), �ο� ���� ��ȸ�ϰ� �μ� �ڵ� ������ ����

-- EMPLOYEE���̺��� �μ��ڵ�� ���ʽ� �޴� ��� �� ��ȸ�ϰ� �μ��ڵ� ������ ����
-- EMPLOYEE���̺��� ������ ���� �� �޿� ���(����ó��), �޿� �հ�, �ο� �� ��ȸ�ϰ� �ο����� �������� ����


--�μ� �ڵ�� �޿� 3000000 �̻��� ������ �׷캰 ��� ��ȸ
select dept_code, avg(salary)
    from employee
-- ��� ������ �޿��� 3000000 �̻�
    where salary >= 3000000
    group by dept_code
;
--�μ� �ڵ�� �޿� ����� 3000000 �̻��� �׷� ��ȸ
select dept_code, avg(salary)
    from employee
    group by dept_code
-- �׷�� �μ��� ��� �޿��� 3000000 �̻�
    having avg(salary) > 3000000
;

--- �����, �μ���ȣ, �μ���, �μ���ġ�� ��ȸ
select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, tb3.national_code, tb4.national_name
    from employee tb1
        join department tb2 on tb1.dept_code = tb2.dept_id
        join location tb3 on tb2.location_id = tb3.local_code
        join national tb4 on tb3.national_code = tb4.national_code 
        -- join���ǿ� ���Ǵ� �÷����� �ٸ��� using ��� �Ұ�
;
--- �����, �μ���ȣ, �μ���, �μ���ġ�� ��ȸ
--ORA-00904: "TB3"."NATIONAL_CODE": �������� �ĺ���
--00904. 00000 -  "%s: invalid identifier"
--select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, tb3.national_code, tb4.national_name
select tb1.emp_name as c1, tb1.dept_code c2, tb2.dept_title, tb2.location_id, national_code, tb4.national_name
    from employee tb1
        join department tb2 on tb1.dept_code = tb2.dept_id
        join location tb3 on tb2.location_id = tb3.local_code
        join national tb4 using (national_code)
        -- join���ǿ� ���Ǵ� �÷����� �ٸ��� using ��� �Ұ�
;
select emp_name, dept_code, dept_title, location_id, national_code, national_name
    from employee tb1
        join department tb2 on tb1.dept_code = tb2.dept_id
        join location tb3 on tb2.location_id = tb3.local_code
        join national tb4 using (national_code)
        -- join���ǿ� ���Ǵ� �÷����� �ٸ��� using ��� �Ұ�
;

select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, tb3.national_code, tb4.national_name
    from employee tb1, department tb2, location tb3, national tb4
    where tb1.dept_code = tb2.dept_id
        and tb2.location_id = tb3.local_code
        and tb3.national_code = tb4.national_code 
;
select * from  EMPLOYEE;
select * from  DEPARTMENT;
select * from  JOB;
select * from  LOCATION;
select * from  NATIONAL;
select * from  SAL_GRADE;

select * 
from  EMPLOYEE e
 join DEPARTMENT d on e.dept_code=d.dept_id
;
select * 
from  EMPLOYEE e
 left outer join DEPARTMENT d on e.dept_code=d.dept_id
;
select * 
from  EMPLOYEE e
 right outer join DEPARTMENT d on e.dept_code=d.dept_id
;
select * 
from  EMPLOYEE e
 full outer join DEPARTMENT d on e.dept_code=d.dept_id
;
select * 
from  EMPLOYEE e , DEPARTMENT d 
 where e.dept_code=d.dept_id(+)
;
select * 
from  EMPLOYEE e , DEPARTMENT d 
 where e.dept_code(+)=d.dept_id
;
-- oracle join���� full outer join ǥ�������
--ORA-01468: outer-join�� ���̺��� 1���� ������ �� �ֽ��ϴ�
--01468. 00000 -  "a predicate may reference only one outer-joined table"
--select * 
--from  EMPLOYEE e
-- , DEPARTMENT d 
-- where e.dept_code(+)=d.dept_id(+)
--;


-- 20230712
-- 02 - 16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
select emp_id, emp_no, substr(emp_no, 1, 7), rPAD(substr(emp_no, 1, 7), 14, '*') 
    from employee
;

SELECT * FROM EMPLOYEE;
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
                            (DEPT_CODE, MANAGER_ID), 
                            (JOB_CODE, MANAGER_ID))
;
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY (DEPT_CODE, JOB_CODE, MANAGER_ID);
SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))    FROM EMPLOYEE    GROUP BY (DEPT_CODE, MANAGER_ID);
SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))    FROM EMPLOYEE    GROUP BY (JOB_CODE, MANAGER_ID);

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY (DEPT_CODE, JOB_CODE, MANAGER_ID)
union
SELECT DEPT_CODE, null, MANAGER_ID, FLOOR(AVG(SALARY))   FROM EMPLOYEE    GROUP BY (DEPT_CODE, MANAGER_ID)
union
SELECT null, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))  FROM EMPLOYEE    GROUP BY (JOB_CODE, MANAGER_ID);






SELECT DEPT_CODE
, JOB_CODE
--, MANAGER_ID
, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE  , JOB_CODE
--    , MANAGER_ID
;



create table user_grade(
    grade_code number primary key,
    grade_name varchar2(30) not null
    );
insert into user_grade values(10,'�Ϲ�ȸ��');
insert into user_grade values(20,'���ȸ��');
insert into user_grade values(30,'Ư��ȸ��');
select * from user_grade;
drop table user_foreignkey;
create table user_foreignkey(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    grade_code number not null,
    -- ���� constraint �̸������ֱ�. 
    -- FK_user_foreignkey_grade_code_user_grade
    -- �ڵ����� SYS_0000000
    constraint FK_user_foreignkey_grade_code_user_grade   foreign key (grade_code)  references user_grade(grade_code) 
    );
insert into user_foreignkey values(1,'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr',10);
insert into user_foreignkey values(2,'user02', 'pass02', '�̼���', '��', '010-9012-3456', 'lee123@kh.or.kr',20);
insert into user_foreignkey values(3,'user03', 'pass03', '������', '��', '010-3131-3131', 'yoo123@kh.or.kr',30);
insert into user_foreignkey values(4,'user04', 'pass04', '�Ż��Ӵ�', '��', '010-1111-1111', 'shin123@kh.or.kr',null);
insert into user_foreignkey values(5,'user05', 'pass05', '���߱�', '��', '010-4444-4444', 'ahn123@kh.or.kr',50);
drop table user_foreignkey2;
create table user_foreignkey2(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    grade_code number constraint FK_user_foreignkey2_grade_code_user_grade references user_grade
--    grade_code number references user_grade(grade_code) on delete cascade
    );

insert into user_foreignkey2 values(1,'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr',10);
insert into user_foreignkey2 values(2,'user02', 'pass02', '�̼���', '��', '010-9012-3456', 'lee123@kh.or.kr',20);
insert into user_foreignkey2 values(3,'user03', 'pass03', '������', '��', '010-3131-3131', 'yoo123@kh.or.kr',30);
insert into user_foreignkey2 values(4,'user04', 'pass04', '�Ż��Ӵ�', '��', '010-1111-1111', 'shin123@kh.or.kr',null);
insert into user_foreignkey2 values(5,'user05', 'pass05', '���߱�', '��', '010-4444-4444', 'ahn123@kh.or.kr',50);

delete from user_grade where grade_code=0;
--ORA-02292: ���Ἲ ��������(KH.SYS_C008483)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
--ORA-02292: ���Ἲ ��������(KH.FK_USER_FOREIGNKEY_GRADE_CODE_USER_GRADE)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
select * from user_constraints;
select * from user_foreignkey;
select * from user_foreignkey2;


select ename, emp_no, substr(emp_no, 1,6)
--    , TO_DATE(substr(emp_no, 1,6), 'rrmmdd')
from employee;


CREATE TABLE USER_CHECK(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) ,
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50)
, CHECK (GENDER IN ('��', '��'))
);
INSERT INTO USER_CHECK VALUES(1, 'user01', 'pass01', 'ȫ�浿', '����', '010-1234-5678', 
'hong123@kh.or.kr')
;



SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'
;

--20230714
select * from user_constraints order by table_name desc;
select * from employee;

delete from employee;
TRUNCATE table employee;
drop table employee;

create table TB_CLASS_PROFESSOR_copy as select * from TB_CLASS_PROFESSOR;

select * from user_tables;


--ORA-00998: �� ���� ���� ����� �Բ� �����ؾ� �մϴ�
--00998. 00000 -  "must name this expression with a column alias"
CREATE OR REPLACE VIEW V_EMP_JOB2 
    AS SELECT EMP_ID , EMP_NAME , JOB_NAME , 
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') ,
        EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) 
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE)
;
SELECT * FROM V_EMP_JOB;
select EXTRACT(YEAR FROM SYSDATE) 
    ,EXTRACT(month FROM SYSDATE) 
    ,EXTRACT(day FROM SYSDATE) 
-- ����    ,EXTRACT(hour FROM SYSDATE) 
from dual;

--ORA-00918: ���� ���ǰ� �ָ��մϴ�
--00918. 00000 -  "column ambiguously defined"
CREATE OR REPLACE VIEW V_JOB(JOB_CODE, JOB_NAME)
    AS SELECT j1.JOB_CODE, j1.JOB_NAME
        FROM JOB j1 
        JOIN JOB j2 
            on j1.job_code = j2.job_code
--        USING(JOB_CODE)
;
-- self join �� �ݵ�� table ��Ī
select * from JOB;
INSERT INTO V_JOB VALUES('J8', '����');
commit;

CREATE OR REPLACE VIEW V_JOB2(JOB_CODE)
    AS SELECT JOB_CODE  FROM JOB 
;
select * from view_abc;


SELECT emp_id, emp_name, EXTRACT(YEAR FROM sysdate) - (1900 + substr(emp_no,1,2)) age,
        d.DEPT_TITLE , j.JOB_NAME 
FROM EMPLOYEE e 
        JOIN JOB j ON e.JOB_CODE = j.JOB_CODE  
        JOIN DEPARTMENT d ON DEPT_CODE = dept_id
where age = (SELECT min(EXTRACT(YEAR FROM sysdate) - (1900 + substr(emp_no,1,2))) minage
                FROM EMPLOYEE )
;
-- ����� 3-6
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2;

-- 04-2
--2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
select emp_id, emp_name, d.dept_title, j.job_name
            , Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'rr')) age
    from employee e
    join department d on ( e.dept_code = d.dept_id)
    join "JOB" j using (job_code)
    where emp_no = (select max(emp_no) from employee)
;
select max(emp_no) from employee;
select max(emp_name) from employee;
select min(emp_name) from employee;


select * from 
    ( select emp_id, emp_name, d.dept_title, j.job_name
                , Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'rr')) age
        from employee e
        join department d on ( e.dept_code = d.dept_id)
        join "JOB" j using (job_code)
    ) tb1
    where age = (select min(Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'rr'))) minage
                    from employee)
;
select min(Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'rr'))) minage
    from employee;




--ORA-01847: ���� ��¥�� 1���� ���� ���̾�� �մϴ�
--01847. 00000 -  "day of month must be between 1 and last day of month"
select Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'rr'))
    from employee
;
select emp_no, extract(year from to_date(substr(emp_no,1,2), 'yy')),
-- rr �� 50�� �������� 1951, 2049
    extract(year from to_date(substr(emp_no,1,2), 'rr')),
    case 
    when Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'yy')) < 0
    then Extract(year from sysdate)- (extract(year from to_date(substr(emp_no,1,2), 'yy'))-100)
    end age
from employee;
-- 
select extract(year from to_date('500112', 'yymmdd')) yy
        , extract(year from to_date('500112', 'rrmmdd')) mm
        , extract(year from to_date('450112', 'yymmdd')) yy
        , extract(year from to_date('450112', 'rrmmdd')) mm
        , extract(year from to_date('990112', 'yymmdd')) yy
        , extract(year from to_date('990112', 'rrmmdd')) mm
    from dual;

-- 04-7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
select emp_name, tb_d.dept_title, tb_e.job_name, tb_d.local_name, tb_d.national_name
    from (select * from employee e join "JOB" j using(job_code)) tb_e
    join (
            select * from department d 
                join location c on (d.location_id=c.local_code)
                join national n using (national_code)
                where n.national_name in ('�ѱ�','�Ϻ�')
                ) tb_d
    on tb_e.dept_code = tb_d.dept_id
;
select * from department;
select * from location;
select * from national;
select emp_name, dept_code from employee;
select e1.emp_name, e2.emp_name
    from employee e1
    join employee e2 on e1.dept_code=e2.dept_code and e1.emp_name <> e2.emp_name
--    where e1.emp_name <> e2.emp_name
order by e1.emp_name
;


--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
-- (��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
select emp_name, dept_code,
        substr(emp_no, 1,2)||'�� '||substr(emp_no, 3,2)||'�� '||substr(emp_no, 5,2)||'��' "�������"
        , Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2), 'rr')) "������"
    from employee
;
select emp_name
        , to_date(substr(emp_no, 1,6), 'rrmmdd')
        , to_char(to_date(substr(emp_no, 1,6), 'rrmmdd'), 'yy"��" mm"��" dd"��"') "�������"
        , floor((sysdate - to_date(substr(emp_no, 1,6), 'rrmmdd'))/365) "��¥ ������"
    from employee;

select student_name, student_ssn, entrance_date from tb_student;
select student_name, student_ssn, entrance_date 
    , extract(year from to_date(substr(student_ssn, 1,2), 'rr')) birth
    , extract(year from entrance_date) entr
    , extract(year from entrance_date) - extract(year from to_date(substr(student_ssn, 1,2), 'rr'))+1  aaa
from tb_student
where extract(year from entrance_date) - extract(year from to_date(substr(student_ssn, 1,2), 'rr'))+1 > 20
;
select * from (
        select student_name, student_ssn, entrance_date 
            , extract(year from to_date(substr(student_ssn, 1,2), 'rr')) birth
            , extract(year from entrance_date) entr
            , extract(year from entrance_date) - extract(year from to_date(substr(student_ssn, 1,2), 'rr'))+1  aaa
        from tb_student) tb1
where tb1.aaa > 20
;
select * from (
        select student_name, student_ssn, entrance_date 
            , case when (substr(student_ssn, 1,2)) > 23 then substr(student_ssn, 1,2)+1900
                else substr(student_ssn, 1,2)+2000
                end birth
            , extract(year from entrance_date) entr
            , extract(year from entrance_date) - extract(year from to_date(substr(student_ssn, 1,2), 'rr'))+1  aaa
        from tb_student) tb1
where tb1.aaa > 20
;


select * from user_indexes;



SELECT * FROM EMPLOYEE
--    WHERE EMP_NO > '0'
;
create synonym emp for employee;
select * from emp;



-- 20230717
-- group by - �� ���������ϴ� �� : group by �÷���, �÷��� �� select �� ������ �� ����. �Ǵ� �׷��Լ� ��밡��.
SELECT JOB_CODE, SUM(SALARY) sumsal, count(*) cnt    FROM EMPLOYEE    group by JOB_CODE              ORDER BY 1;
-- ����(��ü)
SELECT JOB_CODE, SUM(SALARY)    FROM EMPLOYEE    GROUP BY ROLLUP(JOB_CODE)      ORDER BY 1;
SELECT JOB_CODE, SUM(SALARY)    FROM EMPLOYEE    GROUP BY CUBE(JOB_CODE)        ORDER BY 1;
-- group by
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE    group by DEPT_CODE, JOB_CODE    ORDER BY 1;
-- ���� (��ü)
-- DEPT_CODE ���� ���� ����.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY ROLLUP(JOB_CODE, DEPT_CODE) ORDER BY 1;
-- JOB_CODE ���� ���� ����.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) ORDER BY 1;


SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY CUBE(DEPT_CODE, JOB_CODE) ;
-- �� �Ʒ� ���� ����� ������ �ϱ� ���ؼ��� cube(c1, c2) = rollup(c1, c2)+rollup(c2)
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) 
UNION all
SELECT '', JOB_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY ROLLUP(JOB_CODE) ORDER BY 1;


SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
        CASE 
        -- grouping(c1) : c1�� ����κ����� 0,1�� Ȯ�ε�.
        -- 0 : �ش� �÷����� grouping �� �ȵȻ���. = C1������ ����
        -- 1 : �ش��ϴ� �÷����� grouping �� ����. = ��ü����
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1         THEN '�� �հ�'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0         THEN '�� '
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1         THEN '�� �հ�'
        ELSE '�׷캰 �հ�'
        END AS ����
    FROM EMPLOYEE
    GROUP BY CUBE(DEPT_CODE, JOB_CODE)
    ORDER BY 1;
    
    
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
        CASE 
        -- grouping(c1) : c1�� ����κ����� 0,1�� Ȯ�ε�.
        -- 0 : �ش� �÷����� grouping �� �ȵȻ���. = C1������ ����
        -- 1 : �ش��ϴ� �÷����� grouping �� ����. = ��ü���� = ����� null �� ǥ����.
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1         THEN '�� �հ�'
        -- ROLLUP�� ��� ��Ÿ���� ����.
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0         THEN '�� '
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1         THEN '�� �հ�'
        ELSE '�׷캰 �հ�'
        END AS ����
    FROM EMPLOYEE
    GROUP BY rollup(DEPT_CODE, JOB_CODE)  
    ORDER BY 1;


-- grouping sets : group by �� ������� union ��.
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY)) FROM EMPLOYEE
    GROUP BY GROUPING SETS((DEPT_CODE, JOB, MANAGER_ID),(DEPT_CODE, MANAGER_ID), (JOB_CODE, MANAGER_ID));


-- ����б� 3-15 rollup, cube ���


--	�м��Լ� ����
--	a. �����Լ� : RANK(), DENSE_RANK(), ROW_NUMBER(), NTILE()
--	b. �����Լ� = �׷��Լ�: COUNT(), SUM(), AVG(), MIN(), MAX()
--	c. �׷��Լ� = �����Լ� group by : ROLLUP()+grouping(), CUBE()+grouping(), GROUPING SET() ���� ��3_GROUP BY_HAVING4.pdf��
--	d. 1 : CUME_DIST(), RATIO_TO_REPORT()
--	e. \\\LAG(), ///LEAD()
--	f. FIRST_VALUE(), LAST_VALUE()
--	
--	"�� c ������ 
--�м��Լ��� ������-����(����) ���ϱ�"
--	a,b,d,e,f �м��Լ�
--	OVER()  ==> window - ������ ���� ��
--1	OVER()
--2	OVER( PARTITION BY ��1 )
--3	OVER( ORDER BY ��1 DESC, ��2 ASC, ��3 DESC )
--4	OVER( PARTITION BY ��1 ORDER BY ��1 DESC, ��2, ��3 )
--5	OVER( PARTITION BY ��1 ROWS �Ʒ� ����)
--5-1	OVER( PARTITION BY ��1 ROWS ~ )
--5-2	OVER( PARTITION BY ��1 ROWS BETWEEN ~ AND ~ )
--~	UNBOUNDED PRECEDING
--~	UNBOUNDED FOLLOWING
--~	CURRENT ROW
--~	2 PRECEDING
--~	1 FOLLOWING
--6	OVER( PARTITION BY ��1 ORDER BY ��1 DESC, ��2, ��3 ROWS BETWEEN ~ AND ~ )



SELECT EMP_NAME, DEPT_code, SALARY,
    LAG(SALARY, 2, 0) OVER (ORDER BY SALARY) ������,
    -- 2��°�Ű����� : ������������ ��Ÿ��. 1 ������, 2 ������
    -- 3��°�Ű����� : �������� ���ٸ� ����� ���� �ۼ� (������ �ִٸ� �����ప)
    -- 1 : ���� �ప, 0 : �������� ������ 0 ó����
    LAG(SALARY, 1, SALARY) OVER (ORDER BY SALARY) "��ȸ2",
    -- �������� ������ ���� ���� ���� ���
    LAG(SALARY, 1, SALARY) OVER (PARTITION BY DEPT_code ORDER BY SALARY) "��ȸ3"
    -- �μ� �׷�ȿ����� ���� �ప ���
    
    ,LEAD(SALARY, 1, 0) OVER (ORDER BY SALARY) ������,
    -- 2��°�Ű����� : ����������� ��Ÿ��. 1 ������, 2 �ٴ�����
    -- 3��°�Ű����� : �������� ���ٸ� ����� ���� �ۼ� (������ �ִٸ� �����ప)
    -- 1 : ���� �ప, 0 : �������� ������ 0 ó����
    LEAD(SALARY, 1, SALARY) OVER (ORDER BY SALARY) "��ȸ2",
    -- �������� ������ ���� ���� ���� ���
    LEAD(SALARY, 1, SALARY) OVER (PARTITION BY DEPT_code  ORDER BY SALARY) "��ȸ3"
    -- �μ� �׷�ȿ����� ���� �ప ���
FROM EMPLOYEE
--order by DEPT_code, SALARY
;


SELECT DEPT_code, EMP_ID, SALARY
-- 1 preceding and 1 following 
-- ���� ���� �߽����� ��������� �������� �޿��հ�
        , SUM(SALARY) OVER (PARTITION BY DEPT_code ORDER BY EMP_ID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) win1
-- 1 preceding and current row
-- ��������� �������� �޿� �հ�
        , SUM(SALARY) OVER (PARTITION BY DEPT_code ORDER BY EMP_ID ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) win2
-- current row and 1 following
-- ���� ��� �������� �հ�
        , SUM(SALARY) OVER (PARTITION BY DEPT_code ORDER BY EMP_ID ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) win3
    FROM EMPLOYEE
--    WHERE DEPT_code = 'D5'
; 