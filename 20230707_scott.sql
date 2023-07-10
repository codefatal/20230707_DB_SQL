-- 학습용 SCOTT 명령어들
SELECT * FROM EMP;
SELECT EMPNO, ENAME, SAL FROM EMP;
SELECT ENAME, MGR, SAL, DEPTNO FROM emp WHERE DEPTNO=20 OR SAL>1500;
SELECT ENAME, MGR, SAL, DEPTNO FROM emp
--WHERE ENAME = 'smith';
WHERE ENAME = 'SMITH';
-- ORA-00904: "SMITH": 부적합한 식별자

select empno, ename, sal from emp;
-- * 을 사용하는 것 보다 속도 빠름. 권장.
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp;
-- * 보다 컬럼명을 나열하는 것이 속도면에서 좋음.
select * from emp;
select * from dept;
select * from salgrade;
select * from bonus;


-- Q: 사원명과 연봉과 보너스포함한 연봉을 조회
select ename, sal*12, sal*12 + nvl(comm, 0) from emp;
select comm, nvl(comm, 0), nvl(comm, 100) from emp;
select ename as "사원명", sal*12 as "연봉", sal*12 + nvl(comm, 0) as "보너스 포함 연봉" from emp;
select ename "name", sal*12 sal12, sal*12 + nvl(comm, 0) salwcomm from emp;

select '안녕' as hello from emp;
select '안녕' as hello from dept;
select '$' as 단위, sal from emp;
select distinct '$' as 단위, sal from emp;

-- 급여를 1500보다 많이 받고 2800보다 적게 받는 직원 이름과 급여 조회
-- between and 사용
select ename, sal from emp where sal between 1500 and 2799;
-- >= <= 사용
select ename, sal from emp where sal >= 1500 and sal < 2800;

-- 20번 부서 제외
select * from emp where deptno != 20 and comm is null;

-- 10, 20번 부서 사원 정보 조회
select * from emp where deptno = 10 or deptno = 20;

-- 10, 20번 부서 사원 정보 제외
select * from emp where deptno != 10 and deptno != 20;


select sysdate, to_char(sysdate, 'yyyy-mm-dd (dy)') from dual;

alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd';
alter session set NLS_DATE_FORMAT = 'yy/mm/dd';
select sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hours 13
select to_date('2023091113', 'yyyymmddhh24') from dual;
select add_months(to_date('2023091113', 'yyyymmddhh24'), 5) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'), '일') from dual;
select last_day(to_date('2023091113', 'yyyymmddhh24')) from dual;
-- 원래 안됨 select last_day('2023091113') from dual;

select * from emp;

--1.
select * from emp where comm is not null;

--2.
select * from emp where comm is null or comm=0;

--3.
select * from emp where mgr is null;

--4.
select * from emp order by sal desc;

--5.
select * from emp where sal=sal order by sal desc, comm desc;

--6.
select empno, ename, job, hiredate from emp order by hiredate;

--7.
select empno, ename from emp order by empno desc;

--8.
select empno, hiredate, ename, sal from emp where deptno=deptno order by deptno, hiredate desc;

--9.
select sysdate from dual;

--10.
select empno, ename, round(sal, -2) from emp order by sal desc;

--11.
select * from emp where mod(empno, 2)='1';

--12.
select ename, extract(year from hiredate) year, extract(month from hiredate) month from emp;

--13.
select * from emp where extract(month from hiredate)='9';

--14.
select * from emp where extract(year from hiredate)='1981';

--15.
select * from emp where ename like '%E';

--16.
select * from emp where ename like '__R%';
select * from emp where substr(ename, 3, 1)='R';

--17.
select empno, ename, hiredate, add_months(hiredate, 480) from emp;

--18.
select * from emp where months_between(sysdate, hiredate)>=456;

--19.
select extract(year from sysdate) from dual;

--Q. 1
select e.*,
    case when sal <= 1200 then '1'
        when sal <= 1600 then '2'
        when sal <= 2400 then '3'
        when sal <= 3000 then '4'
    else '5'
    end grade
from emp e order by grade, empno;

--Q. 2
select e.*,
    case when sal <= 1200 then '1'
        when sal <= 1600 then '2'
        when sal <= 2400 then '3'
        when sal <= 3000 then '4'
    else '5'
    end grade
from emp e where deptno!=10 order by grade desc;

--Q. 3
select
    case when job = 'CLERK' then '1'
        when job = 'SALESMAN' then '2'
        when job = 'MANAGER' then '3'
        when job = 'ANALYST' then '4'
    end grade, round(avg(sal*12+nvl(comm, 0)), 0) as "평균연봉"
from emp e where deptno!=10 group by job order by "평균연봉" desc;

--Q. 4
select deptno, round(avg(sal*12+nvl(comm, 0)), 0) as "평균연봉" from emp where deptno!=10 group by deptno order by "평균연봉" desc;

--Q. 5
SELECT empno, ename, job, mgr,
  CASE WHEN mgr IN (SELECT empno FROM emp) THEN ename ELSE NULL END AS manager
FROM emp;

--Q. 6
SELECT empno, ename, job, mgr,
  CASE WHEN mgr IN (SELECT empno FROM emp) THEN ename ELSE NULL END AS manager
FROM emp order by empno desc;

select * from emp;


--Q. 7
select * from emp where sal > (select sal from emp where ename IN 'MARTIN') AND (deptno=(select deptno from emp where ename IN 'ALLEN') or deptno=20);

--Q. 8
