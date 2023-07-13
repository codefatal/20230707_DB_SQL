select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

--1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭"�� ǥ���ϵ��� �Ѵ�.
select department_name as "�а� ��", category as "�迭"
    from tb_department
        group by department_name, category;
        
--2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
select department_name||'�� ������ ' ||count(*)||'�� �Դϴ�.' as "�а��� ����"
    from tb_department td
        left join tb_student ts using (department_no)
            group by department_name;

--3. "������а�"�� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. �����ΰ�?
--(�����а��� '�а��ڵ�'�� �а� ���̺��� ��ȸ �ؼ� ã�� ������ ����)
select student_name
    from tb_student ts, tb_department td
        where ts.department_no=td.department_no 
        and td.department_name='������а�' 
        and ts.absence_yn='Y'
        and substr(student_ssn,8,1)=2;
        
--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
--�� ������� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
--A513079, A513090, A513091, A513110, A513119
select student_name
    from tb_student
        where student_no IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
            order by student_name desc;
            
--5. ���� ������ 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
select department_name, category
    from tb_department
        where capacity between 20 and 30;
        
--6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
--�׷� �� ������б��� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
select professor_name
    from tb_professor
        where department_no is null;
        
--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� �ʴ� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
select student_name
    from tb_student
        where department_no is null;


select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

        
--8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ� ���������� �����ϴ� �������
--� �������� �����ȣ�� ��ȸ�غ��ÿ�.
select class_no
    from tb_class
        where preattending_class_no is not null;
        
--9. �� ���п��� � �迭(category)���� �ִ��� ��ȸ�غ��ÿ�.
select category
    from tb_department
        group by category
            order by category;
            
--10. 02�й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ �������� �л�����
--�й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
select student_no, student_name, student_ssn
    from tb_student
        where student_no like'A2%' 
        and student_address like '����%'
        and absence_yn='N'
            order by student_name;