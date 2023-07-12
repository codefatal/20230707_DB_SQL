--1. JOB ���̺��� ��� ���� ��ȸ
select * from job;

--2. JOB ���̺��� ���� �̸� ��ȸ
select job_name from job;

--3. DEPARTMENT ���̺��� ��� ���� ��ȸ
select * from department;

--4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
select emp_name, email, phone, hire_date from employee;

--5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
select hire_date, emp_name, salary from employee;

--6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
select emp_name, salary*12 as "����", (salary+(salary*nvl(bonus,0)))*12 as "�Ѽ��ɾ�", ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 as "�Ǽ��ɾ�" 
    from employee;

--7. EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
select emp_name, salary, hire_date, phone 
    from employee
        where sal_level='S1';

--8. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
select emp_name, salary*12 as "����", ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 as "�Ǽ��ɾ�", hire_date
    from employee
        where ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 >= 50000000;
        
--9. EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
select *
    from employee
        where salary >= 4000000 and job_code IN 'J2';

--10. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� ��
--������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
select *
    from employee
        where dept_code IN ('D9', 'D5') and hire_date < to_date(20020101, 'yyyymmdd');

--11. EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
select *
    from employee
        where hire_date > to_date(19900101, 'yyyymmdd') and hire_date < to_date(20010101, 'yyyymmdd');

--12. EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
select emp_name
    from employee
        where emp_name like '%��';

--13. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
select emp_name, phone
    from employee
        where phone not like '010%';

--14. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
select *
    from employee
        where email like '____#_%' ESCAPE '#' 
        and dept_code in ('D9', 'D6')
        and hire_date > to_date(19900101, 'yyyymmdd') 
        and hire_date < to_date(20001201, 'yyyymmdd') 
        and salary >= 2700000;

--15. EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
select emp_name, substr(emp_no, 1, 2) as "����", substr(emp_no, 3, 2) as "����", substr(emp_no, 5, 2) as "����"
    from employee;

--16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
select emp_name, rpad(substr(emp_no,1,7),14, '*') as "�ֹι�ȣ"
    from employee;

--17. EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
--(��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
select emp_name, abs(floor(sysdate-hire_date)) as "�ٹ��ϼ�1", abs(floor(hire_date-sysdate)) as "�ٹ��ϼ�2"
    from employee;

--18. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
select *
    from employee
        where mod(emp_id, 2)=1;

--19. EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
select *
    from employee
        where months_between(sysdate, hire_date) >= 240;

--20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
select emp_name, to_char(salary, 'L999,999,999') as "�޿�"
    from employee;

--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
--(��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
--���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
select emp_name, dept_code, substr(emp_no,1,2)||'�� '||substr(emp_no,3,2)||'�� '||substr(emp_no,5,2)||'��' as "�������", 2023-(1900+substr(emp_no,1,2)) as "����"
    from employee;

--22. EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
--(��, �μ��ڵ� ������������ ����)
select emp_id, emp_name, dept_code, dept_title
    from employee e
        join department d on e.dept_code = d.dept_id
            where dept_code in ('D5', 'D6', 'D9')
                order by dept_code;

--23. EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�,
--�ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
select emp_name, substr(emp_no, 1, 6) as "���ڸ�", substr(emp_no, 8, 14) as "���ڸ�", substr(emp_no, 1, 6)+substr(emp_no, 8, 14) as "�ֹι�ȣ�հ�"
    from employee
        where emp_id = 201;

--24. EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
select sum((salary+(salary*nvl(bonus,0)))*12) as "�Ѽ��ɾ�"
    from employee
        where dept_code in 'D5';

--25. EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
--��ü ���� ��, 2001��, 2002��, 2003��, 2004��
select count(*) as "��ü������", 
    count(case when substr(hire_date,1,2) in '01' then 1 end) as "2001��", 
    count(case when substr(hire_date,1,2) in '02' then 1 end) as "2002��", 
    count(case when substr(hire_date,1,2) in '03' then 1 end) as "2003��", 
    count(case when substr(hire_date,1,2) in '04' then 1 end) as "2004��"
        from employee e;


