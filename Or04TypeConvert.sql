/**********************************
파일명 : Or04TypeConvert.sql
형변환함수 / 기타함수
설명 : 데이터타입을 다른 타입으로 변환해야 할때 사용하는 함수와 기타함수
***********************************/

/*
sysdate : 현재날짜와 시간을 초단위로 반환해준다. 주로 게시판에서
    새로운 포스팅이 있을때 입력한 날짜를 표현하기 위해 사용된다. 
*/
select sysdate from dual;
/*
날짜포맷 : 대소문자를 구분하지 않는다. 따라서 mm과 MM은 동일한 결과를 출력한다. 
*/
select to_char(sysdate, 'yyyy/mm/dd') "오늘날짜" from dual;
select to_char(sysdate, 'YY-MM-DD') "오늘날짜" from dual;

--현재날짜를 "오늘은 0000년00월00일 입니다" 와 같은 형태로 출력하시오.
select
    to_char(sysdate, '오늘은 yyyy년mm월dd일 입니다') "과연될까?"
from dual;--에러발생 : 날짜형식이 부적합함.

--서식문자를 제외한 나머지 문자열을 더블쿼테이션으로 감싸준다. 
select
    to_char(sysdate, '"오늘은 "yyyy"년"mm"월"dd"일 입니다"') "이제된당"
from dual;

select  
    to_char(sysdate, 'day') "요일(목요일)",
    to_char(sysdate, 'dy') "요일(수)",
    to_char(sysdate, 'mon') "월(10월)",
    to_char(sysdate, 'mm') "월(10)",
    to_char(sysdate, 'month') "월(10월)",
    to_char(sysdate, 'yy') "두자리년도",
    to_char(sysdate, 'dd') "일을숫자로표현",
    to_char(sysdate, 'ddd') "1년중몇번째일"
from dual;

/* 시간 포맷 */
--현재시간을 00:00:00 형태로 표시하기(대소문자 구분없음)
select
    to_char(sysdate, 'HH:MI:SS') ,
    to_char(sysdate, 'hh:mi:ss') 
from dual;
--현재날짜와 시간을 한꺼번에 표시하기
select
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "현재시각"
from dual;



/*
숫자포맷
    0 : 숫자의 자리수를 나타내며 자리수가 맞지 않는경우
        0으로 자리를 채운다. 
    9 : 0과 동일하지만, 자리수가 맞지않는 경우 공백으로 채운다. 
*/
select
    to_char(123, '0000') "서식문자0사용", /* 앞에 0이 나와서 이상함 */
    to_char(123, '9999') "서식문자9사용" /* 앞에 공백이 있어 이상함 */
from dual;
--숫자에 세자리마다 컴마 표시하기
select
    12345, 
    to_char(12345, '000,000'),
    to_char(12345, '999,999'),
    to_char(1000000, '999,999,000'),
    ltrim(to_char(1000000, '999,999,000')) "좌측공백제거",
    ltrim(to_char(10000000, '999,999,000')) "좌측공백제거"
from dual;--오라클에서는 함수를 2개이상 중첩해서 사용할수 있다. 

--통화표시 : L => 각 나라에 맞는 통화표시가 된다. 한국의 경우 \(원)
select to_char(12345, 'L999,000') from dual;

/*
숫자 변환함수
    to_number() : 문자형 데이터를 숫자형으로 변환한다. 
*/
--두개의 문자가 숫자로 변환되어 덧셈의 결과가 인출된다. 
select to_number('123') + to_number('456') from dual;


/*
to_date()
    : 문자열 데이터를 날짜형식으로 변환해서 출력해준다. 기본서식은
    년/월/일 순으로 지정된다. 
*/
select
    to_date('2021-10-14') "날짜기본서식1" ,
    to_date('20211014') "날짜기본서식2" ,
    to_date('2021/10/14') "날짜기본서식3"
from dual;

/*
날짜 포맷이 년-월-일 순이 아닌 경우는 오라클이 인식하지 못하여 에러가 
발생된다. 이때는 날짜서식을 이용해서 오라클이 인식할수 있도록 처리해야한다. 
*/
select to_date('14-10-2021') from dual; -- 에러발생
/*
시나리오] 다음에 주어진 날짜형식의 문자열을 실제 날짜로 인식할수
    있도록 쿼리문을 구성하시오.
    '14-10-2021' => 2021-10-14로 인식
    '10-14-2021' => 2021-10-14로 인식
*/
select 
    to_date('14-10-2021', 'dd-mm-yyyy') "날짜서식알려주기1" ,
    to_date('10-14-2021', 'mm-dd-yyyy') "날짜서식알려주기2"
from dual;

/*
시나리오] '2020-10-14 15:51:39' 와 같은 형태의 문자열을 날짜로 인식할수 
    있도록 쿼리문을 구성하시오.
*/
--날짜에는 문제가 없으나 시간이 포함되어 에러발생됨.
select
    to_date('2020-10-14 15:51:39')
from dual;
--방법1 : 날짜부분만 잘라와서 인식시킴
select 
    substr('2020-10-14 15:51:39', 1, 10) "문자열자르기",
    to_date(substr('2020-10-14 15:51:39', 1, 10)) "날짜서식으로변경"
from dual;

/*
퀴즈] 문자열 '2021/05/05'는 어떤 요일인지 변환함수를 통해 출력해보시오.
*/
select
    to_char(sysdate, 'day') "오늘의요일",
    to_date('2021/05/05') "1단계:날짜서식인식",
    to_char(to_date('2021/05/05'), 'dy') "2단계:요일서식적용"
from dual;

/*
퀴즈] 문자열 '2021년01월01일'은 어떤 요일인지 변환함수를 통해 출력해보시오.
    단 문자열은 임의로 변경할 수 없습니다. 
*/
select
    to_date('2021년01월01일', 'yyyy"년"mm"월"dd"일"') "1단계:날짜로변경" ,
    to_char(to_date('2021년01월01일', 'yyyy"년"mm"월"dd"일"'), 'day') "2단계:요일출력",
    to_char(to_date('2021년01월01일', 'yyyy"년"mm"월"dd"일"'), 'dy')
from dual;

/*
시나리오] '2015-10-24 12:34:56' 형태로 주어진 데이터를 인자로하여
    '0000년00월00일 0요일' 형식으로 변환함수를 이용하여 출력하시오.
*/
select
    to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss') "1단계:날짜로변환",
    to_char(to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss'), 
        'yyyy"년"mm"월"dd"일 "dy"요일"') "2단계:결과출력"
from dual;

/*
시나리오] 사원테이블에 사원의 입사일을 요일까지 표현하시오.
*/
select
    first_name, hire_date, to_char(hire_date, 'yyyy"년"mm"월"dd"일 "day')
from employees 
order by hire_date asc;

/*
nvl() : null값을 다른 데이터로 변경하는 함수.
    형식] nvl(컬럼명, 대체할값)
    
    ※레코드를 select해서 웹브라우저에 출력을 하는경우 해당 컬럼이 null이면
    NullPointerException이 발생하게 된다. 그러므로 아예 데이터를 가져올때 null값이 
    나올수 있는 컬럼에 대해 미리 처리하면 예외발생을 미리 차단할수 있으므로 편리하다.
*/
select
    first_name, commission_pct, nvl(commission_pct, 0) AS "보너스율",
    (salary+commission_pct) "결과비정상", (salary+nvl(commission_pct, 0)) "결과비정상"
from employees;


/*
decode() : java의 switch문과 비슷하게 특정값에 해당하는 출력문이
    있는 경우 사용한다. 
    형식] decode(컬럼명, 
                값1, 결과1, 값2, 결과2, .....
                기본값)
    ※내부적인 코드값을 문자열로 변환하여 출력할때 많이 사용된다.                 
*/
/*
시나리오] 사원테이블에서 각 부서에 해당하는 부서명을 출력하는 쿼리문을
    decode를 이용해서 작성하시오.
*/
select
    first_name, last_name, department_id, 
    decode(department_id, 
        10,	'Administration',
        20,	'Marketing',
        30,	'Purchasing',
        40,	'Human Resources',
        50,	'Shipping',
        60,	'IT',
        70,	'Public Relations',
        80,	'Sales',
        90,	'Executive',
        100, 'Finance',
        '부서명확인안됨') AS TeamName
from employees;

/*
case() : java의 if~else문과 비슷한 역할을 하는 함수
    형식] case
            when 조건1 then 값1
            when 조건2 then 값2
            .....
            else 기본값
        end
*/
select
    first_name, last_name, department_id,
    case
        when department_id=10 then 'Administration'
        when department_id=20 then 'Marketing'
        when department_id=30 then 'Purchasing'
        when department_id=40 then 'Human Resources'
        when department_id=50 then 'Shipping'
        when department_id=60 then 'IT'
        when department_id=70 then 'Public Relations'
        when department_id=80 then 'Sales'
        when department_id=90 then 'Executive'
        when department_id=100 then 'Finance'
        else '부서확인안됨'
    end AS TeamName
from employees
order by employee_id asc;


--연습문제
/*
1. substr() 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
*/
select * from emp;
select
    hiredate,
    substr(hiredate, 1, 5) "입사년월1",
    to_char(hiredate, 'yy-mm') "입사년월2"
from emp;

/*
2. substr()함수를 사용하여 4월에 입사한 사원을 출력하시오. 
즉, 연도에 상관없이 4월에 입사한 모든사원이 출력되면 된다.
*/
select * from emp where substr(hiredate, 4, 2)='04';
select * from emp where to_char(hiredate, 'mm')='04';

/*
3. mod() 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
*/
select * from emp where mod(empno, 2)=0;

/*
4. 입사일을 연도는 2자리(YY), 월은 숫자(MON)로 표시하고 
요일은 약어(DY)로 지정하여 출력하시오.
*/
select
    hiredate, 
    to_char(hiredate, 'yy') "입사년도", 
    to_char(hiredate, 'mon') "입사월", 
    to_char(hiredate, 'dy') "입사요일1", 
    to_char(hiredate, 'day') "입사요일2" 
from emp;

/*
5. 올해 며칠이 지났는지 출력하시오. 현재 날짜에서 
올해 1월1일을 뺀 결과를 출력하고 TO_DATE()함수를 사용하여 데이터 형을 일치 시키시오. 
단, 날짜의 형태는 ‘01-01-2020’ 포맷으로 사용한다. 
즉 sysdate - ‘01-01-2020’ 이와같은 연산이 가능해야한다. 
*/
select
    to_date('01-01-2020', 'dd-mm-yyyy') "날짜서식변경",
    sysdate - to_date('01-01-2020', 'dd-mm-yyyy') "날짜의차",
    round(sysdate - to_date('01-01-2020', 'dd-mm-yyyy')) AS "결과1",
    trunc(sysdate - to_date('01-01-2020', 'dd-mm-yyyy')) AS "결과2"
from dual;

/*
6. 사원들의 메니져 사번을 출력하되 상관이 없는 사원에 대해서는 NULL값 대신 0으로 출력하시오.
*/
select 
    ename, nvl(mgr, 0) "메니저사번"
from emp;

/*
7. decode 함수로 직급에 따라 급여를 인상하여 출력하시오. 
‘CLERK’는 200, ‘SALESMAN’은 180, ‘MANAGER’은 150, ‘PRESIDENT’는 100을 인상하여 출력하시오.
*/
select
    ename, sal,
    decode(job,
        'CLERK', sal+200,
        'SALESMAN', sal+180, 
        'MANAGER', sal+150,
        'PRESIDENT', sal+100,
        sal) AS "인상된급여"
from emp;






