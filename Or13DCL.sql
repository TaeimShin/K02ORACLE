/*******************************
파일명 : Or13DCL.sql
DCL : Data Control Language(데이터 제어어)
사용자권한
설명 : 새로운 사용자계정을 생성하고 시스템권한을 부여하는 방법을 학습
*******************************/

/*
[사용자계정 생성 및 권한설정]
해당 내용은 DBA권한이 있는 최고관리자(sys, system)로 접속한 후
실행해야 한다. 
사용자 계정 생성후 접속 테스트는 CMD(명령프롬프트)에서 진행한다. 
*/

/*
1]사용자 계정 생성 및 암호설정
형식]
    create user 아이디 identified by 패스워드;
*/
create user test_user1 identified by 1234;
--생성직후 cmd에서 sqlplus 명령으로 접속시 login denied 에러 발생됨

/*
2]생성된 사용자 계정에 권한 혹은 역할 부여
형식]
    grant 시스템권한1, 2, ... N
        to 사용자계정명
            [with grant 옵션];
*/
--접속권한 부여
grant create session to test_user1 ;--접속은 되지만 테이블 생성은 안된다.
--테이블 생성권한 부여
grant create table to test_user1;--테이블 생성권한은 있지만 테이블 스페이스가 없어 오류가 발생한다.

/*
테이블 스페이스란?
    디스크 공간을 소비하는 테이블과 뷰, 그리고 그 밖의 다른 데이터베이스
    객체들이 저장되는 장소이다. 예를 들어 오라클을 최초로 설치하면
    hr계정의 데이터를 저장하는 user라는 테이블 스페이스가 자동으로 생성된다. 
*/
--테이블 스페이스 조회하기
select tablespace_name, status, contents from dba_tablespaces;
desc dba_tablespaces;

--테이블 스페이스별 사용 가능한 공간 확인하기
select tablespace_name, sum(bytes), max(bytes) from dba_free_space
    group by tablespace_name;

--앞에서 생성한 test_user1 사용자의 테이블 스페이스 확인하기
select username, default_tablespace from dba_users
    where username in upper('test_user1');

--테이블 스페이스 영역 할당
alter user test_user1 quota 2m on system;/*
            test_user1이 system 테이블 스페이스에 테이블을 생성할 수 
            있도록 2m의 용량을 할당한다. 
        */
--CMD에서 테이블 생성을 확인한다. 


--2번째 사용자 추가 : 테이블 스페이스 users를 사용할 수 있도록 생성한다. 
create user test_user2 identified by 1234 default tablespace users;
grant create session to test_user2;--접속 권한 부여
grant create table to test_user2;--테이블 생성 권한 부여

--테이블 생성을 해보면 users 테이블스페이스에 대한 권한이 없어서 생성할 수 없음.

--test_user2가 사용하는 테이블 스페이스 확인
select username, default_tablespace from dba_users
    where username in upper('test_user2');--우리가 설정한대로 users를 사용하고있음

--users 테이블스페이스에 10m 공간을 할당
alter user test_user2 quota 10m on users;

--테이블 생성 시도2 : 성공

/*
이미 생성된 사용자의 디폴트 테이블 스페이스를 변경하고 싶은경우
alter user 명령을 사용한다. 
*/
alter user test_user1 default tablespace users;
select username, default_tablespace from dba_users
    where username in upper('test_user1');--users로 변경된 것을 확인.
    

/*
sqlplus에서 ED명령어 사용하기
    : 긴 쿼리문을 작성할때 메모장을 editor로 활용하여 실행시키는 명령

1.파일생성하기
SQL> ed new_table [Enter]
    : 이와 같은 명령으로 사용자계정 디렉토리에 new_table.sql파일이 생성된다. 

2.메모장에서 테이블 (혹은 다른 쿼리문)을 생성한다. 
    문장의 끝은 ;이 아니라 /를 붙여야 한다. 
    작성이 완료되면 저장 후 파일을 닫아준다. 

3.실행
SQL> @new_table [Enter]

4.기존 내용 수정시에는 파일 생성과 동일하게 실행한다. 
SQL> ed 파일명 [Enter]
    즉 파일이 있으면 수정이고, 없다면 새롭게 생성한다. 
*/

--test_user2 계정에서 테이블 생성과 시퀀스 생성을 시도 : 시퀀스는 권한부족으로 에러발생됨.

/*
3] 암호변경
    : alter user 사용자계정 identified by 변경할암호;
*/
alter user test_user1 identified by 4321;


/*
4] Role(롤)을 통한 여러가지 권한을 동시에 부여하기
    : 여러 사용자가 다양한 권한을 효과적으로 관리할 수 있도록
    관련된 권한끼리 묶어놓은것을 말한다. 
※우리는 실습을 위해 새롭게 생성한 계정에 connect, resource롤을 주로 부여한다.   
*/
 grant connect, resource to test_user2;

--cmd에서 new_table.sql 파일을 실행. 시퀀스 생성, 레코드 입력 : 성공

/*
4-1] 롤 생성하기 : 사용자가 원하는 권한을 묶어 새로운 롤을 생성한다. 
*/
create role kosmo_role;

/*
4-2] 생성된 롤에 권한 부여하기
*/
grant create session, create table, create view to kosmo_role;
--새로운 사용자 계정 생성
create user test_user3 identified by 1234;
--앞에서 생성한 롤을 통해 권한 부여
grant kosmo_role to test_user3;

--cmd 에서 접속 확인. 현재 접속은 가능하나, 테이블 스페이스가 없어 테이블 생성은 안됨.

--데이터 사전에서 생성된 롤 확인
select * from role_sys_privs where role like upper('%kosmo_role%');

/*
4-3] 롤 삭제하기
*/
drop role kosmo_role;
/*
    test_user3 사용자는 롤을 통해 권한을 부여받았으므로
    해당 롤을 삭제하면 부여받았던 모든 권한이 회수(revoke)된다. 
    즉, 롤 삭제후에는 접속할 수 없다. 
*/

/*
5] 권한제거(회수)
    형식] revoke 권한 및 역할 from 사용자계정;
*/
revoke create session from test_user1;
--test_uer1 로는 접속할 수 없다. 

/*
6] 사용자 계정 삭제
    형식] drop user 사용자계정 [cascade];
※cascade를 명시하면 사용자계정과 관련된 모든 데이터베이스 스키마가 
데이터사전으로 부터 삭제되고 모든 스키마 객체도 물리적으로 삭제된다.  
*/
--사용자 목록을 확인할 수 있는 데이터 사전
select * from dba_users;

drop user test_user1 cascade;


