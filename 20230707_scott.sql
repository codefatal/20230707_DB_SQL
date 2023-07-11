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
select e.*, grade
    from emp e 
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
        order by grade, empno;

--Q. 2
select e.*, grade
    from emp e 
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
        where deptno!=10 order by grade desc, empno desc;

--Q. 3
select grade, round(avg(sal*12+nvl(comm,0)), 0) as "평균연봉"
    from emp e
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
            where deptno!=10 group by grade order by "평균연봉" desc;

--Q. 4
select deptno, round(avg(sal*12+nvl(comm,0)), 0) as "평균연봉"
    from emp e
        join salgrade sa on e.sal > sa.losal and e.sal < sa.hisal
            where deptno!=10 group by deptno order by "평균연봉" desc;

--Q. 5
SELECT e.empno, e.ename, e.job, e.mgr, m.ename as MANAGER
    FROM emp e, emp m
        where e.mgr = m.empno
            order by e.empno;

--Q. 6
SELECT e.empno, e.ename, e.job, e.mgr, (select ename from emp m where m.empno=e.mgr) as MANAGER
    FROM emp e
        order by e.mgr, e.empno desc;

--Q. 7
select * 
    from emp 
        where sal > (select sal from emp where ename IN 'MARTIN') 
            AND (deptno=(select deptno from emp where ename IN 'ALLEN') or deptno=20);

--Q. 8
select e.ename, (select ename from emp m where m.empno=e.mgr) as MANAGER
    from emp e, dept d
        where e.deptno=d.deptno AND d.dname IN 'RESEARCH';

--Q. 9
select sa.grade, ename as "등급별가장작은급여"
    from emp e, salgrade sa
        where (grade, sal) IN (select grade, min(sal) from emp, salgrade where sal >= losal and sal <= hisal group by grade);

--Q. 10
select grade, min(sal) as "MIN_SAL", max(sal) as "MAX_SAL", round(avg(sal), 2) as "AVG_SAL"
    from emp e, salgrade sa
        where sal >= losal and sal <= hisal
        group by grade;

--Q. 11
select sa.grade, e.ename as "평균10프로내외인사원"
    from (select grade, ename, sal, percent_rank() over(partition by grade order by sal desc) as rank from emp, salgrade where sal >= losal and sal <= hisal) e, salgrade sa
        where sal >= losal and sal <= hisal and e.rank <= 0.1;
        
--Q. 12
select empno, ename, sal, 
(case when loc = 'NEW YORK' then sal*1.02
    when loc = 'DALLAS' then sal*1.05
    when loc = 'CHICAGO' then sal*1.03
    when loc = 'BOSTON' then sal*1.07
    end) as SAL_SUBSIDY
    from emp e, dept d
        where e.deptno = d.deptno
            order by (case when loc = 'NEW YORK' then sal*0.02
                        when loc = 'DALLAS' then sal*0.05
                        when loc = 'CHICAGO' then sal*0.03
                        when loc = 'BOSTON' then sal*0.07
                        end) desc;



--with
with abc as (select rownum rnum, e.*
                from (select * from emp where deptno in (20, 30) order by ename asc) e)
select *
    from abc
        where rnum between 7 and 9
            and sal > (select avg(sal) from abc);
            
--view
create view view_abc as 
select rownum rnum, e.*
                from (select * from emp where deptno in (20, 30) order by ename asc) e;
                
