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
select * from bonus;


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



