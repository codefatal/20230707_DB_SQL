--1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오. 
INSERT INTO TB_CLASS_TYPE VALUES ('01', '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES ('03', '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '논문지도');
commit;

select * from TB_CLASS_TYPE;

--2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 만들고자 한다. 
--아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (서브쿼리를 이용하시오) 
--view vw_학생일반정보를 쓰는 경우
create table TB_학생일반정보
    as select * from vw_학생일반정보;

-- view vw_학생일반정보를 안쓰는 경우
create table TB_학생일반정보
    as select student_no as "학번", student_name as "학생이름", student_address as "주소"
        from tb_student;

select * from tb_학생일반정보;

--3. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다. 
--아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏 작성하시오) 
create table TB_국어국문학과
    as select student_no as "학번", student_name as "학생이름", substr(student_ssn,1,2)+1900 as "출생년도", professor_name as "교수이름"
        from tb_student ts
            join tb_department td using (department_no)
            join tb_professor tp on ts.coach_professor_no = tp.professor_no
                where department_name = '국어국문학과'
;

select * from tb_국어국문학과;

--4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL 문을 작성하시오.
--(단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다) 
update tb_department set capacity = trunc(capacity*1.1);

select * from tb_department;

--5. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고 한다. 
--주소지를 정정하기 위해 사용할 SQL 문을 작성하시오. 
update tb_student set student_address = '서울시 종로구 숭인동 181-21 ' where student_no = 'A413042';

select * from tb_student where student_no = 'A413042';

--6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로 결정하였다. 
--이 내용을 반영할 적절한 SQL 문장을 작성하시오. 
--(all. 830530-2124663 => 830530 ) 
update tb_student set student_ssn = substr(student_ssn,1, 6);

select * from tb_student;

--7. 의학과 김명훈 학생은 2005년 1학기에 자신이 수강한 '피부생리학' 점수가 잘못되었다는 것을 
--발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당 과목의 학점을 3.5로 변경키로 결정되었다. 
--적절한 SQL 문을 작성하시오. 
update tb_grade set point = '3.5' 
where (student_no, class_no) in (select student_no, class_no
    from tb_student 
        join tb_department using (department_no)
        join tb_grade using (student_no)
        join tb_class using (class_no)
        where student_name = '김명훈' and department_name = '의학과' and term_no = '200501' and class_name = '피부생리학');

select * from tb_grade;

--8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오. 
delete from tb_grade 
where student_no in (select student_no
    from tb_student 
        left join tb_grade using (student_no)
        where absence_yn = 'Y');

select * from tb_student where absence_yn = 'Y';

