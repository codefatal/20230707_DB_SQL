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
