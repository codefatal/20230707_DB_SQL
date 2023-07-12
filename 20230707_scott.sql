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


-- SALESMAN 들의 급여와 같은 급여를 받는 사원을 조회
select empno, ename, sal
    from emp
        where sal in (select sal from emp where job='SALESMAN');

-- 관리자로 등록되어 있는 사원들의 조회
-- exists where 절 상관쿼리 - 속도 빠름
select empno, ename
    from emp e
        where exists (select empno from emp e2 where e2.empno = e.mgr);

-- self join - 속도 느림
select e.empno, e.ename
    from emp e join emp e2 on e2.empno = e.mgr;

-- 부서 번호가 30인 사원들의 급여와 부서번호를 묶어 메인 쿼리로 전달해 보자.
select * 
    from emp e
        where (sal, deptno) IN (select sal, deptno from emp where deptno=30);
        
-- 부서별 평균급여
select e.*, 
    -- 스칼라 서브쿼리 작성되어야 함.
    (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno) as avg_sal
    from emp e;
    
select e.*,
(case e.deptno when 10 then (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
when 20 then (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
when 30 then (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
end) avgsal
    from emp e;
    
-- 직원 정보와 부서번호, 부서명, 부서위치
select ename, deptno, dname, loc
    from emp join dept using (deptno);
    
select ename, deptno, 
    (select dname from dept d where e.deptno=d.deptno) as dname, 
    (select loc from dept d where e.deptno=d.deptno) as loc
    from emp e;
    

