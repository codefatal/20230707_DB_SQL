select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
select student_name as "�л� �̸�", student_address as "�ּ���"
    from tb_student
        order by 1;

--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
select student_name, student_ssn
    from tb_student
        where absence_yn='Y'
            order by 2 desc;

--3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸���
--�й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. 
--��, ���������� "�л��̸�","�й�","������ �ּ�" �� ��µǵ��� �Ѵ�.
select student_name as "�л� �̸�", student_no as "�й�", student_address as "������ �ּ�"
    from tb_student
        where student_no not like 'A%' 
        and (student_address like '������%'
        or student_address like '��⵵%')
            order by 1;

--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 
--(���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
select professor_name, professor_ssn
    from tb_professor tp
        join tb_department using (department_no)
            where department_name in '���а�'
                order by 2;

--5. 2004 �� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�. 
--������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
select student_no, point
    from tb_grade
        where class_no = 'C3118100' and term_no = '200402'
            order by 2 desc, 1 asc;

--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
select student_no, student_name, department_name
    from tb_student
        join tb_department using (department_no)
            order by student_name;

--7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
select class_name, department_name
    from tb_class
        join tb_department using (department_no);

--8. ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
select class_name, professor_name
    from tb_class
        join tb_professor using (department_no);

--9. 8���� ��� �� ���ι���ȸ' �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. �̿� �ش��ϴ� ���� �̸��� 
--���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
select class_name, professor_name
    from tb_class
        join tb_professor using (department_no)
        join tb_department using (department_no)
            where category = '�ι���ȸ';
            
--10. '�����а�' �л����� ������ ���Ϸ��� �Ѵ�. �����а� �л����� "�й�", "�л� �̸�",
--"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--(��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
select student_no as "�й�", student_name as "�л� �̸�", round(avg(point),1) as "��ü ����"
    from tb_student
        join tb_department using (department_no)
        join tb_grade using (student_no)
            where department_name = '�����а�'
                group by student_no, student_name
                    order by 1;
    
--11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ���� �ۼ��Ͻÿ�. 
--��, �������� ���а��̸���, ���л��̸���, �����������̸������� ��µǵ��� �Ѵ�.
select department_name as "�а��̸�", student_name as "�л��̸�", professor_name as "���������̸�"
    from tb_student ts
        join tb_department td using (department_no)
        join tb_professor tp on ts.coach_professor_no = tp.professor_no
        where student_no = 'A313047';

--12. 2007 �⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
select student_name, term_no
    from tb_grade
        join tb_class using (class_no)
        join tb_student using (student_no)
            where class_name = '�ΰ������' and substr(term_no,1,4)='2007'
                order by 2;

--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
select class_name, department_name
    from tb_class tc
        left join tb_professor tp on tc.department_no = tp.department_no
        left join tb_department td on tc.department_no = td.department_no
            where tc.department_no >= '056' and tc.department_no <= '063'
            and tp.department_no is null;

--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. �л��̸��� �������� �̸��� ã�� 
--���� ���� ������ ���� �л��� ��� "�������� ������������ ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. 
--��, �������� ���л��̸��� ��������"�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
select student_name as "�л��̸�", nvl(professor_name,'�������� ������') as "��������"
    from tb_student ts
        left join tb_department td using (department_no)
        left join tb_professor tp on ts.coach_professor_no = tp.professor_no
            where department_name = '���ݾƾ��а�'
                order by entrance_date;

--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
select student_no, student_name, department_name, round(avg(point),3) as "����"
    from tb_student ts
        left join tb_department td using (department_no)
        left join tb_grade tg using (student_no)
            where absence_yn = 'N'
            group by student_no, student_name, department_name
                having avg(point) >= 4.0
                    order by 1;



--16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
select class_no, class_name, round(avg(point),3)
    from tb_class tc
        left join tb_grade tg using (class_no)
        left join tb_department td using (department_no)
            where department_name = 'ȯ�������а�'
            group by class_no, class_name;

--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
select student_name, student_address
    from tb_student ts
        join tb_department td using (department_no)
        where td.department_name IN (select td2.department_name from tb_department td2 join tb_student ts2 on td2.department_no = ts2.department_no where ts2.student_name='�ְ���');

--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
select student_no, student_name
from (
    select ts.student_no, ts.student_name, sum(tg.point) as total_point
    from tb_student ts
        join tb_grade tg on ts.student_no = tg.student_no
        join tb_department td on ts.department_no = td.department_no
            where td.department_name = '������а�'
                group by ts.student_no, ts.student_name
) subquery
    order by total_point desc
    fetch first 1 row only;

--19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. 
--��, �������� "�迭", "�а���", "��������"���� ǥ�õǵ��� �ϰ�, 
--������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.
select department_name as "�迭 �а���", round(avg(point),1) as "��������"
    from tb_class tc
    join tb_department td using (department_no)
    join tb_grade tg using (class_no)
        where category in (select category from tb_department where department_name = 'ȯ�������а�')
        group by department_name
        order by 1;
