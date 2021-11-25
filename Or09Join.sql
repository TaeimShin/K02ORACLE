/*********************
파일명 : Or09Join.sql
테이블조인
설명 : 두개 이상의 테이블을 동시에 참조하여 데이터를 가져와야 할때 
사용하는 SQL문
**********************/

/*
1] inner join (내부조인)
-가장 많이 사용되는 조인문으로 테이블간에 연결조건을 모두 만족하는
    행을 검색할때 사용된다. 
-일반적으로 기본키(primary key) 와 외래키(foreign key)를 사용하여
    join하는 경우가 대부분이다. 
-두 개의 테이블에 동일한 이름의 컬럼이 존재하면 "테이블명.컬럼명"
    형태로 기술해야 한다. 
-테이블의 별칭을 사용하면 "별칭.컬럼명" 형태로 기술할 수 있다. 

형식1(ANSI 표준방식)
    select
        컬럼1, 컬럼2,...
    from 테이블1 inner join 테이블2
        on 테이블1.기본키컬럼=테이블2.외래키컬럼
    where
        조건1 and 조건2 ....;
*/


/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단 표준방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/
--에러발생 : column ambiguously defined. 열의 정의가 애매함.
/*
    department_id 컬럼의 경우 양쪽 모든 테이블에 존재하는 컬럼이므로
    어떤 테이블에서 가져와 출력할지 결정해야 한다. 
*/
select
    employee_id, first_name, last_name, email,
    department_id, department_name
from employees inner join departments 
    on employees.department_id=departments.department_id ;

--부서테이블에서 가져오기 위해 departments.department_id로 기술함.
select
    employee_id, first_name, last_name, email,
    departments.department_id, department_name
from employees inner join departments 
    on employees.department_id=departments.department_id ;    
    
--as(알리아스)를 통한 별칭으로 쿼리문을 간소화 할수있다.     
select
    employee_id, first_name, last_name, email,
    dep.department_id, department_name
from employees emp inner join departments dep
    on emp.department_id=dep.department_id ;/*
        부서번호가 없는 사원이 1명 존재하므로 Join의 결과는
        107개가 아닌 106개가 나오게 된다. 
    */    
    
--3개 이상의 테이블 조인
/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 표준방식으로 작성하시오. 
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역
*/
select
    first_name, last_name, email, E.department_id, department_name, 
    E.job_id, job_title, city, state_province
from locations L 
    inner join departments D
        on L.location_id=D.location_id 
    inner join employees E
        on E.department_id=D.department_id
    inner join jobs J
        on J.job_id=E.job_id
where lower(city)='seattle';

/*
형식2(오라클 방식)
    select
        컬럼1, 컬럼2, .... 컬럼N
    from 
        테이블1, 테이블2
    where
        테이블1.컬럼=테이블2.컬럼
        and 조건1 or 조건2 ... 조건N;
*/
    
/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단 오라클 방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/
select
    employee_id, first_name, last_name, email, emp.department_id, department_name
from employees emp, departments dep
where emp.department_id=dep.department_id;
    
    
/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 오라클 방식으로 작성하시오. 
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역
*/
select
    first_name, last_name, email, D.department_id, department_name, 
    E.job_id, job_title, city, state_province
from locations L, departments D, employees E, jobs J
where
    L.location_id=D.location_id and
    D.department_id=E.department_id and 
    E.job_id=J.job_id and city=initcap('seattle');


/*
2] outer join (외부조인)
outer join은 inner join과는 달리 두 테이블에 조인조건이 정확히
일치하지 않아도 기준이 되는 테이블에서 결과값을 가져오는 join방식이다. 
outer join을 사용할때는 반드시 outer전에 기준이 되는 테이블을 
결정하고 기술해야 한다. 
    -> left(왼쪽테이블), right(오른쪽테이블), full(양쪽테이블)

형식1(표준방식)
    select 컬럼1, 컬럼2 ....
    from 테이블1 
        left[right, full] outer join 테이블2
            on 테이블1.기본키=테이블2.참조키
    where 조건1 and 조건2 or 조건3;
*/
/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오.
*/
select
    employee_id, first_name, last_name, D.department_id, city
from employees E
    left outer join departments D
        on E.department_id=D.department_id
    left outer join locations L
        on D.location_id=L.location_id;

--위 시나리오를 테이블의 기준위치만 right로 변경해서 실행해보자.
select
    employee_id, first_name, last_name, D.department_id, city
from employees E
    right outer join departments D
        on E.department_id=D.department_id
    right outer join locations L
        on D.location_id=L.location_id;
--left 혹은 right와 같이 기준이 되는 테이블이 달라지면 인출되는 결과도 달라진다. 

/*
형식2(오라클 방식)
    select
        컬럼1, 컬럼2, .... 컬럼N
    from 
        테이블1, 테이블2
    where
        테이블1.컬럼=테이블2.컬럼(+)
        and 조건1 or 조건2 ... 조건N;
    => 오라클 방식으로 변경시에는 outer join연산자인 (+)를 붙여주면 된다. 
    => 위의 경우 왼쪽 테이블이 기준이 된다. 
*/

/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오. 단 오라클방식으로 작성하시오.
*/
select
    employee_id, first_name, last_name, dep.department_id, department_name,
    city, state_province
from employees emp, departments dep, locations loc
where 
    emp.department_id=dep.department_id(+)
    and dep.location_id=loc.location_id(+);
    

/*
시나리오] 2007년에 입사한 사원을 조회하시오. 단, 부서에 배치되지 않은 
직원의 경우 <부서없음> 으로 출력하시오. 
출력항목 : 사번, 이름, 성, 부서명
*/
--일단 레코드 확인
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees;
--2007년에 입사한 사원 추출. 부서번호까지 확인.
select first_name, hire_date, department_id from employees 
    where to_char(hire_date, 'yyyy')='2007';
--외부조인으로 결과 확인
select
    employee_id, first_name, last_name, nvl(department_name,'<부서없음>') dep_name
from employees E left outer join departments D
    on E.department_id=D.department_id
where 
    to_char(hire_date, 'yyyy')='2007';

 


/*
3] self join (셀프조인)
셀프조인은 하나의 테이블에 있는 컬럼끼리 연결해야 하는 경우
사용한다. 즉 자기자신의 테이블과 조인을 맺는것이다. 
셀프조인에서는 별칭이 테이블을 구분하는 구분자의 역할을 하므로
굉장히 중요하다. 

형식]
    select 
        별칭1.컬럼, 별칭2.컬럼 ....
    from    
        테이블 별칭1, 테이블 별칭2
    where
        별칭1.컬럼=별칭2.컬럼 ;
*/

/*
시나리오] 사원테이블에서 각 사원의 메니져아이디와 메니져이름을 출력하시오.
    단, 이름은 fist_name과 last_name을 하나로 연결해서 출력하시오.
*/
select
    empClerk.employee_id "사원번호",
    (empClerk.first_name||' '||empClerk.last_name) "사원이름",
    empManager.employee_id "메니져사원번호",
    concat(empManager.first_name||' ', empManager.last_name) "메니져이름"
from 
    employees empClerk , employees empManager
where
    empClerk.manager_id=empManager.employee_id ;

/*
시나리오] self join을 사용하여 "Kimberely / Grant" 사원보다 입사일이 늦은
    사원의 이름과 입사일을 출력하시오. 
    출력목록 : first_name, last_name, hire_date
*/
--1.Kimberely 의 정보확인
select * from employees where first_name='Kimberely' and last_name='Grant';
--2.07/05/24 이후에 입사한 직원들을 인출
select * from employees where hire_date>'07/05/24';
--3.self join으로 쿼리문을 합침
select
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
from employees Kimberely , employees Clerk
where
    Kimberely.hire_date<Clerk.hire_date
    and Kimberely.first_name='Kimberely' and Kimberely.last_name='Grant';



/*
using : join문에서 주로 사용하는 on절을 대체할 수 있는 문장
    형식] on 테이블1.컬럼=테이블2.컬럼
        ==> using(컬럼)
*/

/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를
    출력하는 쿼리문을 작성하시오. 단 using을 사용해서 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역
*/ 
select
    first_name, last_name, email, department_id, department_name,
    job_id, job_title, city, state_province
from locations 
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join jobs using(job_id)
where city=initcap('seattle');    
/*
    using 절에 사용된 식별자 컬럼의 경우 select절에서 테이블의 별칭을
    붙이면 오류가 발생한다. 
    using절에 사용된 컬럼은 좌, 우측의 테이블에 동시에 존재하는 컬럼이라는
    것을 전재로 작성되기 때문에 굳이 별칭을 붙여줄 이유가 없기 때문이다. 
*/

/*
 퀴즈] 2005년에 입사한 사원들중 California(STATE_PROVINCE) / 
 South San Francisco(CITY)에서 근무하는 사원들의 정보를 출력하시오.
 단, 표준방식과 using을 사용해서 작성하시오.
 
 출력결과] 사원번호, 이름, 성, 급여, 부서명, 국가코드, 국가명(COUNTRY_NAME)
        급여는 세자리마다 컴마를 표시한다. 
 참고] '국가명'은 countries 테이블에 입력되어있다. 
*/
select
    employee_id, first_name, last_name, to_char(salary,'999,000'), 
    department_name, country_id, country_name
from locations 
    inner join departments using(location_id)
    inner join employees using(department_id)   
    inner join countries using(country_id)
where 
    (to_char(hire_date, 'yyyy')='2005' 
    or substr(hire_date, 1, 2)='05'
    or hire_date like '05%')
    and city='South San Francisco' and state_province='California';






---------------------------------------------------
---------연습문제
/*
1. inner join 방식중 오라클방식을 사용하여 first_name 이 Janette 인 
사원의 부서ID와 부서명을 출력하시오.
출력목록] 부서ID, 부서명
*/
select
    D.department_id, department_name
from employees E, departments D
where
    E.department_id=D.department_id 
    and first_name='Janette';


/*
2. inner join 방식중 SQL표준 방식을 사용하여 사원이름과 함께 그 사원이 
소속된 부서명과 도시명을 출력하시오
출력목록] 사원이름, 부서명, 도시명
*/
select
    first_name, last_name, department_name, city
from employees E 
    inner join departments D
        on E.department_id=D.department_id
    inner join locations L
        on D.location_id=L.location_id;            


/*
3. 사원의 이름(FIRST_NAME)에 'A'가 포함된 모든사원의 이름과 부서명을 출력하시오.
출력목록] 사원이름, 부서명
*/
select
    first_name, last_name, department_name
from employees E, departments D
where E.department_id=D.department_id
    and first_name like '%A%';
    

/*
4. “city : Toronto / state_province : Ontario” 에서 근무하는 모든 
사원의 이름, 업무명, 부서번호 및 부서명을 출력하시오.
출력목록] 이름, 업무명, 부서ID, 부서명
*/
select
    first_name, last_name, job_title, D.department_id, department_name
from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on D.department_id=E.department_id
    inner join jobs J on E.job_id=J.job_id
where     
    city='Toronto' and state_province='Ontario';
    

/*
5. Equi Join을 사용하여 커미션(COMMISSION_PCT)을 받는 모든 사원의 
이름, 부서명, 도시명을 출력하시오. 
출력목록] 사원이름, 부서ID, 부서명, 도시명
*/
select
    first_name, last_name, D.department_id, department_name, city
from employees E
    inner join departments D on E.department_id=D.department_id
    inner join locations L on D.location_id=L.location_id
where
    commission_pct is not null;


/*
6. inner join과 using 연산자를 사용하여 50번 부서(DEPARTMENT_ID)에 
속하는 모든 담당업무(JOB_ID)의 고유목록(distinct)을 부서의 도시명(CITY)을 
포함하여 출력하시오.
출력목록] 담당업무ID, 부서ID, 부서명, 도시명
*/
select
    distinct job_id, department_id, department_name, city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
where 
    department_id=50;


/*
7. 담당업무ID가 FI_ACCOUNT인 사원들의 메니져는 누구인지 출력하시오. 
단, 레코드가 중복된다면 중복을 제거하시오. 
출력목록] 이름, 성, 담당업무ID, 급여
*/
--담당업무가 FI_ACCOUNT인 사원들의 메니져 아이디를 조회
select employee_id, first_name, manager_id 
    from employees where job_id='FI_ACCOUNT';
--메니져 아이디가 108이므로 사원번호를 조회    
select first_name from employees where employee_id=108;    
--셀프조인을 통해서 해당 사원의 메니져 정보를 출력한다. 
select
    distinct eMgr.first_name, eMgr.last_name, eMgr.job_id, eMgr.salary
from employees eClerk, employees eMgr
where eClerk.manager_id=eMgr.employee_id 
    and eClerk.job_id='FI_ACCOUNT';


/*
8. 각 부서의 메니져가 누구인지 출력하시오. 출력결과는 부서번호를 오름차순 정렬하시오.
출력목록] 부서번호, 부서명, 이름, 성, 급여, 담당업무ID
※ departments 테이블에 각 부서의 메니져가 있습니다.
*/
select
    E.department_id, department_name, first_name, last_name, salary, job_id
from departments D, employees E
where
    D.manager_id=E.employee_id
order by department_id asc;


/*
9. 담당업무명이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 
평균 급여를 출력하시오. 출력시 년도를 기준으로 오름차순 정렬하시오. 
출력항목 : 입사년도, 평균급여
*/
select * from jobs where job_title='Sales Manager';
select * from employees where job_id='SA_MAN';
select hire_date, to_char(hire_date, 'yyyy') from employees where job_id='SA_MAN';    

select to_char(hire_date, 'yyyy') , avg(salary)
    from employees inner join jobs using(job_id)
    where job_title='Sales Manager'
    group by to_char(hire_date, 'yyyy')
    order by to_char(hire_date, 'yyyy') asc;




    
    
    