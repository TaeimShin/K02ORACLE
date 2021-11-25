/******************
파일명 : 12Sequence&Index.sql
시퀀스 & 인덱스
설명 : 테이블의 기본키 필드에 순차적인 일련번호를 부여하는 시퀀스와
    검색속도를 향상시킬수 있는 인덱스 
******************/

--study 계정에서 학습합니다. 

/*
시퀀스
-테이블의 컬럼(필드)에 중복되지 않는 순차적인 일련번호를 부여한다. 
-시퀀스는 테이블 생성후 별도로 만들어야 한다. 즉 시퀀스는 테이블과
    독립적으로 저장되고 생성된다. 

[시퀀스 생성구문]    
create sequence 시퀀스명
    [Increment by N]    -> 증가치설정
    [Start with N]      -> 시작값지정
    [Minvalue n | NoMinvalue]   -> 시퀀스 최소값 지정 : 디폴트1
    [Maxvalue n | NoMaxvalue]   -> 시퀀스 최대값 지정 : 디폴트1.0000E+28
    [Cycle | NoCycle] -> 최대/최소값에 도달할 경우 처음부터 다시
                        시작할지 여부를 설정(cycle로 지정하면 최대값까지
                        증가후 다시 시작값부터 재 시작됨)
    [Cache | NoCache] -> cache 메모리에 오라클서버가 시퀀스값을
                        할당하는가 여부를 지정

주의사항
1. start with 에 minvalue보다 작은값을 지정할 수 없다. 즉 start with값은
    minvalue와 같거나 커야한다. 
2. nocycle 로 설정하고 시퀀스를 계속 얻어올때 maxvalue에 지정값을 초과하면
    에러가 발생한다. 
3. primary key에 cycle옵션은 절대 지정하면 안된다. 
*/


--제품정보를 입력할 테이블 생성
create table tb_goods (
    g_idx number(10) primary key,   /* 상품의 일련번호 */
    g_name varchar2(30)             /* 상품명 */
);
insert into tb_goods values (1, '초콜렛');
insert into tb_goods values (1, '새우깡');

--시퀀스 생성하기
create sequence seq_serial_num
    increment by 1      /* 증가치 : 1로 지정 */
    start with 100      /* 초기값 : 100부터 시작함 */
    minvalue 99         /* 최소값 : 99로 지정 */
    maxvalue 110        /* 최대값 : 110으로 지정 */
    cycle               /* 최대값 도달시 시작값부터 재 시작할지 여부 : yes */
    nocache;            /* 캐시사용여부 : no */

/*
    시쿼스 생성 후 최초실행시에는 오류가 발생된다. nextval을 먼저 
    실행한 후 실행해야 문제없이 출력된다. 
    마지막에 출력된 시퀀스가 출력된다. 
*/
select seq_serial_num.currval from dual;
/*
    다음 입력할 일련번호(시퀀스)를 반환한다. 실행할때마다 다음으로
    넘어간다. 
*/
select seq_serial_num.nextval from dual;

insert into tb_goods values (seq_serial_num.nextval, '초콜렛1');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛2');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛3');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛4');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛5');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛6');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛7');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛8');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛9');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛10');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛11');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛12');
insert into tb_goods values (seq_serial_num.nextval, '초콜렛13');/*
            시퀀스의 cycle옵션에 의해 최대값에 도달하면 다시 처음부터 
            일련번호가 생성되므로 무결성 제약조건에 위배된다. 즉 기본키에
            사용할 시퀀스는 cycle옵션을 사용하지 않아야 한다. 
        */

select * from tb_goods;

--시퀀스 정보를 저장한 데이터 사전
select * from user_sequences where sequence_name=upper('seq_serial_num');
/*
시퀀스 수정하기
alter sequence 시퀀스명
    increment by 증가값
    maxvalue N 혹은 minvalue N
    cycle | nocycle
    cache | nocache ;

start with 는 수정할 수 없다. 이미 생성된 시퀀스의 초기값은 수정할수 없다.    
*/
alter sequence seq_serial_num
    increment by 10
    nomaxvalue /* 시퀀스가 표현할 수 있는 최대치로 설정된다. */
    minvalue 1
    nocycle
    nocache;
select * from user_sequences where sequence_name=upper('seq_serial_num');
select seq_serial_num.nextval from dual;

--삭제하기
drop sequence seq_serial_num;

--일반적인 형태의 시퀀스 생성하기 
create sequence seq_serial_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
/*
    일반적으로 start with, increment, minvalue는 1로 설정하고
    나머지는 no로 설정한다. 
*/


/*
인덱스
-행의 검색속도를 향상시킬수 있는 개체
-인덱스는 명시적(create index) 과 자동적(primary key, unique)
    으로 생성할 수 있다. 
-컬럼에 대한 인덱스가 없으면 테이블 전체를 검색하게된다. 
-즉 인덱스는 쿼리의 성능을 향상시키는 것이 목적이다. 
-인덱스는 아래와 같은 경우에 설정한다. 
    1.where조건이나 join조건에 자주 사용하는 컬럼
    2.광범위한 값을 포함하는 컬럼
    3.많은 null값을 포함하는 컬럼
*/
--인덱스 생성하기
/*
    tb_goods 테이블의 g_name 컬럼에 인덱스를 생성한다. 
    인덱스명은 tb_goods_name_idx 으로 지정한다.
*/
create index tb_goods_name_idx on tb_goods (g_name);

/*
    PK로 지정된 컬럼은 자동으로 인덱스가 생성된다. 
    개발자가 직접 지정하는 인덱스는 '명시적 인덱스'라고 표현한다. 
*/
select * from user_ind_columns 
    where table_name=upper('tb_goods');

--인덱스 삭제
drop index tb_goods_name_idx;

--인덱스 수정 : 인덱스는 수정이 불가능하다. 따라서 삭제후 다시 생성해야 한다.



