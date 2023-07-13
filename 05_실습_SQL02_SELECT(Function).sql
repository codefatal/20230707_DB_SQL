select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
select student_no as "�й�", student_name as "�̸�", to_char(entrance_date, 'yyyy-mm-dd') as "���г⵵"
    from tb_student
        join tb_department using (department_no)
            where department_name='������а�'
                order by 3;

--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. 
--�� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. 
--(* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
select professor_name, professor_ssn
    from tb_professor
        where professor_name not like '___'
            order by 1;

--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--�� �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. 
--(��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ���������� ����Ѵ�.)
select professor_name as "�����̸�", 
    case when extract(month from sysdate) <= substr(professor_ssn,3,2) then 2023-(substr(professor_ssn,1,2)+1900)
        when extract(month from sysdate) > substr(professor_ssn,3,2) then 2023-(substr(professor_ssn,1,2)+1900-1)
        end as "����"
    from tb_professor
        order by 2;

--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--��� ����� '�̸�' �� �������� �Ѵ�. (���� 2���� ���� ������ ���ٰ� �����Ͻÿ�)
select substr(professor_name,2) as "�̸�"
    from tb_professor;

--5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? 
--�̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
select student_no, student_name, student_ssn
    from tb_student
        where (case when student_no like 'A%' then 100+substr(entrance_date,1,2)-(substr(student_ssn,1,2))
        else substr(entrance_date,1,2)-(substr(student_ssn,1,2)) end) > 19;

--6. 2020 �� ũ���������� ���� �����ΰ�?
select to_char(to_date(20201225, 'yyyymmdd'), 'dy') as "2020�� ũ��������"
    from dual;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�? 
--�� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?
--TO_DATE('99/10/11','YY/MM/DD') - 1999�� 10�� 11�� / TO_DATE('49/10/11','YY/MM/DD') - 1949�� 10�� 11��
--TO_DATE('99/10/11','RR/MM/DD') - 1999�� 10�� 11�� / TO_DATE('49/10/11','RR/MM/DD') - 2049�� 10�� 11��

--8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 
--2000 �⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
select student_no, student_name
    from tb_student
        where student_no not like 'A%';


select * from tb_class;
select * from tb_department;
select * from tb_professor;
select * from tb_class_professor;
select * from tb_student;
select * from tb_grade;

--9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�.
select round(avg(point),1) as "����"
    from tb_student
        join tb_grade using (student_no)
            where student_no = 'A517178';

--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� �����
--������� ��µǵ��� �Ͻÿ�.
select department_no as "�а���ȣ", count(*) as "�л���(��)"
    from tb_student
        group by department_no
            order by 1;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
select count(*)
    from tb_student
        where coach_professor_no is null;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--�Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
select substr(term_no,1,4) as "�⵵", round(avg(point),1) as "�⵵ �� ����"
    from tb_student
        join tb_grade using (student_no)
            where student_no = 'A112113'
                group by substr(term_no,1,4);

--13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
select department_no as "�а��ڵ��", count(*) as "���л� ��"
    from tb_student
        where absence_yn='Y'
            group by department_no
                order by 1;

--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. 
--� SQL ������ ����ϸ� �����ϰڴ°�?
select student_name as "�����̸�", count(*) as "������ ��"
    from tb_student
        group by student_name
            having count(student_name) > 1
                order by 1;

--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ����, 
--�� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
--(��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
select "�⵵", "�б�", "����"
from(
    select substr(term_no,1,4) as "�⵵", substr(term_no,5,2) as "�б�", round(avg(point),1) as "����"
        from tb_student
            join tb_grade using (student_no)
            where student_no = 'A112113'
                group by term_no
    
    union all
    
    select substr(term_no,1,4) as "�⵵",' ' as "�б�", round(avg(point),1) as "����"
        from tb_student
            join tb_grade using (student_no)
            where student_no = 'A112113'
                group by substr(term_no,1,4)
    
                    
    union all
    
    select ' ' as "�⵵", ' ' as "�б�", round(avg(point),1) as "����"
        from tb_student
            join tb_grade using (student_no)
            where student_no = 'A112113'
    )

    order by 
        case when "�⵵" = ' ' then 1 else 0 end, "�⵵", 
        case when "�б�" = ' ' then 1 else 0 end, "�б�";
