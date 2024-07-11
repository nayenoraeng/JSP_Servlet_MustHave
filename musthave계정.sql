--계정을 만들기 위해 system계정 접속
-- 11g는 안해도됨
alter session set "_ORACLE_SCRIPT"=true;

create user musthave identified by 1234;

--권한 부여
grant connect, resource, unlimited tablespace to musthave;

--테이블 스페이스 조회 확인
select tablespace_name, status, contents from dba_tablespaces;

--테이블 스페이스별 가용 공간 확인
select tablespace_name, sum(bytes), max(bytes) from dba_free_space
    group by tablespace_name;
    
--개인 계정이 어느 테이블 스페이스에 들어있는지 확인
select username, default_tablespace from dba_users
    where username in upper('musthave');
    
--musthave계정에 user테이블 스페이스에 데이터를 입력할수 있도록
--5m 의 용량을 할당
alter user musthave QUOTA 5m on users;

--musthave 계정
--테이블 목록 조회
select * from tab;

drop table member;
drop table board;
drop table seq_board_num;

--회원테이블 만들기
create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key(id)
);

--모델 1 방식의 게시판 테이블 만들기
create table board (
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);

--외래키 설정
alter table board
    add constraint board_mem_fk foreign key (id)
    references member (id);
    
--시퀀스 생성
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- 더미 데이터 입력 (최소10페이지 이상)
-- 아래를 먼저 입력하면 에러남 => 무결성 제약조건 위배됨
--insert into board (num, title, content, id, postdate, visitcount)
--    value (seq_board_num.nextval, '제목1입니다', '내용1입니다', 'musthave',
--sysdate, 0);

insert into member (id, pass, name) values ('musthave', '1234', '머스트해브');

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '제목1입니다', '내용1입니다', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 봄입니다', '봄의왈츠', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 여름입니다', '여름향기', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 가을입니다', '가을동화', 'musthave',
sysdate, 0);

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 겨울입니다', '겨울연가', 'musthave',
sysdate, 0);
commit;
desc member;

select * from member;
select id, pass, rownum from member;

select * from board;
select * from member;
select id, pass, rownum from member;

select * from board order by num DESC; --num에 입력된 것이 정확하지 않다 테이블 삭제함

select * 
 from ( select Tb.*, rownum rNum 
     from (select * from board order by num DESC) Tb)
 where rNum between 1 and 10;