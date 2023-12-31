--1. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
create table TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) default 'Y' check(USE_YN IN ('Y','N')) 
);

--2. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
create table TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY를 생성하시오.
--(KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이를 지정하고자 한다면 이름은
--본인이 알아서 적당한 이름을 사용한다.)
alter table tb_category
    add constraint name_pk PRIMARY KEY(NAME);

--4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
alter table tb_class_type
    modify name constraint name_nn not null;

--5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
--NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
alter table tb_category
    modify NAME VARCHAR(20);
    
alter table tb_class_type
    modify NO VARCHAR(10)
    modify NAME VARCHAR(20);

--6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외한 테이블 이름이 앞에
--붙은 형태로 변경한다.
alter table tb_category
    rename column NAME to CATEGORY_NAME;
    
alter table tb_class_type
    rename column NO to CLASS_TYPE_NO;
    
alter table tb_class_type    
    rename column NAME to CLASS_TYPE_NAME;

--7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
alter table tb_category
    rename constraint name_pk to PK_CATEGORY_NAME;
    
alter table tb_class_type
    rename constraint SYS_C008396 to PK_CLASS_TYPE_NO;

--8. 다음과 같은 INSERT 문을 수행한다.
INSERT INTO TB_CATEGORY VALUES ('공학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('의학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('예체능', 'Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회', 'Y');
commit;

--9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 
--부모 값으로 참조하도록 FOREIGN KEY 를 지정하시오. 
--이 때 KEY 이름은 FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY )
alter table tb_department
    add constraint FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

--10. 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW를 만들고자 한다.
--아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
create or replace view "VW_학생일반정보"
    as select student_no as "학번", student_name as "학생이름", student_address as "주소"
        from tb_student;
        
select * from vw_학생일반정보;
--11. 춘 기술대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다.
--이를 위해 사용할 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 만드시오.
--이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오(단, 이 VIEW 는 단순 SELECT 만을 할 경우 
--학과별로 정렬되어 화면에 보여지게 만드시오.)
create or replace view "VW_지도면담"
    as select student_name as "학생이름", department_name as "학과이름", professor_name as "지도교수이름"
        from tb_student ts
            left join tb_department td using (department_no)
            left join tb_professor tp on ts.coach_professor_no = tp.professor_no;
            
select * from vw_지도면담;
            
--12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자.
create or replace view "VW_학과별학생수"
    as select department_name as "학과이름", count(*) as "학생수"
        from tb_student
            join tb_department using (department_no)
                group by department_name;

select * from vw_학과별학생수;

--13. 위에서 생성한 학생일반정보 View를 통해서 학번이 A213046 인 학생의 이름을 본인
--이름으로 변경하는 SQL 문을 작성하시오.
update vw_학생일반정보 set 학생이름 = '유수현' where 학번 = 'A213046';

select * from vw_학생일반정보 where 학번 = 'A213046';

--14. 13 번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면
--VIEW 를 어떻게 생성해야 하는지 작성하시오.
create or replace view "VW_학생일반정보"
    as select student_no as "학번", student_name as "학생이름", student_address as "주소"
        from tb_student
        -- 읽기 전용
        with read only;

--15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려
--문제가 되고 있다.최근 3년을 기준으로 수강인원이 가장 많았던 3 과목을 찾는 구문을 작성해보시오.
create or replace view "VW_인기과목_TOP3"
    as select class_no as "과목번호", class_name as "과목이름", count(*) as "누적수강생수(명)"
        from tb_grade
            join tb_class using (class_no)
            where term_no between '2007%' and '2010%'
                group by class_no, class_name
                    order by 3 desc
                    fetch first 3 row only;

select * from vw_인기과목_top3;

