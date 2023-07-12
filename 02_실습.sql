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
select emp_name, salary, salary+(salary*nvl(bonus,0)) as "총수령액", (salary+(salary*nvl(bonus,0)))-(salary*0.03) as "실수령액" 
    from employee;

--7.
select emp_name, salary, hire_date, phone 
    from employee
        where sal_level='S1';

--8.
select emp_name, salary, (salary+(salary*nvl(bonus,0)))-(salary*0.03) as "실수령액", hire_date
    from employee
        where ((salary+(salary*nvl(bonus,0)))-(salary*0.03)) >= 50000000;