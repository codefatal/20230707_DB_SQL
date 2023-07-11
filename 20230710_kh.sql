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

--1.
select * from job;

--2.
select job_name from job;

--3.
select * from department;

--4.
select emp_name, email, phone, hire_date from employee;

--5.
select hire_date, emp_name, salary from employee;

--6.
select emp_name, salary, salary+(salary*nvl(bonus,0)) as "�Ѽ��ɾ�", (salary+(salary*nvl(bonus,0)))-(salary*0.03) as "�Ǽ��ɾ�" 
    from employee;

--7.
select emp_name, salary, hire_date, phone 
    from employee
        where sal_level='S1';

--8.
select emp_name, salary, (salary+(salary*nvl(bonus,0)))-(salary*0.03) as "�Ǽ��ɾ�", hire_date
    from employee
        where ((salary+(salary*nvl(bonus,0)))-(salary*0.03)) >= 50000000;


select * from employee where bonus is not null order by dept_code;

--�μ� �ڵ�� �޿� 3000000 �̻��� ������ �׷캰 ��� ��ȸ
select DEPT_CODE, round(avg(salary), 0) from employee where salary>=3000000 group by DEPT_CODE;

--�μ� �ڵ�� �޿� ����� 3000000 �̻��� �׷� ��ȸ
select DEPT_CODE, round(avg(salary), 0) from employee group by DEPT_CODE having round(avg(salary), 0)>=3000000;

select * from employee;
select * from department;
select * from location;
select * from NATIONAL;

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
    
        

select * from SAL_GRADE;
select * from NATIONAL;
select * from LOCATION;
select * from JOB;
select * from DEPARTMENT;
select * from EMPLOYEE;

--1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ
select e.emp_name, e.emp_no, d.dept_title, j.job_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
        where (e.emp_no, e.emp_name) IN (select emp_no, emp_name from employee where substr(emp_no, 1, 2)>='70' and substr(emp_no, 1, 2)<='79' and substr(emp_no, 8, 1)='2' and emp_name LIKE '��%');
        
--2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
select emp_id, emp_name, age, dept_title, job_name
    from (select e.emp_id, e.emp_name, d.dept_title, j.job_name, (123 - SUBSTR(e.emp_no, 1, 2)) AS age
            from employee e
                join department d on e.dept_code = d.dept_id
                join job j on e.job_code = j.job_code
                order by age) t
        where rownum = 1;

--3. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
select emp_id, emp_name, job_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
            where emp_name like '%��%';

--4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ
select emp_name, job_name, dept_code, dept_title
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
            where dept_code IN ('D5', 'D6');

--5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ
select emp_name, bonus, dept_title, local_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join location l on d.location_id = l.local_code
            where bonus is not null;

--6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ
select emp_name, job_name, dept_title, local_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
        join location l on d.location_id = l.local_code;

--7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
select emp_name, dept_title, local_name, national_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join location l on d.location_id = l.local_code
        join national n on l.national_code = n.national_code
            where n.national_name = '�ѱ�' or n.national_name = '�Ϻ�';

--8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ
select e.emp_name, e.dept_code, m.emp_name
    from employee e, employee m
        where e.dept_code = m.dept_code
        order by e.emp_name;

--9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�)
select emp_name, job_name, salary
    from employee e
        join job j on e.job_code = j.job_code
            where bonus is null and e.job_code IN ('J4', 'J7');

--10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
select emp_id, emp_name, dept_title, job_name, hire_date
    from (select emp_id, emp_name, dept_title, job_name, hire_date, (salary*(salary+nvl(bonus,0))*12) as grade
        from employee e
            join department d on e.dept_code = d.dept_id
            join job j on e.job_code = j.job_code
            join location l on d.location_id = l.local_code
            order by grade desc) t
        where rownum <= 5;

--11. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
--11-1. JOIN�� HAVING ���
select d.dept_title, sum(salary)
    from employee e
        join department d on e.dept_code = d.dept_id
            group by d.dept_title
                having sum(salary) >= ((select sum(salary) from employee)*0.2);
        
select * from department;
--11-2. �ζ��� �� ���
select *
    from (select d.dept_title, sum(salary) as sums from employee e, department d where e.dept_code=d.dept_id group by d.dept_title) sum
    where sum.sums >= ((select sum(salary) from employee)*0.2);

--11-3. WITH ���
with sum as (select d.dept_title, sum(salary) as sums from employee e, department d where e.dept_code=d.dept_id group by d.dept_title)
select *
    from sum
    where sum.sums >= ((select sum(salary) from employee)*0.2);

--12. �μ� ��� �μ� �� �޿� �հ� ��ȸ
select d.dept_title, sum(e.salary)
    from employee e
        join department d on e.dept_code = d.dept_id
            group by d.dept_title;

--13. WITH�� �̿��Ͽ� �޿� �հ� �޿� ��� ��ȸ
with sumavg as (select sum(salary) as sums, avg(salary) from employee e)
select *
    from sumavg;

--�Ǵ�
