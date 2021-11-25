--JDBC실습용 문서

/*
JAVA에서 처음으로 JDBC 프로그래밍 해보기
*/
-- 우선 system계정으로 연결한 후 새로운 실습용 계정을 생성한다.
create user kosmo identified by 1234;
grant connect, resource to kosmo;


--여기서부터는 kosmo계정에서 실습합니다.
--회원관리 테이블
create table member(
    id varchar2(30) NOT NULL,
    pass varchar2(40) NOT NULL,
    name varchar2(50) NOT NULL,
    regidate date default sysdate,
    primary key(id)
);
--테이블 삭제하기(필요시에만)
drop table member;
--제약조건 확인을 위한 데이터사전
select * from user_constraints;

--더미데이터 입력하기 
insert into member(id,pass,name)values ('test','1234','테스트');
select * from member;
select to_char(regidate, 'yyyy-mm-dd hh24:mi:ss') "회원가입일" from member;

--게시판 테이블 생성
create table board(
    num number primary key, --게시물의 일련번호
    title varchar2(200) not null, --제목
    content varchar2(2000) not null, --내용
    id varchar2(30) not null, --작성자의 아이디 
    postdate date default sysdate not null,--작성일
    visitcount number default 0 not null --조회수
);

alter table board add constraint board_mem_fk
    foreign key (id) references member (id);

select * from user_constraints;
--제약조건 삭제하기 : 제약조건을 잘못 만든경우 수정이 안되므로 삭제후 재생성해야함.
alter table board drop constraint board_mem_fk;

create sequence seq_board_num
    increment by 1      
    start with 1      
    minvalue 1        
    nomaxvalue        
    nocycle              
    nocache;   
--시퀀스 삭제하기
drop sequence seq_board_num;
--시퀀스 확인을 위한 데이터 사전
select * from user_sequences;

select seq_board_num.nextval from dual;

insert into member(id,pass,name)values ('test91','9191','테스트91');

