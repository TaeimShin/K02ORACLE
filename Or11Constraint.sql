/*
파일명 : Or11Constraint.sql
제약조건
설명 : 테이블 생성시 필요한 여러가지 제약조건에 대해 학습한다.
*/
--study 계정에서 실습합니다. 

/*
primary key : 기본키
-참조무결성을 유지하기 위한 제약조건으로
-하나의 테이블에 하나의 기본키만 설정할 수 있다. 
-기본키로 설정된 컬럼은 중복된값이나 Null값을 입력할 수 없다. 
-주로 레코드 하나를 특정하기 위해 사용된다. 
*/

/*
형식1] 인라인 방식
    create table 테이블명 (
        컬럼명 자료형 [constraint PK제약명] primary key
    );
*/
create table tb_primary1 (
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
);
desc tb_primary1;

/*
제약조건 확인하기
    user_cons_columns : 테이블에 지정된 제약조건명과 컬럼명의
        간략한 정보를 확인할 수 있다.     
    user_constraints : 테이블에 지정된 제약조건의 상세한 정보를
        확인할 수 있다. 
    ※ 이와같이 제약조건이나 뷰, 프로시저등의 정보를 저장하고 있는
    시스템 테이블을 "데이터사전"이라고 한다.
*/
select * from tab;
select * from user_cons_columns;
select * from user_constraints;

--레코드 입력
insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'kosmo', '코스모');
insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'smo', '스모');/*
         무결성 제약조건 위배로 에러가 발생한다. PK로 지정된 
         컬럼 idx에는 중복된 값을 입력할 수 없다.
    */
insert into tb_primary1 values (2, 'black', '블랙');
insert into tb_primary1 values ('', 'white', '화이트');/*
        pk로 지정된 컬럼에는 null값을 입력할 수 없다. 
    */

select * from tb_primary1;
update tb_primary1 set idx=2 where user_name='코스모';/*
        update문은 정상이지만 idx값이 이미 존재하는 2로
        변경했으므로 제약조건 위배로 오류발생
    */

/*
형식2] 아웃라인 방식
    create table 테이블명 (
        컬럼명 자료형, 
        [constraint 제약명] primary key (컬럼명)
    );    
*/
create table tb_primary2 (
    idx number(10),
    user_id varchar2(30),
    user_name varchar2(50),
    
    primary key (user_id)
);
desc tb_primary2;
select * from user_constraints;

/*
형식3] 테이블 생성후 alter문으로 제약조건 추가
    alter table 테이블명 add [constraint 제약명] primary key (컬럼명);
*/
create table tb_primary3 (
    idx number(10),
    user_id varchar2(30),
    user_name varchar2(50)
);
desc tb_primary3;
--테이블을 생성한 후 alter명령을 통해 제약조건을 부여할 수 있다. 
alter table tb_primary3 add constraint tb_primary3_pk 
    primary key (user_name);--제약명을 부여하면 오류발생시 해당 이름을 통해 확인할수있다.
desc tb_primary3;
select * from user_constraints;
--테이블을 삭제하면 제약조건도 같이 삭제된다.     
drop table tb_primary3;    
select * from user_constraints;


/*
unique : 유니크
-값의 중복을 허용하지 않는 제약조건으로
-숫자, 문자는 중복을 허용하지 않는다. 
-하지만 null값에 대해서는 중복을 허용한다. 
-unique는 한 테이블에 2개이상 적용할 수 있다. 
*/
create table tb_unique (
    idx number unique not null,
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    
    unique(telephone, nickname)
);
select * from user_cons_columns;
select * from user_constraints;

insert into tb_unique (idx, name, telephone, nickname)
    values (1, '아이린', '010-1111-1111', '레드벨벳');
insert into tb_unique (idx, name, telephone, nickname)
    values (2, '웬디', '010-2222-2222', '');
insert into tb_unique (idx, name, telephone, nickname)
    values (3, '슬기', '', '');    
select * from tb_unique;

insert into tb_unique (idx, name, telephone, nickname)
    values (1, '예리', '010-3333-3333', '');--에러. 중복된 idx값 존재함.

insert into tb_unique values (4, '정우성', '010-4444-4444', '영화배우');
insert into tb_unique values (5, '이정재', '010-5555-5555', '영화배우');--입력성공
insert into tb_unique values (6, '황정민', '010-4444-4444', '영화배우');--입력실패
/*
    telephone과 nickname 컬럼이 동일한 제약명으로 설정되었으므로
    두개의 컬럼이 동시에 동일한 값을 가지는 경우가 아니라면 중복된값이
    허용된다. 
    즉, 4번과 5번은 서로 다른 데이터로 인식하므로 입력되고, 
    4번과 6번은 동일한 데이터로 인식되어 에러가 발생한다. 
*/


/*
Foreign key : 외래키, 참조키
-외래키는 참조무결성을 유지하기 위한 제약조건으로
-만약 테이블간에 외래키가 설정되어 있다면 자식테이블에 참조값이
    존재할 경우 부모테이블의 레코드는 삭제할 수 없다. 

형식1] 인라인방식
    create table 테이블명 (
        컬럼명 자료형 [constraint 제약명] 
            references 부모테이블명 (참조할 컬럼명)                    
    );    
*/
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    /* 자식테이블인 tb_foreign1에서 부모테이블인 tb_primary2의
        user_id를 참조하는 외래키를 생성함. */
    f_id varchar2(30) constraint tb_foreign_fk1
        references tb_primary2 (user_id)
);
--부모테이블에 레코드가 전혀 없는 상태임
select * from tb_primary2;
--부모테이블에 참조할 레코드가 없으므로 자식테이블에 입력불가
insert into tb_foreign1 values (1, '워너원', 'WannerOne');--에러발생
--부모테이블에 새로운 레코드 삽입
insert into tb_primary2 values (1, 'BTS', '방탄소년단');
--부모테이블의 레코드를 기반으로 자식테이블에 레코드 삽입
insert into tb_foreign1 values (1, '방탄조아요', 'BTS');
--부모키가 없으므로 입력불가
insert into tb_foreign1 values (2, '트와이스조아요', 'Twice');--에러발생

select * from tb_primary2;
select * from tb_foreign1;

/*
    자식테이블에서 참조하는 레코드가 있으므로, 부모테이블의 레코드를
    삭제할 수 없다. 이경우에는 반드시 자식테이블의 레코드를 먼저 
    삭제한 후 부모테이블의 레코드를 삭제해야한다.
*/
delete from tb_primary2 where idx=1;--에러발생

--자식테이블의 레코드를 먼저 삭제한 후
delete from tb_foreign1 where f_idx=1;
--부모테이블의 레코드를 삭제할 수 있다. 
delete from tb_primary2 where idx=1;

select * from tb_primary2;
select * from tb_foreign1;

/*
형식2] 아웃라인방식
    create table 테이블명 (
        컬럼명 자료형 ,         
        [constraint 제약명] foreign key (컬럼명)
            references 부모테이블 (참조할컬럼)
    )
*/
create table tb_foreign2 (
    f_id number primary key,
    f_name varchar2(30),
    f_date date,
    
    foreign key (f_id) references tb_primary1(idx)
);
select * from user_constraints;
/*
데이터 사전에서 제약조건 확인시 플레그
P : Primary key
R : Reference integrity 즉 Foreign key를 뜻함
C : Check 혹은 Not null
U : Unique
*/

/*
형식3] 테이블 생성후 alter문으로 제약조건 추가
    alter table 테이블명 add [constraint 제약명] 
        foreign key (컬럼명) 
            references 부모테이블 (참조컬럼명);
*/
create table tb_foreign3 (
    idx number primary key,
    f_name varchar2(30),
    f_idx number(10)
);
alter table tb_foreign3 add
    foreign key (f_idx) references tb_primary1 (idx);
/*
    하나의 부모테이블에 둘 이상의 자식테이블이 외래키를 
    설정할 수 있다. 
*/    

/*
외래키 삭제시 옵션
[on delete cascade] 
    : 부모레코드 삭제시 자식레코드까지 같이 삭제됨
    형식]
        컬럼명 자료형 references 부모테이블(pk컬럼)
            on delete cascade;
[on delete set null]
    : 부모레코드 삭제시 자식레코드 값이 null로 변경됨
    형식]  
        컬럼명 자료형 references 부모테이블(pk컬럼)
            on delete set null
※ 실무에서 스팸게시물을 남긴 회원과 그 게시글을 일괄적으로 삭제해야할때
사용할 수 있는 옵션이다. 단, 자식테이블의 모든 레코드가 삭제되므로 사용에
주의해야한다. 
*/
create table tb_primary4 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
);
create table tb_foreign4 (
    f_idx number(10) primary key,
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign4_fk
        references tb_primary4 (user_id)
            on delete cascade
);
insert into tb_primary4 values ('kosmo', '코스모');--항상 부모테이블에 먼저 레코드를 입력한다. 
insert into tb_foreign4 values (1, '스팸1입니다', 'kosmo');--그 후 자식테이블에 입력한다.
insert into tb_foreign4 values (2, '스팸3입니다', 'kosmo');
insert into tb_foreign4 values (3, '스팸3입니다', 'kosmo');
insert into tb_foreign4 values (4, '스팸4입니다', 'kosmo');
insert into tb_foreign4 values (5, '스팸5입니다', 'kosmo');
insert into tb_foreign4 values (6, '스팸6입니다', 'kosmo');
insert into tb_foreign4 values (7, '스팸7입니다', 'kosmo');
insert into tb_foreign4 values (8, '난..어쯔??', 'gasan');--부모키가 없으므로 에러발생

select * from tb_primary4;
select * from tb_foreign4;--삽입된 레코드가 있는걸을 확인함.

delete from tb_primary4;/*
                        부모테이블에서 레코드를 삭제할 시 on delete cascade 옵션때문에
                        부모쪽뿐만 아니라 자식쪽에서도 모든 레코드가 삭제된다. 
                    */
select * from tb_primary4;
select * from tb_foreign4;--모든 레코드 삭제됨


--on delete set null 옵션 테스트
create table tb_primary5 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
);
create table tb_foreign5 (
    f_idx number(10) primary key,
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign5_fk
        references tb_primary5 (user_id)
            on delete set null
);
insert into tb_primary5 values ('kosmo', '코스모');
insert into tb_foreign5 values (1, '스팸1입니다', 'kosmo');
insert into tb_foreign5 values (2, '스팸3입니다', 'kosmo');
insert into tb_foreign5 values (3, '스팸3입니다', 'kosmo');
insert into tb_foreign5 values (4, '스팸4입니다', 'kosmo');
insert into tb_foreign5 values (5, '스팸5입니다', 'kosmo');
insert into tb_foreign5 values (6, '스팸6입니다', 'kosmo');
insert into tb_foreign5 values (7, '스팸7입니다', 'kosmo');

select * from tb_primary5;
select * from tb_foreign5;

/*
on delete set null 옵션으로 자식테이블의 레코드는 삭제되지는 
않고, 참조키 부분만 null값으로 변경되어, 더이상 참조할 수 없는
레코드로 변경된다. 
*/
delete from tb_primary5 where user_id='kosmo';

select * from tb_primary5;
select * from tb_foreign5;


/*
not null : null값을 허용하지 않는 제약조건
    형식]
        create table 테이블명 (
            컬럼명 자료형 not null, 
            컬럼명 자료형 null <- null을 허용한다는 의미로 작성했지만
                                이렇게 사용하지 않는다. null을 기술하지 
                                않으면 자동으로 허용한다는 의미가 된다. 
        );
*/
create table tb_not_null (
    m_idx number(10) primary key,   -- PK이므로 NN
    m_id varchar2(30) not null,     -- NN
    m_pw varchar2(20) null,         -- null허용(일반적으로 이렇게 쓰지 않는다)
    m_name varchar2(50)             -- null허용(이와 같이 선언한다)
);
desc tb_not_null;

insert into tb_not_null values (10, 'hong1', '1111', '홍길동');
insert into tb_not_null values (20, 'hong2', '2222', '');
insert into tb_not_null values (30, 'hong3', '', '');
insert into tb_not_null values (40, '', '', '');--오류발생. null을 입력할 수 없음.
insert into tb_not_null (m_id, m_pw, m_name) 
    values ('hong5', '5555', '오길동');--오류발생. PK에는 null을 입력할 수 없음.
insert into tb_not_null values (60, ' ', '6666', '육길동');--입력성공. space도 문자임.

select * from tb_not_null;

/*
default : insert 시 아무런 값도 입력하지 않았을때 자동으로 삽입되는
    데이터를 지정한다. 
*/
create table tb_default (
    id varchar2(30) not null,
    pw varchar2(50) default 'qwer'
);
desc tb_default;
select * from tb_default;
insert into tb_default values ('aaaa', '1234'); --1234입력됨
insert into tb_default (id) values ('bbbb');    --컬럼 자체가 없으므로 default값 입력
insert into tb_default values ('cccc', '');     --null값이 입력됨
insert into tb_default values ('dddd', ' ');    --공백(space)이 입력됨
insert into tb_default values ('eeee', default);--default값 입력됨.
/*
    위에서 보듯이 default 값을 입력하려면 insert시 컬럼자체를 
    제외하거나, default 키워드를 사용해야 한다. 
*/


/*
check : Domain(자료형) 무결성을 유지하기 위한 제약조건으로 
    해당 컬럼에 잘못된 데이터가 입력되지 않도록 유지하는 제약조건이다. 
*/
create table tb_check1 (
    gender char(1) not null
        constraint check_gender
            check (gender in ('M','F'))
);
insert into tb_check1 values ('M');
insert into tb_check1 values ('F');
insert into tb_check1 values ('A');--입력실패
insert into tb_check1 values ('여성');--입력실패

create table tb_check2 (
    sale_count number not null
        check (sale_count <= 10)
);
insert into tb_check2 values (9);
insert into tb_check2 values (10);
insert into tb_check2 values (11);--입력실패



--------------------------------------------------------
--------------- Constraint 연 습 문 제 ----------------- 
--------------------------------------------------------
--scott계정에서 진행합니다.

/*
1. emp 테이블의 구조를 복사하여 pr_emp_const 테이블을 만드시오. 
복사된 테이블의 사원번호 칼럼에 pr_emp_pk 라는 이름으로 primary key 
제약조건을 지정하시오.
*/
--복사
create table pr_emp_const
as
select * from emp where 1=2;
--테이블 구조 확인
desc pr_emp_const;
--PK지정하기
alter table pr_emp_const
    add constraint pr_emp_pk primary key (empno);
--데이터사전에서 확인하기
select * from user_cons_columns where constraint_name=upper('pr_emp_pk');
select * from user_constraints where lower(constraint_name)='pr_emp_pk';


/*
2. dept 테이블의 구조를 복사해서 pr_dept_const 테이블을 만드시오. 
부서번호에 pr_dept_pk 라는 제약조건명으로 primary_key를 생성하시오.
*/
create table pr_dept_const
as 
select * from dept where 1=0;

alter table pr_dept_const add constraint pr_dept_pk primary key (deptno);

select * from user_constraints where lower(constraint_name)='pr_dept_pk';

/*
3. pr_dept_const 테이블에 존재하지 않는 부서의 사원이 배정되지 않도록 
외래키 제약조건을 지정하되 제약조건 이름은 pr_emp_dept_fk 로 지정하시오.
*/
alter table pr_emp_const    /* 외래키는 자식테이블에서 생성한다. */
    add constraint pr_emp_dept_fk /* 제약조건명 추가 */
    foreign key (deptno) /* 자식테이블의 외래키(참조키) 컬럼 지정 */
    references pr_dept_const (deptno); /* 부모테이블의 기본키(pk) 컬럼 지정 */


/*
4. pr_emp_const 테이블의 comm 칼럼에 0보다 큰 값만을 입력할수 있도록 
제약조건을 지정하시오. 제약조건명은 지정하지 않아도 된다
*/
alter table pr_emp_const add
    /* constraint 제약명 => 제약명은 생략가능. */
    check (comm > 0);

insert into pr_emp_const values
    (100, '아무개', '열정', null, sysdate, 1000, 0.5, 10);--입력실패:부모키없음
insert into pr_emp_const values
    (200, '머시기', '냉정', null, sysdate, 2000, 0, 10);--입력실패:check제약조건위배

--부모테이블에 레코드 입력
insert into pr_dept_const values (10, '꿈의방', '가산');
insert into pr_dept_const values (20, '열정의방', '디지털');
--앞에서 입력실패한 레코드 입력
insert into pr_emp_const values
    (100, '아무개', '열정', null, sysdate, 1000, 0.5, 10);
insert into pr_emp_const values
    (200, '머시기', '냉정', null, sysdate, 2000, 0.34, 10);

select * from pr_dept_const;   
select * from pr_emp_const;   


/*
5. 위 3번에서는 두 테이블간에 외래키가 설정되어서 pr_dept_const 테이블에서 
레코드를 삭제할 수 없었다. 
이 경우 부모 레코드를 삭제할 경우 자식까지 같이 삭제될수 있도록 
외래키를 지정하시오.
*/
--부모테이블
select * from pr_dept_const;   
--자식테이블
select * from pr_emp_const;   
--자식 레코드가 있는 상태에서 부모 레코드 삭제하기
delete from pr_dept_const; --자식 레코드가 있으므로 삭제불가. 외래키 제약조건 위배.

--외래키 제약조건을 재설정하기 위해 기존의 제약조건 삭제
alter table pr_emp_const drop constraint pr_emp_dept_fk;
--외래키 재설정 : 부모레코드 삭제시 자식레코드까지 동시에 삭제되도록 설정
alter table pr_emp_const
    add constraint pr_emp_dept_fk
    foreign key (deptno)
    references pr_dept_const (deptno)
    on delete cascade ;

delete from pr_dept_const; --자식레코드까지 모두 삭제됨

select * from pr_dept_const;   
select * from pr_emp_const;  --테이블 확인

commit;
