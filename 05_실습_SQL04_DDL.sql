select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

--1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
create table TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) default 'Y' check(USE_YN IN ('Y','N')) 
);

--2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
create table TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3. TB_CATEGORY ���̺��� NAME �÷��� PRIMARY KEY�� �����Ͻÿ�.
--(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸���
--������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
alter table tb_category
    add constraint name_pk PRIMARY KEY(NAME);

--4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
alter table tb_class_type
    modify name constraint name_nn not null;

--5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
--NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
alter table tb_category
    modify NAME VARCHAR(20);
    
alter table tb_class_type
    modify NO VARCHAR(10)
    modify NAME VARCHAR(20);

--6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
--���� ���·� �����Ѵ�.
alter table tb_category
    rename column NAME to CATEGORY_NAME;
    
alter table tb_class_type
    rename column NO to CLASS_TYPE_NO;
    
alter table tb_class_type    
    rename column NAME to CLASS_TYPE_NAME;

--7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
alter table tb_category
    rename constraint name_pk to PK_CATEGORY_NAME;
    
alter table tb_class_type
    rename constraint SYS_C008396 to PK_CLASS_TYPE_NO;

--8. ������ ���� INSERT ���� �����Ѵ�.
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('����', 'Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��', 'Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ', 'Y');
commit;

--9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� 
--�θ� ������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. 
--�� �� KEY �̸��� FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
alter table tb_department
    add constraint FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

--10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW�� ������� �Ѵ�.
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
create or replace view "VW_�л��Ϲ�����"
    as select student_no as "�й�", student_name as "�л��̸�", student_address as "�ּ�"
        from tb_student;
        
select * from vw_�л��Ϲ�����;
--11. �� ������б��� 1�⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ�(��, �� VIEW �� �ܼ� SELECT ���� �� ��� 
--�а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
create or replace view "VW_�������"
    as select student_name as "�л��̸�", department_name as "�а��̸�", professor_name as "���������̸�"
        from tb_student ts
            left join tb_department td using (department_no)
            left join tb_professor tp on ts.coach_professor_no = tp.professor_no;
            
select * from vw_�������;
            
--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
create or replace view "VW_�а����л���"
    as select department_name as "�а��̸�", count(*) as "�л���"
        from tb_student
            join tb_department using (department_no)
                group by department_name;

select * from vw_�а����л���;

--13. ������ ������ �л��Ϲ����� View�� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
--�̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
update vw_�л��Ϲ����� set �л��̸� = '������' where �й� = 'A213046';

select * from vw_�л��Ϲ����� where �й� = 'A213046';

--14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� ��������
--VIEW �� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
create or replace view "VW_�л��Ϲ�����"
    as select student_no as "�й�", student_name as "�л��̸�", student_address as "�ּ�"
        from tb_student
        -- �б� ����
        with read only;

--15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
--������ �ǰ� �ִ�.�ֱ� 3���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������ �ۼ��غ��ÿ�.
create or replace view "VW_�α����_TOP3"
    as select class_no as "�����ȣ", class_name as "�����̸�", count(*) as "������������(��)"
        from tb_grade
            join tb_class using (class_no)
            where term_no between '2007%' and '2010%'
                group by class_no, class_name
                    order by 3 desc
                    fetch first 3 row only;

select * from vw_�α����_top3;