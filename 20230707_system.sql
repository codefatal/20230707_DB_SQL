select * from user_tables;

-- �ּ�
-- ctrl + / �ּ���۸�
-- create ��ɾ� - DDL ������ ���Ǿ�
create user c##scott identified by tiger;
drop user c##scott;
-- 21g xe ���� , "_ORACLE_SCRIPT"=true; �� �������.
alter session set "_ORACLE_SCRIPT"=true;
create user kh identified by kh;
create user scott identified by tiger;
create user pyr98 identified by pyr98;

--����: ���� -�׽�Ʈ ����: ORA-01017: ����ڸ�/��й�ȣ�� ������, �α׿��� �� �����ϴ�.
--����: ���� -�׽�Ʈ ����: ORA-01045: ����� SCOTT�� CREATE SESSION ������ ���������� ����; �α׿��� �����Ǿ����ϴ�

-- DCL
-- create session, create table ó�� ������ ���Ѹ��� ��� �����Ͽ� ���� �����..
-- ���ѵ��� ��� ������ ��role �� ����Ͽ� ������ �ο���.
-- connect - ���Ӱ��� ���ѵ��� �ִ� role
-- resource - �ڿ�(table, view �� ��ü)���� ���ѵ��� �ִ� role
grant connect, resource to c##scott, kh;
grant connect, resource to kh;
revoke connect, resource from kh;
grant connect, resource to scott, kh;
-- 21g xe ���� , dba �߰�
grant connect, resource, dba to scott, kh;
grant connect, resource, dba to pyr98;