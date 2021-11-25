/******************
파일명 : Or10SubQuery.sql
서브쿼리
설명 : 쿼리문안에 또 다른 쿼리문이 들어가는 형태의 select문
*******************/

/*
단일행 서브쿼리
    형식]
        select * from 테이블명 where 컬럼=(
            select 컬럼 from 테이블명 where 조건
        );
    ※ 괄호안의 서브쿼리는 반드시 하나의 결과를 인출해야 한다. 
*/
 
/*
시나리오] 사원테이블에서 전체사원의 평균급여보다 낮은 급여를 받는 사원들을 
추출하여 출력하시오.
    출력항목 : 사원번호, 이름, 이메일, 연락처, 급여
*/
--해당 쿼리문은 문맥상 맞는듯하지만 그룹함수를 단일행에 적용한 잘못된 쿼리
select * from employees where salary<avg(salary);--에러발생
--1단계 : 평균급여가 얼마인지 확인
select round(avg(salary)) from employees;
--2단계 : 6462보다 적은 급여를 받는 직원을 인출
select * from employees where salary<6462;
--3단계 : 2개의 쿼리문을 하나의 서브쿼리문으로 합친다.
select * from employees 
    where salary<(select round(avg(salary)) from employees);--56개 인출

/*
시나리오] 전체 사원중 급여가 가장적은 사원의 이름과 급여를 출력하는 
서브쿼리문을 작성하시오.
출력항목 : 이름1, 이름2, 이메일, 급여
*/
--1단계 : 최소급여 확인
select min(salary) from employees;
--2단계 : 2100을 받는 직원
select * from employees where salary=2100;
--3단계 : 합치기
select * from employees where salary=(select min(salary) from employees);

/*
시나리오] 평균급여보다 많은 급여를 받는 사원들의 명단을 조회할수 있는 
서브쿼리문을 작성하시오.
출력내용 : 이름1, 이름2, 담당업무명, 급여
※ 담당업무명은 jobs 테이블에 있으므로 join해야 한다. 
*/
--1단계 : 평균급여
select trunc(avg(salary),2) from employees;
--2단계
select * from employees where salary>6461.83;
--3단계 : join을 건다.
select first_name, last_name, job_title, salary
from employees inner join jobs using(job_id)
where salary>6461.83;
--4단계 
select first_name, last_name, job_title, salary
from employees inner join jobs using(job_id)
where salary>(select trunc(avg(salary),2) from employees);


/*
복수행 서브쿼리
    형식]
        select * from 테이블명 where 컬럼 in (
            select 컬럼 from 테이블명 where 조건
        );
    ※ 괄호안의 서브쿼리는 2개 이상의 결과를 인출해야 한다.
*/

/*
시나리오] 담당업무별로 가장 높은 급여를 받는 사원의 명단을 조회하시오.
    출력목록 : 사원아이디, 이름, 담담업무아이디, 급여
*/
--1단계 : 담당업무별 가장 높은 급여 확인
select job_id, max(salary)
from employees
group by job_id;
--2단계 : 위의 결과를 단순한 or조건으로 묶어본다. 
select employee_id, first_name, job_id, salary
from employees
where
    (job_id='IT_PROG' and salary=9000) or
    (job_id='AC_MGR' and salary=12008) or
    (job_id='AC_ACCOUNT' and salary=8300) ;--19개의 or 조건이 필요함
--3단계 : 복수행 연산자를 통한 서브쿼리로 합친다.
select employee_id, first_name, job_id, salary
from employees
where
    (job_id, salary) in
        (
            select job_id, max(salary)
            from employees
            group by job_id
        );


/*
복수행 연산자2 : any
    메인쿼리의 비교조건이 서브쿼리의 검색결과와 하나이상
    일치하면 참이 되는 연산자. 즉 둘중 하나만 만족하면 해당
    레코드를 가져온다. 
*/

/*
시나리오] 전체사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 받는 
    직원들을 추출하는 서브쿼리문을 작성하시오. 
*/
--1.20번 부서의 급여를 확인
select first_name, salary from employees where department_id=20;
--2.1의 결과를 단순 쿼리로 작성
select first_name, salary from employees
    where salary>6000 or salary>13000;    
--3.둘중 하나만 만족하면 인출할 것이므로 any를 이용해 서브쿼리를 작성
select first_name, last_name, department_id, salary
    from employees
    where salary>any(select salary from employees where department_id=20);
    /*
        복수행 연산자 any를 사용하면 2번과 같이 or 조건으로 결과들을
        연결하게 된다. 6000 또는 13000 이상인 레코드만 추출된다.
    */


/*
복수행연산자3 : all
    메인 쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치해야
    레코드를 인출한다. 
*/
select first_name, last_name, department_id, salary
    from employees
    where salary>all(select salary from employees where department_id=20);
    /*
        6000보다 크고, 13000보다도 커야하므로 결과적으로 13000이상인
        레코드만 추출하게 된다. 
    */


/*
Top쿼리 : 조회된 결과에서 구간을 정해 레코드를 가져올때 사용한다. 
    주로 게시판의 페이징에 사용된다. 
    
    rownum : 테이블에서 레코드를 조회한 순서대로 순번이 부여되는
        가상의 컬럼을 말한다. 해당 컬럼은 모든 테이블에 존재한다. 
*/
--모든 레코드를 가져온다. 
select * from employees;
--정렬없이 모든 레코드를 가져와서 rownum을 출력한다.(rownum이 순서대로 나옴) 
select employee_id, first_name, rownum from employees;
--이름으로 오름차순 정렬한 후 출력한다.(rownum이 섞여져서 나옴) 
select employee_id, first_name, rownum 
    from employees order by first_name asc;
--rownum을 우리가 정렬한 순대대로 재부여하기 위해 서브쿼리를 사용한다. 
select first_name, rownum from
    (select * from employees order by first_name asc);

--사원테이블에서 정해진 구간을 통해 가져오기 위한 서브쿼리문
select * from
    (select tb.*, rownum rNum from
        (select * from employees order by first_name asc) tb)
--where rNum between 1 and 10;
--where rNum between 11 and 20;
where rNum between 21 and 30;
/*
    betweeen의 구간을 위와같이 변경해주면 해당 페이지의 레코드만
    추출하게 된다. 위의 구간은 차후 JSP에서 여러가지 변수를 조합하여
    계산해서 구현한다. 
    
    3.2의 결과 전체를 가져온 다음...
        (2.1의 결과에 rownum을 재 부여한다. 
            (1.사원테이블의 모든 레코드를 오름차순으로 정렬해서 인출) tb
        )
    필요한 부분을 between으로 구간을 정해 인출한다.     
*/

--------------------------------------------------------
--------------- Sub Query 연 습 문 제 ------------------ 
--------------------------------------------------------

/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시하시오.
출력 : 사원이름, 담당 업무
*/
select * from emp where empno=7782;
select * from emp where job='MANAGER';
select * from emp where job=(select job from emp where empno=7782);

/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시하시오.
출력 : 사원이름, 급여, 담당업무
*/
select * from emp where empno=7499;
select * from emp where sal>1600;
select * from emp where sal>(select sal from emp where empno=7499);


/*
03.최소 급여를 받는 사원번호, 이름, 담당 업무 및 급여를 표시하시오.
(그룹함수 사용)
*/
select min(sal) from emp;
select * from emp where sal=800;
select empno, ename, job, sal from emp where sal=(select min(sal) from emp);


/*
04.평균 급여가 가장 적은 직급(job)과 평균 급여를 표시하시오.
*/
--직급별 평균급여 인출
select job, avg(sal) from emp group by job;
--오류발생. 그룹함수를 2개 겹쳤기 때문에 job 컬럼을 제외해야 함.
select job, min(avg(sal)) from emp group by job;
--정상실행됨. 직급중 평균급여가 최소인 레코드 인출.
select min(avg(sal)) from emp group by job;
/*
    평균급여는 물리적으로 존재하는 컬럼이 아니므로
    where 절에는 사용할 수 없고 having절에 사용해야 한다. 
    즉, 평균급여가 1017인 직급을 출력하는 방식으로 서브쿼리를
    작성해야 한다. 
*/
select job, avg(sal)
    from emp 
    group by job
    having avg(sal)=(select min(avg(sal)) from emp group by job);


/*
05.각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/
--단순 정렬을 통해 부서별 급여 확인
select deptno, sal from emp order by deptno, sal;
--그룹함수를 통해 부서별 최소급여 확인
select deptno, min(sal) from emp group by deptno;
--단순 or절을 통한 인출
select ename, sal, deptno from emp 
    where (deptno=30 and sal=950) 
        or (deptno=20 and sal=800) 
        or (deptno=10 and sal=1300);
--서브쿼리의 복수행 연산자를 통해 쿼리 작성         
select ename, sal, deptno from emp 
    where (deptno, sal) in (select deptno, min(sal) from emp group by deptno);

/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 
업무가 분석가(ANALYST)가 아닌 사원들을 표시(사원번호, 이름, 담당업무, 급여)하시오.
*/
select * from emp where job='ANALYST';
select * from emp where sal<3000 and job<>'ANALYST';
/*
    ANALYST 직무를 통한 결과가 1개이므로 아래와 같이 단일행 연산자로 
    서브쿼리를 만들수 있지만, 만약 결과가 2개 이상이라면 복수행 연산자인
    all이나 any를 추가해야 한다. 
*/
select empno, ename, job, sal from emp 
    where sal<(select sal from emp where job='ANALYST') and job<>'ANALYST';




/*
07.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 
사원번호와 이름, 부서번호를 표시하는 질의를 작성하시오
*/
select * from emp where ename like '%K%';
select * from emp where deptno in (30, 10);
/*
    or조건을 in으로 표현할 수 있으므로, 서브쿼리에서 복수행 연산자인
    in을 사용한다. 2개 이상의 결과를 or로 연결하여 출력하는 기능을 가진다. 
*/
select * from emp where deptno in (select deptno from emp where ename like '%K%');

/*
08.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/
select * from dept where loc='DALLAS';
select * from emp where deptno=20;
select ename, deptno, job from emp 
    where deptno=(select deptno from dept where loc='DALLAS');

/*
09.평균급여 보다 많은 급여를 받고 이름에 K가 포함된 사원과 같은 부서에서 근무하는 
사원의 사원번호, 이름, 급여를 표시하시오.
*/
--평균급여
select avg(sal) from emp;--2077.xxx
--K가 포함된 사원
select * from emp where ename like '%K%';--30, 10
--단순 조건으로 쿼리작성
select * from emp
    where sal>2077 and deptno in (30, 10);
--서브쿼리로 작성    
select empno, ename, sal from emp
    where sal>(select avg(sal) from emp) 
    and deptno in (select deptno from emp where ename like '%K%');

/*
10.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/
select * from emp where job='MANAGER';--10, 20, 30
select * from emp where deptno in (select deptno from emp where job='MANAGER');

/*
11.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오
(단, BLAKE는 제외).
*/
select * from emp where ename='BLAKE';--30
select * from emp where deptno=30 and ename<>'BLAKE';
select ename, hiredate from emp 
    where deptno=(select deptno from emp where ename='BLAKE') 
        and ename<>'BLAKE';




