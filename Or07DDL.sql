/***********************
파일명 : Or07DDL.sql
DDL : Data Definition Language(데이터 정의어)
설명 : 테이블, 뷰와 같은 객체를 생성 및 변경하는 쿼리문을 말한다.
***********************/

/*
system계정으로 연결한 후 아래 명령을 실행한다. 
새로운 계정을 생성한 후 접속권한과 테이블생성권한 몇가지를 부여한다. 
*/
create user study identified by 1234;--study계정을 생성한다.
grant connect, resource to study;--생성한 계정에 권한을 부여한다. 

-------------------------------------------------------------------------
--study계정을 연결한 후 실습을 진행합니다. 
select * from dual;
select * from tab;

/*
테이블생성
형식]     
    create table 테이블명 (
        컬럼1 자료형, 
        컬럼2 자료형
        ....
        primary key (컬럼명) 등 제약조건
    );
*/

create table tb_member (
    member_idx number(10),  --10자리의 정수 표현
    userid varchar2(30),
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2)     --실수표현. 전체7자리, 소수이하2자리
);
--현재 접속한 계정에 생성된 테이블의 목록을 확인
select * from tab;
--테이블의 구조를 확인. 컬럼명, 컬럼의 자료형, 제약조건 등을 확인할수있음.
desc tb_member;

/*
기존 생성된 테이블에 새로운 컬럼 추가하기
    -> tb_member 테이블에 email 컬럼을 추가하시오.
    
    형식] alter table 테이블명 add 추가할컬럼 자료형(크기) 제약조건;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
기존 생성된 테이블의 컬럼 수정하기
    -> tb_member 테이블의 email 컬럼의 사이즈를 200으로 확장하시오.
    또한 이름이 저장되는 username컬럼도 60으로 확장하시오
    
    형식] alter table 테이블명 modify 수정할컬럼명 자료형(크기);
*/
alter table tb_member modify email varchar2(200);
desc tb_member;
alter table tb_member modify username varchar2(60);
desc tb_member;


/*
기존 생성된 테이블에서 컬럼 삭제하기
    -> tb_member 테이블의 mileage 컬럼을 삭제하시오.
    
    형식] alter table 테이블명 drop column 삭제할컬럼명;
*/
alter table tb_member drop column mileage;
desc tb_member;

/*
테이블 삭제하기
    -> tb_member 테이블은 더 이상 사용하지 않으므로 삭제하시오
    
    형식] drop table 삭제할테이블명;
*/
drop table tb_member;
select * from tab;--빈 레코드 출력됨
desc tb_member;--오류발생


/*
퀴즈] 테이블 정의서로 작성한 employees테이블을 해당 study계정에 그대로
    생성하시오. 단, 제약조건은 명시하지 않습니다. 
*/
create table employees (
    employee_id number(6),
    first_name varchar2(20),
    last_name varchar2(25),
    email varchar2(25),
    phone_number varchar2(20),
    hire_date date,
    job_id varchar2(10),
    salary number(8,2),
    commission_pct number(2,2),
    manager_id number(6),
    department_id number(4)
);

--------------------------
--위에서 생성했던 tb_member 테이블을 다시 한번 생성한 후 진행합니다. 
select * from tab;

--새로운 레코드를 삽입하는 DML문(뒤에서 학습할 예정)
insert into tb_member values (1, 'hong', '1234', '홍길동', 10000);
insert into tb_member values (2, 'park', '9876', '박문수', 20000);
select * from tb_member;

--테이블을 레코드까지 복사하기
create table tb_member_copy
as
select * from tb_member;
--복사되었는지 확인하기
desc tb_member_copy;
select * from tb_member_copy;


--테이블을 레코드를 제외하고 구조만 복사하기
create table tb_member_copy2
as
select * from tb_member where 1=0;
--복사되었는지 확인하기
desc tb_member_copy2;
select * from tb_member_copy2;

/*
DDL문 : 테이블을 생성 및 조작하는 쿼리문
    테이블 생성 : create table 테이블명
    테이블 수정
        컬럼추가 : alter table 테이블명 add 컬럼명
        컬럼수정 : alter table 테이블명 modify 컬럼명
        컬럼삭제 : alter table 테이블명 drop column 컬럼명
    테이블 삭제 : drop table 테이블명
*/          



------------------------------------------
---연습문제

/*
1. 다음 조건에 맞는 “pr_dept” 테이블을 생성하시오.
*/
create table pr_dept (
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

/*
2. 다음 조건에 맞는 “pr_emp” 테이블을 생성하시오.
*/
create table pr_emp (
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
);

/*
3. pr_emp 테이블의 ename 컬럼을 varchar2(50) 로 수정하시오.
*/
desc pr_emp;
alter table pr_emp modify ename varchar2(50);
desc pr_emp;


/*
4. 1번에서 생성한 pr_dept 테이블에서 dname 칼럼을 삭제하시오.
*/
desc pr_dept;
alter table pr_dept drop column dname;
desc pr_dept;

/*
5. “pr_emp” 테이블의 job 컬럼을 varchar2(50) 으로 수정하시오.
*/
desc pr_emp;
alter table pr_emp modify job varchar2(50);
desc pr_emp;
















