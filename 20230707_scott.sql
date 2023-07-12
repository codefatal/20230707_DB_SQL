-- �н��� SCOTT ��ɾ��
SELECT * FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP;
SELECT ENAME, MGR, SAL, DEPTNO FROM emp WHERE DEPTNO=20 OR SAL>1500;
SELECT ENAME, MGR, SAL, DEPTNO FROM emp
--WHERE ENAME = 'smith';
WHERE ENAME = 'SMITH';
-- ORA-00904: "SMITH": �������� �ĺ���

select empno, ename, sal from emp;
-- * �� ����ϴ� �� ���� �ӵ� ����. ����.
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp;
-- * ���� �÷����� �����ϴ� ���� �ӵ��鿡�� ����.
select * from emp;
select * from dept;
select * from salgrade;


-- Q: ������ ������ ���ʽ������� ������ ��ȸ
select ename, sal*12, sal*12 + nvl(comm, 0) from emp;
select comm, nvl(comm, 0), nvl(comm, 100) from emp;
select ename as "�����", sal*12 as "����", sal*12 + nvl(comm, 0) as "���ʽ� ���� ����" from emp;
select ename "name", sal*12 sal12, sal*12 + nvl(comm, 0) salwcomm from emp;

select '�ȳ�' as hello from emp;
select '�ȳ�' as hello from dept;
select '$' as ����, sal from emp;
select distinct '$' as ����, sal from emp;

-- �޿��� 1500���� ���� �ް� 2800���� ���� �޴� ���� �̸��� �޿� ��ȸ
-- between and ���
select ename, sal from emp where sal between 1500 and 2799;
-- >= <= ���
select ename, sal from emp where sal >= 1500 and sal < 2800;

-- 20�� �μ� ����
select * from emp where deptno != 20 and comm is null;

-- 10, 20�� �μ� ��� ���� ��ȸ
select * from emp where deptno = 10 or deptno = 20;

-- 10, 20�� �μ� ��� ���� ����
select * from emp where deptno != 10 and deptno != 20;


select sysdate, to_char(sysdate, 'yyyy-mm-dd (dy)') from dual;

alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd';
alter session set NLS_DATE_FORMAT = 'yy/mm/dd';
select sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hours 13
select to_date('2023091113', 'yyyymmddhh24') from dual;
select add_months(to_date('2023091113', 'yyyymmddhh24'), 5) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'), '��') from dual;
select last_day(to_date('2023091113', 'yyyymmddhh24')) from dual;
-- ���� �ȵ� select last_day('2023091113') from dual;


--with
with abc as (select rownum rnum, e.*
                from (select * from emp where deptno in (20, 30) order by ename asc) e)
select *
    from abc
        where rnum between 7 and 9
            and sal > (select avg(sal) from abc);
            
--view
create view view_abc as 
select rownum rnum, e.*
                from (select * from emp where deptno in (20, 30) order by ename asc) e;


-- SALESMAN ���� �޿��� ���� �޿��� �޴� ����� ��ȸ
select empno, ename, sal
    from emp
        where sal in (select sal from emp where job='SALESMAN');

-- �����ڷ� ��ϵǾ� �ִ� ������� ��ȸ
-- exists where �� ������� - �ӵ� ����
select empno, ename
    from emp e
        where exists (select empno from emp e2 where e2.empno = e.mgr);

-- self join - �ӵ� ����
select e.empno, e.ename
    from emp e join emp e2 on e2.empno = e.mgr;

-- �μ� ��ȣ�� 30�� ������� �޿��� �μ���ȣ�� ���� ���� ������ ������ ����.
select * 
    from emp e
        where (sal, deptno) IN (select sal, deptno from emp where deptno=30);
        
-- �μ��� ��ձ޿�
select e.*, 
    -- ��Į�� �������� �ۼ��Ǿ�� ��.
    (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno) as avg_sal
    from emp e;
    
select e.*,
(case e.deptno when 10 then (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
when 20 then (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
when 30 then (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
end) avgsal
    from emp e;
    
-- ���� ������ �μ���ȣ, �μ���, �μ���ġ
select ename, deptno, dname, loc
    from emp join dept using (deptno);
    
select ename, deptno, 
    (select dname from dept d where e.deptno=d.deptno) as dname, 
    (select loc from dept d where e.deptno=d.deptno) as loc
    from emp e;
    

