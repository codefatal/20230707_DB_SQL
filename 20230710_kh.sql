select * from SAL_GRADE;
select * from NATIONAL;
select * from LOCATION;
select * from JOB;
select * from DEPARTMENT;
select * from EMPLOYEE;

--�޿��� 3500000���� ���� �ް� 6000000���� ���� �޴� ���� �̸��� �޿� ��ȸ
select EMP_NAME, salary from EMPLOYEE where salary >=3500000 and salary < 6000000;

--�������� ���� ���� ���� �̸��� �޿� ��ȸ
select EMP_NAME, salary from EMPLOYEE where EMP_NAME LIKE '��%';

--EMAIL ID �� ��_���� ���� 3�ڸ��� ���� �̸�, �̸��� ��ȸ
select EMP_NAME, PHONE from employee where email LIKE '___#_%' ESCAPE '#';

--���̡��� ���� �ƴ� ���� ���, �̸�, �̸��� ��ȸ
select EMP_ID, EMP_NAME, EMAIL from employee where EMP_NAME NOT LIKE '��%';

--�����ڵ� ���� �μ� ��ġ�� ���� ���� ���� ��ȸ
select * from employee where DEPT_CODE is not NULL AND MANAGER_ID is not NULL;

--�μ� ��ġ�� ���� �ʾ����� ���ʽ��� ���޹޴� ���� ��ȸ
select * from employee where DEPT_CODE is NULL AND BONUS is not NULL;

--D6 �μ��� D8 �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
select EMP_NAME, DEPT_CODE, SALARY from employee where DEPT_CODE IN ('D6', 'D8');

--��J2�� �Ǵ� ��J7�� ���� �ڵ� �� �޿��� 2000000���� ���� �޴� ������ �̸�, �޿�, �����ڵ� ��ȸ
select EMP_NAME, SALARY, JOB_CODE from employee where JOB_CODE IN ('J2', 'J7') AND SALARY>2000000;

select email, instr(email, '@', -1, 1) ��ġ from employee;

select sysdate from dual;

select * from employee;

select EMP_NAME, EMP_NO, DECODE(substr(EMP_NO, 8, 1), '1', '��', '2', '��') as "����" from employee;

