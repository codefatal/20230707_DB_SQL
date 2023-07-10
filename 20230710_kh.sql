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

select EMP_NAME, EMP_NO, DECODE(substr(EMP_NO, 8, 1), '1', '남', '2', '여') as "성별" from employee;

