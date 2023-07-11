select * from SAL_GRADE;
select * from NATIONAL;
select * from LOCATION;
select * from JOB;
select * from DEPARTMENT;
select * from EMPLOYEE;

--급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원 이름과 급여 조회
select EMP_NAME, salary from EMPLOYEE where salary >=3500000 and salary < 6000000;

--‘전’씨 성을 가진 직원 이름과 급여 조회
select EMP_NAME, salary from EMPLOYEE where EMP_NAME LIKE '전%';

--EMAIL ID 중 ‘_’의 앞이 3자리인 직원 이름, 이메일 조회
select EMP_NAME, PHONE from employee where email LIKE '___#_%' ESCAPE '#';

--‘이’씨 성이 아닌 직원 사번, 이름, 이메일 조회
select EMP_ID, EMP_NAME, EMAIL from employee where EMP_NAME NOT LIKE '이%';

--관리자도 없고 부서 배치도 받지 않은 직원 조회
select * from employee where DEPT_CODE is not NULL AND MANAGER_ID is not NULL;

--부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
select * from employee where DEPT_CODE is NULL AND BONUS is not NULL;

--D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
select EMP_NAME, DEPT_CODE, SALARY from employee where DEPT_CODE IN ('D6', 'D8');

--‘J2’ 또는 ‘J7’ 직급 코드 중 급여를 2000000보다 많이 받는 직원의 이름, 급여, 직급코드 조회
select EMP_NAME, SALARY, JOB_CODE from employee where JOB_CODE IN ('J2', 'J7') AND SALARY>2000000;

select email, instr(email, '@', -1, 1) 위치 from employee;

select sysdate from dual;

select * from employee;

select EMP_NAME, EMP_NO, DECODE(substr(EMP_NO, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여') as "성별" from employee;

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


select * from employee where bonus is not null order by dept_code;

--부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
select DEPT_CODE, round(avg(salary), 0) from employee where salary>=3000000 group by DEPT_CODE;

--부서 코드와 급여 평균이 3000000 이상인 그룹 조회
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

--전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
select emp_name, job_code, dept_code, salary
    from employee e
        where salary >= (select avg(salary) from employee)
            order by 2;

--부서 별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
select emp_name, job_code, dept_code, salary
    from employee
        where salary IN (select max(salary) from employee group by dept_code)
            order by 3;
            
--퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일 조회
select emp_name, job_code, dept_code, hire_date
    from employee
        where (dept_code, job_code) IN (select dept_code, job_code from employee where substr(emp_no, 8, 1)=2 and ent_yn='Y');

--직급별 최소 급여를 받는 직원의 사번, 이름, 직급, 급여 조회
select emp_id, emp_name, job_code, salary
    from employee
        where (job_code, salary) IN (select job_code, min(salary) from employee group by job_code)
            order by 3;

--인라인 뷰(INLINE-VIEW) / FROM절에 서브쿼리 사용한 것
select rownum, emp_name, salary
    from employee
        where rownum <= 5
            order by salary desc;
            
select rownum, emp_name, salary
    from (select * from employee order by salary desc)
        where rownum <= 5;
        
--WITH / 서브쿼리에 이름을 붙여주고 인라인 뷰로 사용 시 서브쿼리의 이름으로 FROM절에 기술 가능
--같은 서브쿼리가 여러 번 사용될 경우 중복 작성을 피할 수 있고 실행속도도 빨라진다는 장점이 있음
with topn_sal as (select emp_name, salary from employee order by salary desc)
select rownum, emp_name, salary
    from topn_sal;
    
--rank() over
select "순위", emp_name, salary
    from (select emp_name, salary, rank() over(order by salary desc) as "순위"
            from employee
                order by salary desc);
                
--DENSE_RANK() OVER
select "순위", emp_name, salary
    from (select emp_name, salary, dense_rank() over(order by salary desc) as "순위"
            from employee
                order by salary desc);
    
        

select * from SAL_GRADE;
select * from NATIONAL;
select * from LOCATION;
select * from JOB;
select * from DEPARTMENT;
select * from EMPLOYEE;

--1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
select e.emp_name, e.emp_no, d.dept_title, j.job_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
        where (e.emp_no, e.emp_name) IN (select emp_no, emp_name from employee where substr(emp_no, 1, 2)>='70' and substr(emp_no, 1, 2)<='79' and substr(emp_no, 8, 1)='2' and emp_name LIKE '전%');
        
--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
select emp_id, emp_name, age, dept_title, job_name
    from (select e.emp_id, e.emp_name, d.dept_title, j.job_name, (123 - SUBSTR(e.emp_no, 1, 2)) AS age
            from employee e
                join department d on e.dept_code = d.dept_id
                join job j on e.job_code = j.job_code
                order by age) t
        where rownum = 1;

--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
select emp_id, emp_name, job_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
            where emp_name like '%형%';

--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
select emp_name, job_name, dept_code, dept_title
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
            where dept_code IN ('D5', 'D6');

--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
select emp_name, bonus, dept_title, local_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join location l on d.location_id = l.local_code
            where bonus is not null;

--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
select emp_name, job_name, dept_title, local_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
        join location l on d.location_id = l.local_code;

--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
select emp_name, dept_title, local_name, national_name
    from employee e
        join department d on e.dept_code = d.dept_id
        join location l on d.location_id = l.local_code
        join national n on l.national_code = n.national_code
            where n.national_name = '한국' or n.national_name = '일본';

--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select e.emp_name, e.dept_code, m.emp_name
    from employee e, employee m
        where e.dept_code = m.dept_code
        order by e.emp_name;

--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
select emp_name, job_name, salary
    from employee e
        join job j on e.job_code = j.job_code
            where bonus is null and e.job_code IN ('J4', 'J7');

--10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
select emp_id, emp_name, dept_title, job_name, hire_date
    from (select emp_id, emp_name, dept_title, job_name, hire_date, (salary*(salary+nvl(bonus,0))*12) as grade
        from employee e
            join department d on e.dept_code = d.dept_id
            join job j on e.job_code = j.job_code
            join location l on d.location_id = l.local_code
            order by grade desc) t
        where rownum <= 5;

--11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
--11-1. JOIN과 HAVING 사용
select d.dept_title, sum(salary)
    from employee e
        join department d on e.dept_code = d.dept_id
            group by d.dept_title
                having sum(salary) >= ((select sum(salary) from employee)*0.2);
        
select * from department;
--11-2. 인라인 뷰 사용
select *
    from (select d.dept_title, sum(salary) as sums from employee e, department d where e.dept_code=d.dept_id group by d.dept_title) sum
    where sum.sums >= ((select sum(salary) from employee)*0.2);

--11-3. WITH 사용
with sum as (select d.dept_title, sum(salary) as sums from employee e, department d where e.dept_code=d.dept_id group by d.dept_title)
select *
    from sum
    where sum.sums >= ((select sum(salary) from employee)*0.2);

--12. 부서 명과 부서 별 급여 합계 조회
select d.dept_title, sum(e.salary)
    from employee e
        join department d on e.dept_code = d.dept_id
            group by d.dept_title;

--13. WITH를 이용하여 급여 합과 급여 평균 조회
with sumavg as (select sum(salary) as sums, avg(salary) from employee e)
select *
    from sumavg;

--또는
