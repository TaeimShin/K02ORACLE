/************
파일명 : Or02Number.sql
숫자(수학) 관련 함수
설명 : 숫자데이터를 처리하기 위한 숫자관련 함수를 알아보자
    테이블 생성시 number 타입으로 선언된 컬럼에 저장된 데이터를
    대상으로 한다. 
*************/

/*
DUAL테이블
    : 한 행으로 결과를 출력하기 위해 제공되는 테이블로 오라클에서
    자동으로 생성되는 임시 테이블이다. 
    varchar2(1)로 정의된 dummy라는 단 하나의 컬럼으로 구성되어있다. 
*/
select * from dual;
select 1+2 from dual;


/*
abs() : 절대값 구하기
*/
select abs(12000) from dual;
select abs(-9000) from dual;
select abs(salary) "급여의절대값" from employees;

/*
trunc() : 소수점을 특정자리수에서 잘라낼때 사용하는 함수
    형식 : trunc(컬럼명 혹은 값, 소수점이하자리수)
        두번째 인자가 
            양수일때 : 주어진 숫자만큼 소수점을 표현
            없을때 : 정수부만 표현. 즉 소수점 아래부분은 버림
            음수일때 : 정수부를 숫자만큼 잘라 나머지를 0으로 채움
*/
select trunc(1234.123456, 2) from dual;
select trunc(1234.123456) from dual;
select trunc(1234.123456, -2) from dual;
/*
시나리오] 사원테이블에서 영업사원이 1000불에 대한 커미션을 계산하여
    급여에 합한 결과를 출력하는 쿼리문을 작성하시오.
*/
--1.영업사원 찾기(영업사원의 job_id는 모두 SA_xxx와 같이 시작한다.)
select salary, commission_pct, job_id from employees where job_id like 'SA%';

--2.커미션 계산하여 출력
select salary, commission_pct, job_id, (salary + (1000 * commission_pct))
    from employees where job_id like 'SA%';
    
--3.별칭으로 처리
select salary, commission_pct, job_id,
    (salary + (1000 * commission_pct)) AS TotalSalary
    from employees where job_id like 'SA%';

--4.커미션을 소수점 1자리까지 만으로 금액 계산하기
select salary, commission_pct, trunc(commission_pct,1), job_id,
    (salary + (1000 * trunc(commission_pct,1))) AS TotalSalary
    from employees where job_id like 'SA%';

/*
시나리오] 사원테이블에서 보너스율이 있는 사원만 인출한 후 보너스율을
    소수점 1자리로 표현하시오. 
*/
--1.커미션이 있는 사원들 추출하기
select first_name, salary, commission_pct from employees
    where commission_pct is not null;
--2.소수점 처리하기
select first_name, salary, trunc(commission_pct,1) from employees
    where commission_pct is not null;


/*
소수점 관련함수

ceil() : 소수점 이하를 무조건 올림처리
floor() : 소수점 이하를 무조건 버림처리
round(값, 자리수) : 반올림 처리
    두번째 인자가
        없는경우 : 소수점 첫번째 자리가 5이상이면 올림, 미만이면 버림
        있는경우 : 숫자만큼 소수점이 표현되므로 그 다음수가 5이상이면 올림,
            미만이면 버림
*/
select ceil(32.8) from dual;--33
select ceil(32.2) from dual;--33

select floor(32.8) from dual;--32
select floor(32.2) from dual;--32

select round(0.123), round(0.543) from dual;--0, 1
-- 첫번째항목 : 소수이하 6자리까지 표현하므로 7을 올림처리하여 0.123457 출력
-- 두번째항목 : 소수이하 4자리까지 표현하므로 1을 버림처리하여 2.3456 출력
select round(0.1234567, 6), round(2.345612, 4) from dual;
/*
시나리오] 사원테이블에서 영업사원의 커미션을 반올림하여 출력하시오.
    단 소수점 1자리까지 표현하시오.
*/
select commission_pct, round(commission_pct, 1) from employees
    where commission_pct is not null;


/*
mod() : 나머지를 구하는 함수
power() : 거듭제곱을 계산하는 함수
sqrt() : 제곱근(루트)을 구하는 함수
*/
select mod(99, 4) "99를4로나눈나머지" from dual;--3
select power(2, 10) "2의10승" from dual;--1024
select sqrt(49) "49의제곱근" from dual;--7













