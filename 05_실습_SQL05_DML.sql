select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

--1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�. 
INSERT INTO TB_CLASS_TYPE VALUES ('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES ('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '������');
commit;

select * from TB_CLASS_TYPE;

--2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�) 
--view vw_�л��Ϲ������� ���� ���
create table TB_�л��Ϲ�����
    as select * from vw_�л��Ϲ�����;

-- view vw_�л��Ϲ������� �Ⱦ��� ���
create table TB_�л��Ϲ�����
    as select student_no as "�й�", student_name as "�л��̸�", student_address as "�ּ�"
        from tb_student;

select * from tb_�л��Ϲ�����;

--3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�) 
create table TB_������а�
    as select student_no as "�й�", student_name as "�л��̸�", substr(student_ssn,1,2)+1900 as "����⵵", professor_name as "�����̸�"
        from tb_student ts
            join tb_department td using (department_no)
            join tb_professor tp on ts.coach_professor_no = tp.professor_no
                where department_name = '������а�'
;

select * from tb_������а�;

--4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�.
--(��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�) 
update tb_department set capacity = trunc(capacity*1.1);

select * from tb_department;

--5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ� �Ѵ�. 
--�ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�. 
update tb_student set student_address = '����� ���α� ���ε� 181-21 ' where student_no = 'A413042';

select * from tb_student where student_no = 'A413042';

--6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���. 
--�� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�. 
--(all. 830530-2124663 => 830530 ) 
update tb_student set student_ssn = substr(student_ssn,1, 6);

select * from tb_student;

--7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����' ������ �߸��Ǿ��ٴ� ���� 
--�߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5�� ����Ű�� �����Ǿ���. 
--������ SQL ���� �ۼ��Ͻÿ�. 
update tb_grade set point = '3.5' 
where (student_no, class_no) in (select student_no, class_no
    from tb_student 
        join tb_department using (department_no)
        join tb_grade using (student_no)
        join tb_class using (class_no)
        where student_name = '�����' and department_name = '���а�' and term_no = '200501' and class_name = '�Ǻλ�����');

select * from tb_grade;

--8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�. 
delete from tb_grade 
where student_no in (select student_no
    from tb_student 
        left join tb_grade using (student_no)
        where absence_yn = 'Y');

select * from tb_student where absence_yn = 'Y';