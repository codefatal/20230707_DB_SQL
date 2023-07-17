-- �н��� SCOTT ��ɾ��
SELECT *
FROM EMP
;
SELECT ENAME, SAL, EMPNO
FROM EMP
;
SELECT ENAME, MGR, SAL, DEPTNO 
FROM emp
WHERE DEPTNO=20 OR SAL>1500
;
SELECT ENAME, MGR, SAL, DEPTNO 
FROM emp
--WHERE ENAME = 'smith'
WHERE ENAME = 'SMITH'
-- ORA-00904: "SMITH": �������� �ĺ���
;
select empno, ename, sal
from emp
;
-- * �� ����ϴ� �� ���� �ӵ� ����. ����.
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;
-- * ���� �÷����� �����ϴ� ���� �ӵ��鿡�� ����.
select * from emp;
select * from dept;
select * from salgrade;
select * from bonus;


-- Q: ������ ������ ���ʽ������� ������ ��ȸ
select ename, sal*12, sal*12 + nvl(comm, 0)
from emp
;
select comm, nvl(comm, 0), nvl(comm, 100)
from emp
;
select ename as "�����", sal*12 as ����, sal*12 + nvl(comm, 0) as "���ʽ� ���� ����"
from emp
;
select ename "name", sal*12 sal12, sal*12 + nvl(comm, 0) salwcomm
from emp
;

select '�ȳ�' as hello
from emp
;
select '�ȳ�' as hello
from dept
;
select '$' as ����, sal 
from emp
;
select distinct '$' as ����, sal 
from emp
;

-- �޿��� 1500���� ���� �ް� 2800���� ���� �޴� ���� �̸��� �޿� ��ȸ
-- between and ���
select ename, sal
    from emp
    where sal between 1500 and 2799
;
-- >= <= ���
select ename, sal
    from emp
    where sal >= 1500 and sal < 2800
;
-- 20�� �μ��� ������ ��� ������ ��ȸ
select * 
    from emp
--    where deptno != 20
--    where deptno <> 20
--    where deptno ^= 20
--    where not deptno = 20
    where deptno not in (20)
;
-- 20�� �μ��� ������ ��� �� comm�� null�� �ƴ� ��� ������ ��ȸ
select * 
    from emp
    where not deptno = 20 
--        and comm is not null
-- ����        comm != null  comm = null
;
-- 10, 20, 30 �μ��� ��� ������ ��ȸ
select * 
    from emp
--    where deptno = 10 OR deptno = 20 OR deptno = 30
    where deptno in (10, 20, 30)
;
-- 10, 20, 30 �μ��� ������ ��� ������ ��ȸ
select * 
    from emp
--    where not (deptno = 10 OR deptno = 20)
--    where deptno != 10 AND deptno != 20 AND deptno != 30
    where deptno not in (10,20,30)
;
select * from emp;


-- �޿��� 1800���� ���� �ް� 2500���� ���� �޴� �����̸��� �޿� ��ȸ

-- ��S���� �����ϴ� 2�����̻��� �̸��� ���� ���� �̸��� �޿� ��ȸ
select ename, sal 
    from emp
    where ename like 'S_%'
;
--ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ�
--00933. 00000 -  "SQL command not properly ended"
--SQL Error [933] [42000]: ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ�

-- �ڵ����� �� �� �ڸ� �� ù ��ȣ�� 7�� ���� �̸��� ��ȭ��ȣ ��ȸ
-- �̸� �� 3��° ���ڰ� ��S�� �� ���� �̸��� �޿� ��ȸ
select ename, sal 
    from emp
    where ename like '__S%'
;
-- �̸� �� 3��° ���ڰ� ��_�� �� ���� �̸��� �޿� ��ȸ
select ename, sal 
    from emp
    -- �̸��� 4���� �̻��� ����
--    where ename like '___%'  
    where ename like '__\_%' escape '\'
         or job like '__@_%' escape '@'
-- like '__*_' escape '*'
;
-- EMAIL ID �� ��_���� ���� 3�ڸ��� ���� �̸�, �̸��� ��ȸ
-- ���̡��� ���� �ƴ� ���� ���, �̸�, �̸��� ��ȸ
-- �����ڵ� ���� �μ� ��ġ�� ���� ���� ���� ��ȸ - *
select *
    from emp
    where mgr is null
        and deptno is null
;
-- �����ڰ� ������ ���ʽ��� ���޹޴� ���� ��ȸ
select *
    from emp
    where mgr is null
        and comm is not null
;
-- 20 �μ��� 30 �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
-- in
select ename, deptno, sal
    from emp
    where deptno in (20, 30)
    -- deptno = 20 or deptno = 30
;

-- ANALYST �Ǵ� SALESMAN �� ��� �� �޿��� 2500���� ���� �޴� ������ �̸�, �޿�, job ��ȸ
select ename, sal, job
    from emp
    where job in ('ANALYST', 'SALESMAN') 
        and sal >= 2500
    ;
-- ������� ���̿� byteũ�⸦ ��ȸ
select length(ename), lengthb(ename)
    from emp
    ;
--select ' a�� ��b ', length(' a�� ��b '), lengthb(' a�� ��b ')
select trim(' a�� ��b '), length(trim(' a�� ��b ')), lengthb(trim(' a�� ��b ')) 
--    from emp
    from dual
--   ���̺� dual �� �ӽ����̺�� �����̳� ������ �Լ� ������� ��ȸ�Ҷ� �����.
;
-- ������� ���ۺκ� S�� ������ �κ� S ��� �������ּ���.
select Rtrim(Ltrim(ename, 'S'), 'S') from emp;
-- Ltrim ���� 010 ����

-- Lpad / Rpad ä���ֱ�
-- ename�� �� 10�ڰ� �ǵ��� left �ʿ� 'S'�� ä���ּ���.
select Lpad(ename, 10, 'S') from emp;
-- ename�� �� 10�ڰ� �ǵ��� left �ʿ� ' ' ����(default)�� ä���ּ���.
select Lpad(ename, 10) from emp;

-- ����(�÷�) �̾���̱�
select concat(ename, comm) from emp;
select ename||comm from emp;
select sal||'�޷�' from emp;
select concat(sal, '�޷�') from emp;
-- substr ��û�߿� !!
-- replace
select replace(ename, 'AM', 'AB') from emp;


select ename||'s family' , sal ||'��'
from emp;
select sal, '��'
from emp;

-- sysdate�� �Լ��� �ƴϳ� ��ɾ ����Ǵ� ������ ������� ������ֹǷ� �Լ�ȣ��� ���� ������.
select sysdate, add_months(sysdate, 1) from dual;
select hiredate from emp;
select hiredate, add_months(hiredate, 1) from emp;
-- 2023.07.10 (��)
select sysdate, to_char(sysdate, 'yyyy.mm.dd (dy) hh24:mi:ss')  from dual;
select sysdate, to_char(sysdate, 'yyyy.mm.dd (day) hh24:mi:ss')  from dual;

alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
select sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hour 13
select to_date('2023091113', 'yyyymmddhh24') from dual;
select add_months(to_date('2023091113', 'yyyymmddhh24'), 5) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'), '��') from dual;  
select next_day(to_date('2023091113', 'yyyymmddhh24'), 4) from dual;  
-- 1:�Ͽ���, 2 ������, 3 ȭ����...
select last_day(to_date('2023091113', 'yyyymmddhh24')) from dual;

-- ���� select add_months('20230911132214', 4) from dual;

select to_char(empno, '000000') , '$'||trim(to_char(sal, '999,999,999,999'))
    from emp;
select to_char(empno, '000000') , trim(to_char(sal, 'L999,999,999,999'))
    from emp;

select to_number('123,4567,89.01', '999,9999,99.99')*5 from dual;
-- ���� select '123,4567,8901'*5 from dual;
-- ���� select '123,456,789,012'*5 from dual;

-- �������� ��� �޿��� ������ ��ȸ
select avg(sal) ��ձ޿� from emp;
select sum(sal) sum from emp;
select max(sal) max from emp;
select min(sal) min from emp;
select count(sal) count from emp;
-- �μ��� ��� �޿� ��ȸ
select avg(sal) ��ձ޿�, deptno from emp group by deptno;
select sum(sal) sum, deptno from emp group by deptno;
select max(sal) max, deptno from emp group by deptno;
select min(sal) min, deptno from emp group by deptno;
select count(sal) count, deptno from emp group by deptno;
select count(*) count, deptno from emp group by deptno;
-- job�� ��� �޿� ��ȸ
select avg(sal) ��ձ޿�, job from emp group by job;
select sum(sal) sum, job from emp group by job;
select max(sal) max, job from emp group by job;
select min(sal) min, job from emp group by job;
select count(sal) count, job from emp group by job;
select count(*) count, job from emp group by job;

-- job�� ANALYST �� ������ ��� �޿� ��ȸ
select avg(sal) ��ձ޿�, job 
    from emp 
    group by job
    having job='ANALYST'
;
select avg(sal) ��ձ޿�
    -- ����, job 
    from emp 
    where job='ANALYST'
;
-- job�� CLERK �� �μ��� ������ ��� �޿� ��ȸ
---- job�� CLERK �� �μ��� ����
select job, deptno, ename, sal
    from emp
    where job='CLERK';
-- job�� CLERK �� �μ��� ������ ��� �޿� ��ȸ
select job, deptno, avg(sal)
--, ename
    from emp
    where job='CLERK'
    group by deptno, job
    ;

select * from emp
    order by sal desc, ename asc
    ;
select sal, sal*12+nvl(comm,0) salcomm 
    from emp
    order by salcomm desc, sal asc
    ;
select ename, sal*12+nvl(comm,0)  
    from emp
    order by 2 desc, 1 desc
    ;
-- job ��������
select * from emp
--    order by job;
    order by 3;    
    
    
--- �����, �μ���ȣ, �μ���, �μ���ġ�� ��ȸ
select * from dept;
select * from emp;
select * 
    from emp
        join dept on emp.deptno = dept.deptno        
;
select * 
    from emp
        join dept using (deptno)
;
select emp.ename, emp.deptno, dept.dname, dept.loc
    from emp
        join dept on emp.deptno = dept.deptno        
;
--ORA-00918: ���� ���ǰ� �ָ��մϴ�
--00918. 00000 -  "column ambiguously defined"
select ename, dept.deptno, dname, loc
    from emp
        join dept on emp.deptno = dept.deptno        
;
select *
    from emp
        join dept using (deptno)
;
select ename, deptno, dname, loc
    from emp
        join dept using (deptno)
;

select ename, dept.deptno, dname, loc
    from emp, dept 
    where emp.deptno = dept.deptno
;
-- �μ���ġ�� DALLAS�� �����, �μ���ȣ, �μ���, ��ġ�� ��ȸ
select ename, dept.deptno, dname, loc
    from emp, dept 
    where emp.deptno = dept.deptno
        and loc = 'DALLAS'
;

select empno, loc
    from emp cross join dept
;

select * from emp;
select * from salgrade;
-- ����� �̸�, ���, sal, grade �� ��ȸ
select e.ename, e.empno, e.sal, s.grade
    from emp e join salgrade s         
                on e.sal between s.losal and s.hisal
    order by s.grade desc, e.sal desc
;
select ename, empno, sal, grade
    from emp join salgrade         
                on sal between losal and hisal
    order by grade desc, sal desc
;
select empno, ename, mgr from emp;
select e.empno, e.ename, e.mgr, m.ename mgrname
    from emp e join emp m 
        on e.mgr = m.empno
;
-- ���� �̸� �÷����� ��Ÿ���� �ʵ��� ��ĥ ���
select e.empno boss, e.ename, m.empno emp, m.ename emps
    from emp e join emp m 
        on e.empno = m.mgr
;
select ename from emp where empno=7566
;
select * from emp;

-- �ڷ���
create table t1( 
    c1 char(5), 
    c2 varchar2(5) 
);
insert into t1 values('12','12');
insert into t1 values('12345','12345');
--ORA-12899: "SCOTT"."T1"."C1" ���� ���� ���� �ʹ� ŭ(����: 6, �ִ밪: 5)
--insert into t1 values('123456','123456');
--ORA-12899: "SCOTT"."T1"."C2" ���� ���� ���� �ʹ� ŭ(����: 6, �ִ밪: 5)
--insert into t1 values('12345','123456');
commit;
select * from t1;
select length(c1), length(c2) from t1;

desc t1;
desc emp;

-- ERD( entity relationship diagram )
-- UML  - classDiagram, ERD


select rownum, e.* from emp e where deptno in (20, 30)
;
-- ����
select rownum, e.* from emp e where deptno in (20, 30)
    order by ename asc
;
-- �ذ� ���
select rownum, e.* 
    from ( select * from emp order by ename asc ) e 
    where deptno in (20, 30)
;
select rownum, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
;
select * from emp order by ename asc;
-- 1page 1-3
select rownum, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
    where rownum between 1 and 3
;
-- 2page 4-6
select rownum rnum, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
    where rownum between 4 and 6
--    rnum�� select -6 ��������� where ������ ����� �� ����.
;
select sysdate, e.* 
    from ( select * from emp where deptno in (20, 30) order by ename asc ) e 
    where sysdate > '2023-06-11'
;
-- �ذ� - ROWNUM�� ����� ����ϱ� ���ؼ��� 2���� ��ø subquery(inline-view)�ʿ���.
-- 3page 7-9
select *
    from (select rownum rnum, e.* 
                from ( select * from emp where deptno in (20,30) order by ename asc ) e
            )
    where rnum between 7 and 9
;

with abc as (select rownum rnum, e.* 
                from ( select * from emp where deptno in (20,30) order by ename asc) e )
select *
from abc
where rnum between 7 and 9
-- abc �� ��ġ ���ο� ���̺� ó�� ��밡����.
--    and sal > (select avg(sal) from abc)
;

create view view_abc 
as
select rownum rnum, e.* 
                from ( select * from emp where deptno in (20,30) order by ename asc) e
;
select * from view_abc;
select *
from view_abc
where rnum between 7 and 9
;

--20230712
-- 03- 11. GRADE���� ��ձ޿��� 10���γ����� �޿��� �޴� ������� ��ȸ - ����
-- where �� subquery Ȱ��

-- select���� rownum �ݵ�� ��Ī
-- select���� �Լ������ ��� �ݵ�� ��Ī
-- with ���

--  from �� subquery
select grade, ename "10���γ���"
    from emp e join (
            select floor(avg(e2.sal)*0.9) minsal, floor(avg(e2.sal)*1.1) maxsal, floor(avg(e2.sal)) avgsal, s2.grade, s2.losal, s2.hisal
                from emp e2 join salgrade s2 on e2.sal between s2.losal and s2.hisal
                group by s2.grade , s2.losal, s2.hisal
                ) m
            on e.sal between minsal and maxsal
--            on e.sal between m.losal and m.hisal
--    where e.sal between minsal and maxsal
    order by grade asc, 2 asc
;
with abc4 as (
            select floor(avg(e2.sal)*0.9) minsal, floor(avg(e2.sal)*1.1) maxsal, floor(avg(e2.sal)) avgsal, s2.grade, s2.losal, s2.hisal
                            from emp e2 join salgrade s2 on e2.sal between s2.losal and s2.hisal
                            group by s2.grade , s2.losal, s2.hisal
            )
select grade, ename "10���γ���"
    from emp e join abc4
        on e.sal between minsal and maxsal
    order by grade asc, 2 asc
;


-- group by ���� 
-- select �÷������δ� group by�� ���� �÷��� �ۼ�����. �׸��� �׷��Լ� ��밡��.
            select floor(avg(e2.sal)*0.9) minsal, floor(avg(e2.sal)*1.1) maxsal, floor(avg(e2.sal)) avgsal, s2.grade, s2.losal, s2.hisal
                from emp e2 join salgrade s2 on e2.sal between s2.losal and s2.hisal
                group by s2.grade , s2.losal, s2.hisal
                ;

select a.grade as grade, b.ename as ���10���γ����λ�� 
    from  (select s.grade as grade, avg(sal) as avgsal from emp e join salgrade s 
    on e.sal between s.losal and s.hisal group by s.grade) a 
    join emp b  
    on b.sal between a.avgsal * 0.9 and a.avgsal * 1.1
    order by a.grade asc, ���10���γ����λ�� asc;



select * from emp e join dept d on e.deptno=d.deptno;
select * from salgrade;
select * from dept;


--���� �糭 �������� ����鿡�� �߰� ����
--���� :
--1. NEW YORK������ SAL�� 2%, DALLAS������ SAL�� 5%, CHICAGO������ SAL�� 3%, BOSTON������ SAL�� 7%
--2. �߰��������� ���� ��� ������ ����
select empno, ename, sal, loc,
        sal + case loc
            when 'NEW YORK' then sal*0.02
            when 'DALLAS' then sal*0.05
            when 'CHICAGO' then sal*0.03
            when 'BOSTON' then sal*0.07
        end
        as sal_subsidy
    from emp e
        join  dept d  using (deptno)
--    where
--    group by
--    having
    order by sal_subsidy - sal desc
;
select empno, ename, sal, loc,
        sal + decode(loc,  'NEW YORK', sal*0.02,  'DALLAS', sal*0.05, 'CHICAGO', sal*0.03, 'BOSTON' ,sal*0.07, 0)
        as sal_subsidy
    from emp e
        join  dept d  using (deptno)
--    order by (sal_subsidy - sal) desc
    order by decode(loc,  'NEW YORK', sal*0.02,  'DALLAS', sal*0.05, 'CHICAGO', sal*0.03, 'BOSTON' ,sal*0.07, 0) desc
;
--SALESMAN ���� �޿��� ���� �޿��� �޴� ����� ��ȸ
select empno, ename, sal
    from emp
    where sal > all (select sal from emp where job='SALESMAN')
--    where sal > (select max(sal) from emp where job='SALESMAN')
;
select ename,sal from emp where job='SALESMAN' ;

--�����ڷ� ��ϵǾ� �ִ� ������� ��ȸ
select empno, ename
    from emp e
    where exists ( select empno from emp e2 where e.empno = e2.mgr)
;
select * from emp;
select distinct e.empno, e.ename
    from emp e join emp e2
        on e.empno = e2.mgr
;
-- join ��� ����������� �ӵ� ���


--�μ� ��ȣ�� 30�� ������� �޿��� �μ���ȣ�� ���� ���� ������ ������ ����.
select *
    from emp
    where (deptno, sal) in (select deptno, sal from emp where deptno=30)
;
-- �μ��� ��ձ޿��� ������ ������ ��ȸ���ּ���.
select e.*, 
        -- ��Į�� �������� �ۼ��Ǿ�� ��.
    (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno) avgsal
    from emp e
    ;
-- ���� ������ �μ���ȣ, �μ���, �μ���ġ
select ename, deptno, dname, loc
    from emp join dept using(deptno)
;
select ename, deptno, 
        (select dname from dept d where d.deptno=e.deptno) dname
        ,(select loc from dept d where d.deptno=e.deptno) loc
    from emp e
;

-- SALESMAN �� 'MANAGER' �� ��ȸ���ּ���.
select * from emp
    where job='SALESMAN' or job='MANAGER';
select * from emp
    where job in ('SALESMAN', 'MANAGER');

select * from emp    where job='SALESMAN'
union
select * from emp    where job='MANAGER'
;
select empno, ename, job from emp    where job='SALESMAN'
union
select mgr, ename, job from emp    where job='MANAGER'
--ORA-01790: �����ϴ� �İ� ���� ������ �����̾�� �մϴ�
--01790. 00000 -  "expression must have same datatype as corresponding expression"
--select ename, mgr, job from emp    where job='MANAGER'
;
-- �޿��� 1000�̸��� ����, 2000 �̸��� ���� ��ȸ- �ߺ� ���� ���
select empno, ename, sal from emp where sal < 1000
union all
select empno, ename, sal from emp where sal < 2000
;
-- �޿��� 1000 �ʰ��� ����, 2000 �̸��� ���� ��ȸ - intersect
select empno, ename, sal from emp where sal > 1000
intersect
select empno, ename, sal from emp where sal < 2000
;
-- 2000 �̸��� ������ �����ϰ� ��ȸ - minus
select empno, ename, sal from emp
minus
select empno, ename, sal from emp where sal < 2000
;
-- not exists
select empno, ename, sal from emp e
    where not exists (select e2.sal from emp e2 where e.sal < 2000)
;



-- DDL
-- comment
comment on column emp.mgr is '�����ڻ��';

desc emp;
desc user_constraints;
select * from user_constraints;
select * from user_tables;
select * from user_views;
select * from user_cons_columns;


delete dept where deptno=10;

-- 20230713
select * from emp;
create table emp_copy1 as select * from emp;
select * from emp_copy1;
create view view_emp1 as select * from emp;
select * from view_emp1;
desc emp;
insert into emp values(8000, 'EJKIM', 'KH', 7788, sysdate, 3000, 700, 40);
commit;
insert into emp_copy1 values(8001, 'EJ1', 'KH', 7788, sysdate, 3000, 700, 40);
commit;
insert into view_emp1 values(8002, 'EJ2', 'KH', 7788, sysdate, 3000, 700, 40);
commit;
create table emp_copy20 as 
select empno, ename �����, job, hiredate, sal
from emp
where deptno=20
;
desc emp;
desc emp_copy20;
select * from user_constraints;

desc emp;
--insert into emp (�÷���1, �÷���2,...) values (��1, ��2,...);
insert into emp (ename, empno, job, mgr, hiredate, deptno) 
    values ('EJK', 8003, 'T', 7788,  sysdate, 40);
select * from emp;
insert into emp (ename, empno, job, mgr, hiredate, deptno) 
    values ('EJK2', 8004, 'P', null, to_date('2023-07-12', 'yyyy-mm-dd'), 40);
commit;
update emp
    set mgr=7788
    where ename='EJK2'
    -- update ��ɹ��� where������ �÷���PK=��
    -- where������ �÷���PK=��  ==> resultset �� ������
    -- where������ �÷���UK=��  ==> resultset �� ������
;
-- 20�� �μ��� mgr�� SMITH 7908 �� ��������
update emp 
    set mgr=7908
    where deptno=20
;  -- ��� 5
update emp 
    set mgr=7908
    where deptno=70
;  -- ��� 0

rollback;

-- 30�� �μ��� mgr�� SMITH 7908 �� ��������
update emp 
    set mgr=7908
    where deptno=30
;
select * from emp;
update emp 
    set mgr=7902
    where ename='EJK2'
;
select * from emp;
-- ���� DML ��ɾ� ���� ��� �ϳ��� �ൿ(��)ó���� �ϰ��� �Ҷ� commit / rollback �� ������ ���.
-- 1 DML ��ɾ �ϳ��� �ൿ(��) ó�� ������� DML - commit;
-- 2 �̻� DML ��ɾ �ϳ��� �ൿ(��) ó�� ������� DML ��ΰ� �����ؾ� - commit;, ���� �Ϻΰ� �����ߴٸ� - rollback
-- �ϳ��� �ൿ(��) ó�������� Transaction Ʈ����� - commit/rollback ��ɾ ����Ǵ� ����
-- commit;
-- rollback;

commit;
select * from emp;
select * from dept;
-- 20�� �μ��� ���Ի�� EJ3 (8005), EJ4(5006) �� ������.
insert into emp (ename, empno, deptno) values ('EJ3', 8005, 20);
insert into emp (ename, empno, deptno) values ('EJ4', 8006, 20);
insert all
    into emp (ename, empno, deptno) values ('EJ3', 8005, 20)
    into emp (ename, empno, deptno) values ('EJ4', 8006, 20)
select * from dual
;
select sysdate, 27*50 from dual;
select sysdate from dept;
insert all
    into emp (ename, empno, deptno) values ('EJ5', maxempno+1, 20)
    into emp (ename, empno, deptno) values ('EJ6', maxempno+2, 20)
select max(empno) maxempno from emp
;
insert into emp (ename, empno, deptno) values ('EJ7', (select max(empno) maxempno from emp)+1, 20);
insert into emp (ename, empno, deptno) values ('EJ8', (select max(empno) maxempno from emp)+1, 20);
select * from emp;
select * from dept;

-- ���ο� �μ� 50���� ��������� �� �μ��� ���Ի�� EJ3 (8005), EJ4(5006) �� ������.
insert all
    into dept (deptno) values (newdeptno)
    into emp (ename, empno, deptno) values ('EJ9', (select max(empno) maxempno from emp)+1, newdeptno)
    into emp (ename, empno, deptno) values ('EJ10', (select max(empno) maxempno from emp)+2, newdeptno)
select max(deptno)+10 newdeptno from dept
;
rollback;
create table dept_copy2 as select * from dept where 1<>1;
-- DDL ��ɾ� ����� commit �ൿ�� �Բ� �����.

delete from dept where deptno = 40;
ALTER TABLE emp DISABLE CONSTRAINT FK_DEPTNO CASCADE;
delete from dept where deptno = 40;
delete from emp where deptno = 40;
ALTER TABLE emp enable CONSTRAINT FK_DEPTNO;

select * from emp;
select * from user_constraints;
alter table emp 
    drop constraint FK_DEPTNO;
alter table emp 
    add constraint FK_DEPTNO foreign key(deptno) references dept(deptno);
    
alter table emp 
    modify ename varchar2(30)
;

--20230714
select * from emp;
savepoint c1;
update emp set ename='EJ11' where empno=8005;
savepoint c2;
update emp set ename='EJ12' where empno=8005;
savepoint c3;
update emp set ename='EJ13' where empno=8005;
-- 14
ROLLBACK to c3;
ROLLBACK to c2;
ROLLBACK to c1;
commit;

create view view_emp10 
    as 
    select max(sal) maxsal, job, sal+500 pluscomm from emp group by job;
--insert into view_emp10
select * from user_tables;
select * from user_views;
select * from user_constraints;
select * from user_cons_columns;
select * from user_users;


-- T2���̺��� �������� view ����
create or replace force  view view_t2
    as select * from t2;
create force  view view_t2
    as select empno from t2;
create or replace force  view view_t2
    as select empno from t2;
create or replace view view_t3
    as select * from t3;
create or replace view view_emp_readonly
    as 
    select * from emp
    with read only
;
insert into view_emp_readonly (empno, ename, deptno) values(8100, 'EJEJ', 30);
--SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
--42399.0000 - "cannot perform a DML operation on a read-only view"

create or replace view view_emp_checkoption
    as 
    select * from emp
    where deptno=30
    with check option
;
select * from view_emp_checkoption;
--ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
update view_emp_checkoption set deptno=20 where empno=7499;
update view_emp_checkoption set comm=350 where empno=7499;
update emp set deptno=20 where empno=7499;


create sequence seq_t1;
select seq_t1.currval from dual;
--ORA-08002: ������ SEQ_T1.CURRVAL�� �� ���ǿ����� ���� �Ǿ� ���� �ʽ��ϴ�
--08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
--*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL
select seq_t1.nextval from dual;  
select seq_t1.currval from dual;
-- sequence�� nextval �� unique�� ���� insert �ÿ� Ȱ���.
-- sequence �̸��� ������ SEQ_���̺��_�÷���
-- ���� ��� emp���̺� empno�� ���� - SEQ_EMP_EMPNO
-- insert into emp values ( SEQ_EMP_EMPNO.nextval , 'ȫ�浿',....);
select * from user_sequences;
--
select * from user_indexes;
select * from user_ind_columns;
select * from user_constraints;
select * from user_cons_columns;

-- a. �Լ� ��� index
create index idx_emp_sal on emp(sal);
create index idx_emp_sal on emp(sal*12);
-- where ���� sal*12 >5000 ó�� ���ǹ��� ����� ����Ҷ� index�� �ɾ���
create index idx_emp_sal_comm on emp(sal,comm);
-- where ���� sal >5000 and comm >200 ó�� ���ǹ��� ����� ����Ҷ� index�� �ɾ���
select * from emp where sal>3000 and comm is not null;
-- b. bitmap ��� index - �������� ������ ������ ������ �����Ͱ� ���� ���- gender ����
create bitmap index idx_emp_deptno on emp(deptno);
create bitmap index idx_emp_deptno_job on emp(job,deptno);
-- I. unique
 -- insert ����üũ����.
-- II. non-unique
alter index pk_emp rebuild;

select * from DEPT2_PUBLIC;
select * from KH.DEPARTMENT;

create sequence seq_tb1_c1 start with 10 increment by 10 maxvalue 90 minvalue 10 nocycle cache 20;
--ORA-08002: ������ SEQ_TB1_C1.CURRVAL�� �� ���ǿ����� ���� �Ǿ� ���� �ʽ��ϴ�
--08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
--*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL
select seq_tb1_c1.currval from dual;

select seq_tb1_c1.nextval from dual;
select seq_tb1_c1.currval from dual;

select seq_tb1_c1.nextval from dual;
--ORA-08004: ������ SEQ_TB1_C1.NEXTVAL exceeds MAXVALUE�� ��ʷ� �� �� �����ϴ�
--08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
--*Cause:    instantiating NEXTVAL would violate one of MAX/MINVALUE
--*Action:   alter the sequence so that a new value can be requested

-- ROLE
-- ���Ӱ��õ� ����- oracle 12���� �������� false ���·� ���ӵ�.
alter session set "_ORACLE_SCRIPT"=false;  
create role role_scott_manager;
create user c##kh2 identified by kh2;

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

-- window - over ( partition by ..) : ���� group by ���� ����
select deptno, empno, ename, sal
        , sum(sal) over(partition by deptno) sumsal 
    from emp;

-- window - over( order by ..) : ���� rownum ��� ����, - ���ϼ����� ������ ������������ +1 dense_rank()
select deptno, empno, ename, sal
        , rank() over(order by sal asc) ranksal
        , dense_rank() over(order by sal asc) dranksal
        , row_number() over(order by sal asc) rnsal
        , rank() over (partition by deptno order by sal asc) dept_sal_rank
    from emp
    order by deptno
    ;
select dense_rank(2450) within group (order by sal asc) clarksal
    from emp;
-- rownum 
select deptno, empno, ename, sal
        , rn ranksal
    from (select rownum rn, t1.*  from (select deptno, empno, ename, sal from  emp order by sal asc) t1) ;
--  �μ��ڵ尡 '30'�� ������ �̸�, �޿�, �޿������Ѵ����л� �� ��ȸ
--  �μ��� ������ �̸�, �޿�, �޿������Ѵ����л� �� ��ȸ
--d. 1 : �����л� CUME_DIST(), ���� RATIO_TO_REPORT()
select ename, deptno, sal 
        , trunc(CUME_DIST() over(order by sal), 2) sal_cume_dist
        , trunc(ratio_to_report(sal) over(), 2) sal_ratio
        , trunc(CUME_DIST() over(partition by deptno order by sal), 2) sal_cume_dist
        , trunc(ratio_to_report(sal) over(partition by deptno)*100, 2)||'%' sal_ratio
    from emp
--    where deptno=30
    order by deptno
    ;

SELECT DEPTNO, ENAME, SAL
 , FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC
--                            ROWS UNBOUNDED PRECEDING
                            ) as DEPT_RICH 
 , LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC
                            ) as DEPT_POOR_ERROR
-- ����
, LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC
-- WINDOW ��
-- ������ ���� ���� �ۼ��Ǵ� ����(��)������ �� �� ����. ���� �࿡ ���� ���� ���� ����.
-- unbounded preceding : �������� ù��
-- unbounded following : �������� ��������
-- 1 preceding : �������� ������
-- 1 following : �������� ������
-- current row : ������
                            ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
--                            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                            ) as DEPT_POORFROM
FROM EMP;