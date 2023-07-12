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

select * from employee where bonus is not null order by dept_code;

--부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
select DEPT_CODE, round(avg(salary), 0) from employee where salary>=3000000 group by DEPT_CODE;

--부서 코드와 급여 평균이 3000000 이상인 그룹 조회
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
    
        