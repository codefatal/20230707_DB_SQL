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

select EMP_NAME, EMP_NO, DECODE(substr(EMP_NO, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��') as "����" from employee;

select * from employee where bonus is not null order by dept_code;

--�μ� �ڵ�� �޿� 3000000 �̻��� ������ �׷캰 ��� ��ȸ
select DEPT_CODE, round(avg(salary), 0) from employee where salary>=3000000 group by DEPT_CODE;

--�μ� �ڵ�� �޿� ����� 3000000 �̻��� �׷� ��ȸ
select DEPT_CODE, round(avg(salary), 0) from employee group by DEPT_CODE having round(avg(salary), 0)>=3000000;


select emp_name, dept_code, location_id
    from employee e, department d
    where e.dept_code = d.dept_id and location_id='L1';

select e.emp_name, e.dept_code, d.dept_title, l.national_code, n.national_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join location l on d.location_id = l.local_code
        join national n on l.national_code = n.national_code;

select * 
    from employee e
        left outer join department d on e.dept_code=d.dept_id;

--�� ������ �޿� ��պ��� ���� �޿��� �޴� ������ �̸�, ����, �μ�, �޿� ��ȸ
select emp_name, job_code, dept_code, salary
    from employee e
        where salary >= (select avg(salary) from employee)
            order by 2;

--�μ� �� �ְ� �޿��� �޴� ������ �̸�, ����, �μ�, �޿� ��ȸ
select emp_name, job_code, dept_code, salary
    from employee
        where salary IN (select max(salary) from employee group by dept_code)
            order by 3;
            
--����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, ����, �μ�, �Ի��� ��ȸ
select emp_name, job_code, dept_code, hire_date
    from employee
        where (dept_code, job_code) IN (select dept_code, job_code from employee where substr(emp_no, 8, 1)=2 and ent_yn='Y');

--���޺� �ּ� �޿��� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
select emp_id, emp_name, job_code, salary
    from employee
        where (job_code, salary) IN (select job_code, min(salary) from employee group by job_code)
            order by 3;

--�ζ��� ��(INLINE-VIEW) / FROM���� �������� ����� ��
select rownum, emp_name, salary
    from employee
        where rownum <= 5
            order by salary desc;
            
select rownum, emp_name, salary
    from (select * from employee order by salary desc)
        where rownum <= 5;
        
--WITH / ���������� �̸��� �ٿ��ְ� �ζ��� ��� ��� �� ���������� �̸����� FROM���� ��� ����
--���� ���������� ���� �� ���� ��� �ߺ� �ۼ��� ���� �� �ְ� ����ӵ��� �������ٴ� ������ ����
with topn_sal as (select emp_name, salary from employee order by salary desc)
select rownum, emp_name, salary
    from topn_sal;
    
--rank() over
select "����", emp_name, salary
    from (select emp_name, salary, rank() over(order by salary desc) as "����"
            from employee
                order by salary desc);
                
--DENSE_RANK() OVER
select "����", emp_name, salary
    from (select emp_name, salary, dense_rank() over(order by salary desc) as "����"
            from employee
                order by salary desc);
    
        