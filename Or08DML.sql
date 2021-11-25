/********************************
파일명 : Or08DML.sql
DML : Data Manipulation Language(데이터 조작어)
설명 : 레코드를 조작할때 사용하는 쿼리문. 앞에서 학습했던
     select문을 비롯하여 update(레코드수정), delete(레코드삭제),
     insert(레코드입력)가 있다.
*********************************/     

--study계정에서 실습합니다. 

/*
레코드 입력하기 : insert 
    레코드 입력을 위한 쿼리로 문자형은 반드시 ' 로 감싸야한다. 
    숫자형은 ' 없이 그냥 쓰면된다. 만약 숫자형을 ' 로 감사게되면
    자동으로 형변환되어 입력된다. 
*/
--실습을 위한 테이블 생성
create table tb_sample (
    dept_no number(10),
    dept_name varchar2(20),
    dept_loc varchar2(15),
    dept_manager varchar2(30)
);
desc tb_sample;
--방식1을 통한 레코드 입력
insert into tb_sample (dept_no, dept_name, dept_loc, dept_manager)
    values (10, '기획실', '서울', '나연');
insert into tb_sample (dept_no, dept_name, dept_loc, dept_manager)
    values (20, '전산팀', '수원', '쯔위');
--방식2
insert into tb_sample values (30, '영업팀', '대구', '모모');
insert into tb_sample values (40, '인사팀', '부산', '지효');

select * from tb_sample;

/*
    지금까지의 작업(트랜잭션)을 그대로 유지하겠다는 명령으로 커밋을
    수행하지 않으면 외부에서는 변경된 레코드를 확인할 수 없다. 
    여기서 말하는 외부란 Java/JSP와 같은 Oracle이외의 프로그램을 말한다. 
    ※ 트랜잭션이란 송금과 같은 하나의 단위작업을 말한다.
*/
commit;

--커밋 이후 새로운 레코드를 삽입하면 임시테이블에 저장된다. 
insert into tb_sample values (50, '금융팀', '제주', '아이린');
--오라클에서 확인하면 실제 삽입된것처럼 보인다. 하지만 실제 반영되지 않은 상태이다.
select * from tb_sample;
--롤백 명령으로 마지막 커밋 상태로 되돌릴 수 있다. 
rollback;
--마지막에 입력했던 아이린 레코드는 사라진다. 
select * from tb_sample;
/*
    rollback명령은 마지막 커밋 상태로 되돌려준다. 
    즉, commit한 이전의 상태로는 rollback할 수 없다. 
*/

/*
레코드 수정하기 : update
    형식] 
        update 테이블명
        set 컬럼1=값1, 컬럼2=값2, .....
        where 조건;
    ※조건이 없는경우 모든 레코드가 한꺼번에 수정된다. 
    ※테이블명 앞에 from이 들어가지 않는다. 
*/
--부서번호 40인 레코드의 지역을 미국으로 수정하시오.
update tb_sample set dept_loc='미국' where dept_no=40;
select * from tb_sample;
--지역이 서울인 레코드의 메니저명을 '박진영'으로 수정하시오.
update tb_sample set dept_manager='박진영' where dept_loc='서울';
select * from tb_sample;
--where절 없이 모든 레코드를 대상으로 지역을 '가산디지털'로 변경하시오.
update tb_sample set dept_loc='가산디지털';
select * from tb_sample;

/*
레코드 삭제하기 : delete
    형식]     
        delete from 테이블명 where 조건;
        ※레코드를 삭제하므로 delete 뒤에 컬럼을 명시하지 않는다.   
*/
--부서번호가 10인 레코드를 삭제하시오
delete from tb_sample where dept_no=10;
--update와 마찬가지로 where절이 없으면 모든 레코드가 삭제된다.(주의요망)
delete from tb_sample;
select * from tb_sample;

--마지막으로 커밋했던 지점으로 되돌린다. 
rollback;
select * from tb_sample;


/*
DML문 : 레코드를 입력 및 조작하는 쿼리문
    레코드입력 : insert into 테이블명 (컬럼) values (값)
    레코드수정 : update 테이블명 set 컬럼=값 where 조건
    레코드삭제 : delete from 테이블명 where 조건
    레코드조회 : select 컬럼 from 테이블명 where 조건
*/




--------------------------------------------------------
---------------DML 연습문제 ----------------------------
--------------------------------------------------------
/*
1. DDL문 연습문제 2번에서 만든 “pr_emp” 테이블에 다음과 같이 레코드를 
삽입하시오.
*/
insert into pr_emp values (1, '엄태웅', '어른승민', to_date('1975-11-21'));
insert into pr_emp values (2, '이제훈', '대학생 승민', to_date('1978-07-23'));
insert into pr_emp (eno, ename, job, regist_date)
    values (3, '한가인', '어른 서연', to_date('1982-10-24'));
insert into pr_emp (eno, ename, job, regist_date)
    values (4, '배수지', '대학생 서연', to_date('1988-05-21'));


 /*
2. 위 테이블에 다음 조건에 맞는 레코드를 삽입하시오.
등록날짜 : to_date함수를 이용해서 현재날짜 기준으로 7일전날짜 입력
*/
insert into pr_emp (eno, ename, job, regist_date)
    values (5, '조정석', '납뜩이', to_date(sysdate-7, 'yy/mm/dd'));
select * from pr_emp;    


/*
3. pr_emp 테이블의 eno가 짝수인 레코드를 찾아서 job 컬럼의 내용을 다음과 같이 변경하시오.
*/
update pr_emp set job=job||'(짝수)' where mod(eno,2)=0;
select * from pr_emp;

/*
4. pr_emp 테이블에서 job 이 대학생인 레코드를 찾아 이름만 삭제하시오. 
레코드는 삭제되면 안됩니다.
*/
select * from pr_emp where job like '%대학생%';
update pr_emp set ename='' where job like '%대학생%';
select * from pr_emp;

/*
5.  pr_emp 테이블에서 등록일이 10월인 모든 레코드를 삭제하시오.
*/
select * from pr_emp where to_char(regist_date, 'mm')='10';
delete from pr_emp where to_char(regist_date, 'mm')='10';
select * from pr_emp;
 


/*
6. pr_emp 테이블을 복사해서 pr_emp_clone 테이블을 생성하되 다음 조건에 따르시오. 
조건1 : 기존의 컬럼명을 idx, name, nickname, regidate 와같이 변경해서 복사한다. 
조건2 : 레코드까지 모두 복사한다. 
*/
create table pr_emp_clone (
    idx, name, nickname, regidate
)
as
select * from pr_emp where 1=1;
desc pr_emp_clone;    
select * from pr_emp_clone;


/*
7. 6번에서 복사한 pr_emp_clone 테이블명을 pr_emp_rename 으로 변경하시오.
*/
--형식 :  rename  원본테이블명 to 변경할테이블명;
rename pr_emp_clone to pr_emp_rename;
desc pr_emp_clone;
desc pr_emp_rename;
select * from pr_emp_rename;


/*
8. pr_emp_rename 테이블을 삭제하시오
*/
drop table pr_emp_rename;






