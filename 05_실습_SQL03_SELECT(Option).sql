--1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
--정렬은 이름으로 오름차순 표시하도록 한다.
select student_name as "학생 이름", student_address as "주소지"
    from tb_student
        order by 1;

--2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
select student_name, student_ssn
    from tb_student
        where absence_yn='Y'
            order by 2 desc;

--3. 주소지가 강원도나 경기도인 학생들 중 1900 년대 학번을 가진 학생들의 이름과
--학번, 주소를 이름의 오름차순으로 화면에 출력하시오. 
--단, 출력헤더에는 "학생이름","학번","거주지 주소" 가 출력되도록 한다.
select student_name as "학생 이름", student_no as "학번", student_address as "거주지 주소"
    from tb_student
        where student_no not like 'A%' 
        and (student_address like '강원도%'
        or student_address like '경기도%')
            order by 1;

--4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오. 
--(법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
select professor_name, professor_ssn
    from tb_professor tp
        join tb_department using (department_no)
            where department_name in '법학과'
                order by 2;

--5. 2004 년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
--학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
select student_no, point
    from tb_grade
        where class_no = 'C3118100' and term_no = '200402'
            order by 2 desc, 1 asc;

--6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL문을 작성하시오.
select student_no, student_name, department_name
    from tb_student
        join tb_department using (department_no)
            order by student_name;

--7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
select class_name, department_name
    from tb_class
        join tb_department using (department_no);

--8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
select class_name, professor_name
    from tb_class
        join tb_professor using (department_no);

--9. 8번의 결과 중 ‘인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다. 이에 해당하는 과목 이름과 
--교수 이름을 출력하는 SQL 문을 작성하시오.
select class_name, professor_name
    from tb_class
        join tb_professor using (department_no)
        join tb_department using (department_no)
            where category = '인문사회';
            
--10. '음악학과' 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름",
--"전체 평점"을 출력하는 SQL 문장을 작성하시오. 
--(단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
select student_no as "학번", student_name as "학생 이름", round(avg(point),1) as "전체 평점"
    from tb_student
        join tb_department using (department_no)
        join tb_grade using (student_no)
            where department_name = '음악학과'
                group by student_no, student_name
                    order by 1;
    
--11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기
--위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오. 
--단, 출력헤더는 “학과이름”, “학생이름”, “지도교수이름”으로 출력되도록 한다.
select department_name as "학과이름", student_name as "학생이름", professor_name as "지도교수이름"
    from tb_student ts
        join tb_department td using (department_no)
        join tb_professor tp on ts.coach_professor_no = tp.professor_no
        where student_no = 'A313047';

--12. 2007 년도에 '인간관계론' 과목을 수강한 학생을 찾아 학생이름과 수강학기름 표시하는 SQL 문장을 작성하시오.
select student_name, term_no
    from tb_grade
        join tb_class using (class_no)
        join tb_student using (student_no)
            where class_name = '인간관계론' and substr(term_no,1,4)='2007'
                order by 2;

--13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 그 과목
--이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
select class_name, department_name
    from tb_class tc
        left join tb_professor tp on tc.department_no = tp.department_no
        left join tb_department td on tc.department_no = td.department_no
            where tc.department_no >= '056' and tc.department_no <= '063'
            and tp.department_no is null;

--14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 학생이름과 지도교수 이름을 찾고 
--만일 지도 교수가 없는 학생일 경우 "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오. 
--단, 출력헤더는 “학생이름” 지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.
select student_name as "학생이름", nvl(professor_name,'지도교수 미지정') as "지도교수"
    from tb_student ts
        left join tb_department td using (department_no)
        left join tb_professor tp on ts.coach_professor_no = tp.professor_no
            where department_name = '서반아어학과'
                order by entrance_date;

--15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과
--이름, 평점을 출력하는 SQL 문을 작성하시오.
select student_no, student_name, department_name, round(avg(point),3) as "평점"
    from tb_student ts
        left join tb_department td using (department_no)
        left join tb_grade tg using (student_no)
            where absence_yn = 'N'
            group by student_no, student_name, department_name
                having avg(point) >= 4.0
                    order by 1;



--16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
select class_no, class_name, round(avg(point),3)
    from tb_class tc
        left join tb_grade tg using (class_no)
        left join tb_department td using (department_no)
            where department_name = '환경조경학과'
            group by class_no, class_name;

--17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
select student_name, student_address
    from tb_student ts
        join tb_department td using (department_no)
        where td.department_name IN (select td2.department_name from tb_department td2 join tb_student ts2 on td2.department_no = ts2.department_no where ts2.student_name='최경희');

--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.
select student_no, student_name
from (
    select ts.student_no, ts.student_name, sum(tg.point) as total_point
    from tb_student ts
        join tb_grade tg on ts.student_no = tg.student_no
        join tb_department td on ts.department_no = td.department_no
            where td.department_name = '국어국문학과'
                group by ts.student_no, ts.student_name
) subquery
    order by total_point desc
    fetch first 1 row only;

--19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을
--파악하기 위한 적절한 SQL 문을 찾아내시오. 
--단, 출력헤더는 "계열", "학과명", "전공평점"으로 표시되도록 하고, 
--평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.
select department_name as "계열 학과명", round(avg(point),1) as "전공평점"
    from tb_class tc
    join tb_department td using (department_no)
    join tb_grade tg using (class_no)
        where category in (select category from tb_department where department_name = '환경조경학과')
        group by department_name
        order by 1;




04-11
join-having
having에 서브쿼리 ;;

춘대학교 02-14
춘대학교 03-16
