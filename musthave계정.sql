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
 

--13�� ���Ͼ��ε�

DROP TABLE myfile;

create table myfile (
    idx number primary key,
    title varchar2(200) not null,
    cate varchar2(100),
    ofile varchar2(100) not null,
    sfile varchar2(30) not null,
    postdate date default sysdate not null
);

DESC myfile;

DELETE * FROM myfile;
SELECT * FROM myfile;

---14�� ��2 �Խ��� ����� 

drop table mvcboard;

create table mvcboard (
	idx number primary key, 
	name varchar2(50) not null, 
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 
	ofile varchar2(200), 
	sfile varchar2(30), 
	downcount number(5) default 0 not null, 
	pass varchar2(50) not null, 
	visitcount number default 0 not null
);
--���ƿ䵵 �湮ī��Ʈ�� ����ϰ� �ϸ� ��!!

desc mvcboard;

insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����1 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '�庸��', '�ڷ�� ����2 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '�̼���', '�ڷ�� ����3 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����4 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����5 �Դϴ�.','����','1234');
    
SELECT * from mvcboard;

commit;

