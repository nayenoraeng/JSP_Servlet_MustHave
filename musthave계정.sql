--������ ����� ���� system���� ����
-- 11g�� ���ص���
alter session set "_ORACLE_SCRIPT"=true;

create user musthave identified by 1234;

--���� �ο�
grant connect, resource, unlimited tablespace to musthave;

--���̺� �����̽� ��ȸ Ȯ��
select tablespace_name, status, contents from dba_tablespaces;

--���̺� �����̽��� ���� ���� Ȯ��
select tablespace_name, sum(bytes), max(bytes) from dba_free_space
    group by tablespace_name;
    
--���� ������ ��� ���̺� �����̽��� ����ִ��� Ȯ��
select username, default_tablespace from dba_users
    where username in upper('musthave');
    
--musthave������ user���̺� �����̽��� �����͸� �Է��Ҽ� �ֵ���
--5m �� �뷮�� �Ҵ�
alter user musthave QUOTA 5m on users;

--musthave ����
--���̺� ��� ��ȸ
select * from tab;

drop table member;
drop table board;
drop table seq_board_num;

--ȸ�����̺� �����
create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key(id)
);

--�� 1 ����� �Խ��� ���̺� �����
create table board (
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);

--�ܷ�Ű ����
alter table board
    add constraint board_mem_fk foreign key (id)
    references member (id);
    
--������ ����
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- ���� ������ �Է� (�ּ�10������ �̻�)
-- �Ʒ��� ���� �Է��ϸ� ������ => ���Ἲ �������� �����
--insert into board (num, title, content, id, postdate, visitcount)
--    value (seq_board_num.nextval, '����1�Դϴ�', '����1�Դϴ�', 'musthave',
--sysdate, 0);

insert into member (id, pass, name) values ('musthave', '1234', '�ӽ�Ʈ�غ�');

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '����1�Դϴ�', '����1�Դϴ�', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ ���Դϴ�', '���ǿ���', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ �����Դϴ�', '�������', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ �����Դϴ�', '������ȭ', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ �ܿ��Դϴ�', '�ܿ￬��', 'musthave',
sysdate, 0);
commit;
desc member;

select * from member;
select id, pass, rownum from member;

select * from board;
select * from member;
select id, pass, rownum from member;

select * from board order by num DESC; --num�� �Էµ� ���� ��Ȯ���� �ʴ� ���̺� ������

select * 
 from ( select Tb.*, rownum rNum 
     from (select * from board order by num DESC) Tb)
 where rNum between 1 and 10;