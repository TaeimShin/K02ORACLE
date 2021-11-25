/*****************************
파일명 : Or06GroupBy.sql
그룹함수(select문 2번째)
설명 : 전체 레코드(로우)에서 통계적인 결과를 구하기 위해 하나 이상의
    레코드를 그룹으로 묶어서 연산후 결과를 반환하는 함수 혹은 쿼리문
*******************************/

/*
distinct 
    - 중복되는 레코드를 제거한 후 하나의 레코드만 가져와서 보여준다.
    - 따라서 통계적인 데이터를 계산할 수 없다.
*/
select distinct job_id from employees;

/*
group by
    - 동일한 값이 있는 레코드를 하나의 그룹으로 묶어서 가져온다. 
    - 보여지는건 하나의 레코드지만 여러개의 레코드가 묶여진 결과이므로
        통계적인 데이터를 계산할 수 있다. 
    -최대, 최소, 평균, 합산 등의 연산을 할수 있다. 
*/
select job_id from employees group by job_id;

/*
그룹함수의 기본형식

    select
        컬럼1, 컬럼2,... 혹은 *(전체)
    from
        테이블
    [where
        조건1 or 조건2 and 조건3 ...]    
    [group by
        데이터 그룹화를 위한 컬럼명]
    [having
        그룹에서 찾을 조건] 
    [order by
        레코드 정렬을 위한 컬럼과 정렬방식]
    
    ※ 쿼리의 실행순서
    from -> where -> group by -> having -> select -> order by
*/


/*
sum() : 합계를 구할때 사용하는 함수
    -number 타입의 컬럼에서만 사용할 수 있다. 
    -필드명이 필요한 경우 as를 이용해서 별칭을 부여할수 있다.
*/
--전체직원의 급여의 합계를 출력하시오.
select
    sum(salary) "급여합1",
    to_char(sum(salary), '999,000') "급여합2"
from employees;

--10번부서에 근무하는 사원들의 급여합계는 얼마인지 출력하시오.
select
    sum(salary),
    to_char(sum(salary), '999,999'),
    ltrim(to_char(sum(salary), '999,999')),
    ltrim(to_char(sum(salary), 'L999,999'))
from employees
where department_id=10;

--sum()과 같은 그룹함수는 number타입인 컬럼에서만 사용할수있다.
select sum(first_name) from employees;--에러발생


/*
count() : 레코드의 갯수를 카운트할때 사용하는 함수
*/
--사원테이블에 저장된 전체 사원수는 몇명인가?
select count(*) from employees;--방법1 : 권장사항
select count(employee_id) from employees;--방법2 : 권장사항이 아님
select count(first_name) from employees;--count()함수는 문자타입의 컬럼도 사용가능
/*
    count()함수를 사용할때는 위 2가지 방법 모두 가능하지만
    *를 사용할것을 권장한다. 컬럼의 특성 혹은 데이터에 따른 
    방해를 받지 않으므로 검색속도가 훨씬 빠르다.
*/

/*
count()함수의 
    사용법1 : count(all 컬럼명)
        => 디폴트 사용법으로 컬럼 전체의 레코드를 기준으로 카운트한다. 
    사용법2 : count(distinct 컬럼명)
        -> 중복을 제거한 상태에서 카운트 한다. 
*/
select
    count(job_id) "담당업무전체갯수1",
    count(all job_id) "담당업무전체갯수2",
    count(distinct job_id) "순수담당업무갯수"
from employees;


/*
avg() : 평균값을 구할때 사용하는 함수
*/
--전체사원의 평균급여는 얼마인지를 출력하는 쿼리문을 작성하시오.
select
    count(*) "사원수", 
    sum(salary) "급여의합계",
    sum(salary) / count(*) "평균급여1",
    avg(salary) "평균급여2",
    trim(to_char(avg(salary), '$999,000')) "평균급여3"
from employees;

--영업팀의 평균급여는 얼마인가요?
--1.부서테이블에서 영업팀의 부서번호가 무엇인지 확인한다. 
select * from departments where lower(department_name)='sales';
select * from departments where department_name=initcap('sales');
/*
    정보검색시 대소문자 혹은 공백이 포함된 경우 모든 레코드에 대해
    문자열을 확인하는것은 불가능하므로 일괄적인 규칙을 위해 upper()와
    같은 변환함수를 사용하여 검색하는것이 좋다.
*/
select
    avg(salary),
    to_char(avg(salary), '$999,000.00')
from employees
where department_id=80;


/*
min(), max() 함수 : 최대값, 최소값을 찾을때 사용하는 함수
*/
--사원테이블에서 가장 낮은 급여는 얼마인가요?
select min(salary) from employees;

--사원테이블에서 가장 낮은 급여를 받는 사람은 누구인가요??
select * from employees where salary=2100;/* 위에서 구한 급여의 최소값을 조건으로 
                                            다시한번 select해야한다. */
/*
    사원중 가장 낮은 급여는 min()으로 구할수 있으나 
    가장 낮은 급여를 받는 사람은 아래와 같이 서브쿼리를 통해
    구할 수 있다. 
    따라서 문제에 따라 서브쿼리를 사용할지 여부를 결정해야 한다.
*/
select * from employees where salary=(select min(salary) from employees);


/*
group by절 : 여러개의 레코드를 하나의 그룹으로 그룹화하여 묶여진
    결과를 반환하는 쿼리문.
    ※ distinct 는 단순히 중복값을 제거함.
*/
--사원테이블에서 각 부서별 급여의 합계는 얼마인가?
--step1 : 각 부서를 그룹화 하기
select department_id from employees
    group by department_id;
--step2 : 각 부서별로 급여합계 구하기
select department_id , sum(salary), to_char(sum(salary),'$999,000')
    from employees
    group by department_id
    order by sum(salary) desc;

/*
퀴즈] 사원테이블에서 각 부서별 사원수와 평균급여는 얼마인지
    출력하는 쿼리문을 작성하시오.
    출력결과 : 부서번호, 급여총합, 사원총합, 평균급여
        부서번호 순서대로 오름차순 정렬하시오.
*/
select
    department_id "부서번호",
    sum(salary) "급여총합",
    count(*) "사원총합",
    to_char(avg(salary), '999,000.00') "평균급여"
from employees
group by department_id
order by department_id asc;

/*
위에서 사용했던 쿼리문을 아래와 같이 수정하면 에러가 발생한다. 
group by절에서 사용한 컬럼은 select절에서 사용할 수 있으나, 
그외의 단일컬럼은 select절에서 사용할 수 없다. 
그룹화된 상태에서 특정 레코드 하나만 선택하는것이 애매하므로 에러가 발생한다. 
*/
select
    department_id "부서번호",
    sum(salary) "급여총합",
    first_name
from employees
group by department_id
order by department_id asc;

--부서별 급여의 합계는 distinct를 통해 작성할 수 없다. 
select distinct department_id, sum(salary) from employees;



/*
시나리오] 부서아이디가 50인 사원들의 직원총합, 평균급여, 급여총합이
    얼마인지 출력하는 쿼리문을 작성하시오.
*/
select
    department_id "부서번호",
    count(*) "직원수",
    trim(to_char(avg(salary), '999,000.00')) "평균급여", 
    trim(to_char(sum(salary), '9,999,000')) "급여총합"
from employees
where department_id=50
group by department_id;


/*
having절 : 물리적으로 존재하는 컬럼이 아닌 그룹함수를 통해 논리적으로
    생성된 컬럼의 조건을 추가할때 사용한다. 
    해당 조건을 where절에 추가하면 에러가 발생한다.
*/
/*
시나리오] 사원테이블에서 각 부서별로 근무하고 있는 직원의 담당업무별 사원수와
    평균급여가 얼마인지를 출력하는 쿼리문을 작성하시오.
    단, 사원의 총합이 10명을 초과하는 레코드만 추출하시오. 
*/
select
    department_id "부서번호", job_id "담당업무",
    count(*) "사원수", avg(salary) "평균급여"
from employees
group by department_id, job_id
--where count(*)>10; /* 사원수는 물리적으로 존재하지 않으므로 where절에 쓰면 에러발생 */
having count(*)>10 /* 이와 같은 경우 having절에 조건을 추가해야 한다. */
order by department_id asc;


/*
퀴즈] 담당업무별 사원의 최저급여를 출력하시오.
    단, 관리자가 없는 사원과 최저급여가 3000미만인 그룹은 제외시키고
    결과를 급여의 내림차순으로 정렬하여 출력하시오. 
*/
select
    job_id, min(salary)
from employees 
where manager_id is not null  
group by job_id
having not min(salary)<3000
order by min(salary) desc;







--------------------------------------------------
----연습문제

/*
1. 전체 사원의 급여최고액, 최저액, 평균급여를 출력하시오. 컬럼의 별칭은 
아래와 같이 하고, 평균에 대해서는 정수형태로 반올림 하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
*/
select      
    max(salary) MaxPay, min(salary) MinPay, round(avg(salary)) AvgPay
from employees;
/*
    위 쿼리문의 경우 그룹함수를 통한 결과를 출력하고 있으므로 
    select 절에 first_name 과 같은 단일행은 사용할 수 없다. 
*/




/*
2. 각 담당업무 유형별로 급여최고액, 최저액, 총액 및 평균액을 출력하시오. 
컬럼의 별칭은 아래와 같이하고 모든 숫자는 to_char를 이용하여 세자리마다 
컴마를 찍고 정수형태로 출력하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
급여총액 -> SumPay
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
select
    job_id, 
    ltrim(to_char(max(salary), '999,000')) MaxPay, 
    ltrim(to_char(min(salary), '999,000')) MinPay, 
    ltrim(to_char(avg(salary), '999,000')) AvgPay,  
    ltrim(to_char(sum(salary), '999,000')) SumPay
from employees
group by job_id;
/*
    group by 절에서 그룹을 묶기 위해 사용한 job_id 컬럼은
    select절에서 사용할 수 있다. 
*/


/*
3. count() 함수를 이용하여 담당업무가 동일한 사원수를 출력하시오.
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
select
    job_id, count(*) "사원수"
from employees
group by job_id
--order by count(*) desc;
order by "사원수" desc;


/*
4. 급여가 10000달러 이상인 직원들의 담당업무별 합계인원수를 출력하시오.
*/
select
    job_id, count(*) "업무별인원합계"
from employees where salary>=10000
group by job_id;



/*
5. 급여최고액과 최저액의 차액을 출력하시오. 
*/
select max(salary)-min(salary) from employees;


/*
6. 각 부서에 대해 부서번호, 사원수, 부서 내의 모든 사원의 평균급여를 
출력하시오. 평균급여는 소수점 둘째자리로 반올림하시오.
*/
select
    department_id "부서번호", 
    count(*) "사원수", 
    trim(to_char(round(avg(salary), 2), '999,000.00')) "평균급여"
from employees
group by department_id
order by department_id asc;






