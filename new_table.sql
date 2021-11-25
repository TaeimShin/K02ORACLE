/*
--테이블생성
create table tb_kosmo (
  idx number primary key,
  user_id varchar2(30) not null,
  user_pw varchar2(50) not null,
  user_name varchar2(50),
  postdate date default sysdate
)
/
*/

/*
create sequence seq_kosmo
  increment by 1
  start with 1
  minvalue 1
  nomaxvalue
  nocycle
  nocache
/
*/

insert into tb_kosmo values
  (seq_kosmo.nextval, 'gasan1', '1111', 'digital', sysdate)
/


