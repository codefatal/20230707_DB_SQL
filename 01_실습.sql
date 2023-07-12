--1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
select * from emp where comm is not null;

--2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
select * from emp where comm is null or comm=0;

--3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
select * from emp where mgr is null;

--4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
select * from emp order by sal desc;

--5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
select * from emp where sal=sal order by sal desc, comm desc;

--6. EMP���̺��� �����ȣ, �����, ����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
select empno, ename, job, hiredate from emp order by hiredate;

--7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
select empno, ename from emp order by empno desc;

--8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ
--(�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
select empno, hiredate, ename, sal from emp where deptno=deptno order by deptno, hiredate desc;

--9. ���� ��¥�� ���� ���� ��ȸ
select sysdate from dual;

--10. EMP���̺��� ���, �����, �޿� ��ȸ
--(��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
select empno, ename, round(sal, -2) from emp order by sal desc;

--11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
select * from emp where mod(empno, 2)='1';

--12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
select ename, extract(year from hiredate) year, extract(month from hiredate) month from emp;

--13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
select * from emp where extract(month from hiredate)='9';

--14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
select * from emp where extract(year from hiredate)='1981';

--15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
select * from emp where ename like '%E';

--16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
--16-1. LIKE ���
select * from emp where ename like '__R%';
--16-2. SUBSTR() �Լ� ���
select * from emp where substr(ename, 3, 1)='R';

--17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
select empno, ename, hiredate, add_months(hiredate, 480) from emp;

--18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
select * from emp where months_between(sysdate, hiredate)>=456;

--19. ���� ��¥���� �⵵�� ����
select extract(year from sysdate) from dual;

