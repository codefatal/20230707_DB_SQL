alter session set "_ORACLE_SCRIPT"=false;  
create user c##kh2 identified by kh2;
-- ���� create user kh2 identified by kh2;
create role c##role_scott_manager;
-- ���� create role role_scott_manager;

alter session set "_ORACLE_SCRIPT"=true;  
create user kh2 identified by kh2;
create role role_manager;

grant connect, resource to kh2;
-- connect -- ���̸�
-- ���ѵ��� ���� = ��
-- create session -- ���ӱ���
-- create table, alter table, drop table, create view, drop view, create sequence, alter sequence......
-- ���� space �� ����ϴ� ���ѵ� ��� resource �ѿ� ������.

grant create table,create view, connect, resource  to role_manager;
-- grant ���Ѹ�, ���Ѹ�,... �Ѹ�, �Ѹ�,...   to �Ѹ�, ����ڸ�, ... ;
grant role_manager to kh2;

revoke create view from role_manager;