/*********************
���ϸ� : Or09Join.sql
���̺�����
���� : �ΰ� �̻��� ���̺��� ���ÿ� �����Ͽ� �����͸� �����;� �Ҷ� 
����ϴ� SQL��
**********************/

/*
1] inner join (��������)
-���� ���� ���Ǵ� ���ι����� ���̺��� ���������� ��� �����ϴ�
    ���� �˻��Ҷ� ���ȴ�. 
-�Ϲ������� �⺻Ű(primary key) �� �ܷ�Ű(foreign key)�� ����Ͽ�
    join�ϴ� ��찡 ��κ��̴�. 
-�� ���� ���̺� ������ �̸��� �÷��� �����ϸ� "���̺��.�÷���"
    ���·� ����ؾ� �Ѵ�. 
-���̺��� ��Ī�� ����ϸ� "��Ī.�÷���" ���·� ����� �� �ִ�. 

����1(ANSI ǥ�ع��)
    select
        �÷�1, �÷�2,...
    from ���̺�1 inner join ���̺�2
        on ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű�÷�
    where
        ����1 and ����2 ....;
*/


/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
--�����߻� : column ambiguously defined. ���� ���ǰ� �ָ���.
/*
    department_id �÷��� ��� ���� ��� ���̺� �����ϴ� �÷��̹Ƿ�
    � ���̺��� ������ ������� �����ؾ� �Ѵ�. 
*/
select
    employee_id, first_name, last_name, email,
    department_id, department_name
from employees inner join departments 
    on employees.department_id=departments.department_id ;

--�μ����̺��� �������� ���� departments.department_id�� �����.
select
    employee_id, first_name, last_name, email,
    departments.department_id, department_name
from employees inner join departments 
    on employees.department_id=departments.department_id ;    
    
--as(�˸��ƽ�)�� ���� ��Ī���� �������� ����ȭ �Ҽ��ִ�.     
select
    employee_id, first_name, last_name, email,
    dep.department_id, department_name
from employees emp inner join departments dep
    on emp.department_id=dep.department_id ;/*
        �μ���ȣ�� ���� ����� 1�� �����ϹǷ� Join�� �����
        107���� �ƴ� 106���� ������ �ȴ�. 
    */    
    
--3�� �̻��� ���̺� ����
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�. 
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
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
����2(����Ŭ ���)
    select
        �÷�1, �÷�2, .... �÷�N
    from 
        ���̺�1, ���̺�2
    where
        ���̺�1.�÷�=���̺�2.�÷�
        and ����1 or ����2 ... ����N;
*/
    
/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ����Ŭ ������� �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select
    employee_id, first_name, last_name, email, emp.department_id, department_name
from employees emp, departments dep
where emp.department_id=dep.department_id;
    
    
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� ����Ŭ ������� �ۼ��Ͻÿ�. 
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
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
2] outer join (�ܺ�����)
outer join�� inner join���� �޸� �� ���̺� ���������� ��Ȯ��
��ġ���� �ʾƵ� ������ �Ǵ� ���̺��� ������� �������� join����̴�. 
outer join�� ����Ҷ��� �ݵ�� outer���� ������ �Ǵ� ���̺��� 
�����ϰ� ����ؾ� �Ѵ�. 
    -> left(�������̺�), right(���������̺�), full(�������̺�)

����1(ǥ�ع��)
    select �÷�1, �÷�2 ....
    from ���̺�1 
        left[right, full] outer join ���̺�2
            on ���̺�1.�⺻Ű=���̺�2.����Ű
    where ����1 and ����2 or ����3;
*/
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(left)��
    ���� ����Ͻÿ�.
*/
select
    employee_id, first_name, last_name, D.department_id, city
from employees E
    left outer join departments D
        on E.department_id=D.department_id
    left outer join locations L
        on D.location_id=L.location_id;

--�� �ó������� ���̺��� ������ġ�� right�� �����ؼ� �����غ���.
select
    employee_id, first_name, last_name, D.department_id, city
from employees E
    right outer join departments D
        on E.department_id=D.department_id
    right outer join locations L
        on D.location_id=L.location_id;
--left Ȥ�� right�� ���� ������ �Ǵ� ���̺��� �޶����� ����Ǵ� ����� �޶�����. 

/*
����2(����Ŭ ���)
    select
        �÷�1, �÷�2, .... �÷�N
    from 
        ���̺�1, ���̺�2
    where
        ���̺�1.�÷�=���̺�2.�÷�(+)
        and ����1 or ����2 ... ����N;
    => ����Ŭ ������� ����ÿ��� outer join�������� (+)�� �ٿ��ָ� �ȴ�. 
    => ���� ��� ���� ���̺��� ������ �ȴ�. 
*/

/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(left)��
    ���� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
*/
select
    employee_id, first_name, last_name, dep.department_id, department_name,
    city, state_province
from employees emp, departments dep, locations loc
where 
    emp.department_id=dep.department_id(+)
    and dep.location_id=loc.location_id(+);
    

/*
�ó�����] 2007�⿡ �Ի��� ����� ��ȸ�Ͻÿ�. ��, �μ��� ��ġ���� ���� 
������ ��� <�μ�����> ���� ����Ͻÿ�. 
����׸� : ���, �̸�, ��, �μ���
*/
--�ϴ� ���ڵ� Ȯ��
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees;
--2007�⿡ �Ի��� ��� ����. �μ���ȣ���� Ȯ��.
select first_name, hire_date, department_id from employees 
    where to_char(hire_date, 'yyyy')='2007';
--�ܺ��������� ��� Ȯ��
select
    employee_id, first_name, last_name, nvl(department_name,'<�μ�����>') dep_name
from employees E left outer join departments D
    on E.department_id=D.department_id
where 
    to_char(hire_date, 'yyyy')='2007';

 


/*
3] self join (��������)
���������� �ϳ��� ���̺� �ִ� �÷����� �����ؾ� �ϴ� ���
����Ѵ�. �� �ڱ��ڽ��� ���̺�� ������ �δ°��̴�. 
�������ο����� ��Ī�� ���̺��� �����ϴ� �������� ������ �ϹǷ�
������ �߿��ϴ�. 

����]
    select 
        ��Ī1.�÷�, ��Ī2.�÷� ....
    from    
        ���̺� ��Ī1, ���̺� ��Ī2
    where
        ��Ī1.�÷�=��Ī2.�÷� ;
*/

/*
�ó�����] ������̺��� �� ����� �޴������̵�� �޴����̸��� ����Ͻÿ�.
    ��, �̸��� fist_name�� last_name�� �ϳ��� �����ؼ� ����Ͻÿ�.
*/
select
    empClerk.employee_id "�����ȣ",
    (empClerk.first_name||' '||empClerk.last_name) "����̸�",
    empManager.employee_id "�޴��������ȣ",
    concat(empManager.first_name||' ', empManager.last_name) "�޴����̸�"
from 
    employees empClerk , employees empManager
where
    empClerk.manager_id=empManager.employee_id ;

/*
�ó�����] self join�� ����Ͽ� "Kimberely / Grant" ������� �Ի����� ����
    ����� �̸��� �Ի����� ����Ͻÿ�. 
    ��¸�� : first_name, last_name, hire_date
*/
--1.Kimberely �� ����Ȯ��
select * from employees where first_name='Kimberely' and last_name='Grant';
--2.07/05/24 ���Ŀ� �Ի��� �������� ����
select * from employees where hire_date>'07/05/24';
--3.self join���� �������� ��ħ
select
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
from employees Kimberely , employees Clerk
where
    Kimberely.hire_date<Clerk.hire_date
    and Kimberely.first_name='Kimberely' and Kimberely.last_name='Grant';



/*
using : join������ �ַ� ����ϴ� on���� ��ü�� �� �ִ� ����
    ����] on ���̺�1.�÷�=���̺�2.�÷�
        ==> using(�÷�)
*/

/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� using�� ����ؼ� �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
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
    using ���� ���� �ĺ��� �÷��� ��� select������ ���̺��� ��Ī��
    ���̸� ������ �߻��Ѵ�. 
    using���� ���� �÷��� ��, ������ ���̺� ���ÿ� �����ϴ� �÷��̶��
    ���� ����� �ۼ��Ǳ� ������ ���� ��Ī�� �ٿ��� ������ ���� �����̴�. 
*/

/*
 ����] 2005�⿡ �Ի��� ������� California(STATE_PROVINCE) / 
 South San Francisco(CITY)���� �ٹ��ϴ� ������� ������ ����Ͻÿ�.
 ��, ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�.
 
 ��°��] �����ȣ, �̸�, ��, �޿�, �μ���, �����ڵ�, ������(COUNTRY_NAME)
        �޿��� ���ڸ����� �ĸ��� ǥ���Ѵ�. 
 ����] '������'�� countries ���̺� �ԷµǾ��ִ�. 
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
---------��������
/*
1. inner join ����� ����Ŭ����� ����Ͽ� first_name �� Janette �� 
����� �μ�ID�� �μ����� ����Ͻÿ�.
��¸��] �μ�ID, �μ���
*/
select
    D.department_id, department_name
from employees E, departments D
where
    E.department_id=D.department_id 
    and first_name='Janette';


/*
2. inner join ����� SQLǥ�� ����� ����Ͽ� ����̸��� �Բ� �� ����� 
�Ҽӵ� �μ���� ���ø��� ����Ͻÿ�
��¸��] ����̸�, �μ���, ���ø�
*/
select
    first_name, last_name, department_name, city
from employees E 
    inner join departments D
        on E.department_id=D.department_id
    inner join locations L
        on D.location_id=L.location_id;            


/*
3. ����� �̸�(FIRST_NAME)�� 'A'�� ���Ե� ������� �̸��� �μ����� ����Ͻÿ�.
��¸��] ����̸�, �μ���
*/
select
    first_name, last_name, department_name
from employees E, departments D
where E.department_id=D.department_id
    and first_name like '%A%';
    

/*
4. ��city : Toronto / state_province : Ontario�� ���� �ٹ��ϴ� ��� 
����� �̸�, ������, �μ���ȣ �� �μ����� ����Ͻÿ�.
��¸��] �̸�, ������, �μ�ID, �μ���
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
5. Equi Join�� ����Ͽ� Ŀ�̼�(COMMISSION_PCT)�� �޴� ��� ����� 
�̸�, �μ���, ���ø��� ����Ͻÿ�. 
��¸��] ����̸�, �μ�ID, �μ���, ���ø�
*/
select
    first_name, last_name, D.department_id, department_name, city
from employees E
    inner join departments D on E.department_id=D.department_id
    inner join locations L on D.location_id=L.location_id
where
    commission_pct is not null;


/*
6. inner join�� using �����ڸ� ����Ͽ� 50�� �μ�(DEPARTMENT_ID)�� 
���ϴ� ��� ������(JOB_ID)�� �������(distinct)�� �μ��� ���ø�(CITY)�� 
�����Ͽ� ����Ͻÿ�.
��¸��] ������ID, �μ�ID, �μ���, ���ø�
*/
select
    distinct job_id, department_id, department_name, city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
where 
    department_id=50;


/*
7. ������ID�� FI_ACCOUNT�� ������� �޴����� �������� ����Ͻÿ�. 
��, ���ڵ尡 �ߺ��ȴٸ� �ߺ��� �����Ͻÿ�. 
��¸��] �̸�, ��, ������ID, �޿�
*/
--�������� FI_ACCOUNT�� ������� �޴��� ���̵� ��ȸ
select employee_id, first_name, manager_id 
    from employees where job_id='FI_ACCOUNT';
--�޴��� ���̵� 108�̹Ƿ� �����ȣ�� ��ȸ    
select first_name from employees where employee_id=108;    
--���������� ���ؼ� �ش� ����� �޴��� ������ ����Ѵ�. 
select
    distinct eMgr.first_name, eMgr.last_name, eMgr.job_id, eMgr.salary
from employees eClerk, employees eMgr
where eClerk.manager_id=eMgr.employee_id 
    and eClerk.job_id='FI_ACCOUNT';


/*
8. �� �μ��� �޴����� �������� ����Ͻÿ�. ��°���� �μ���ȣ�� �������� �����Ͻÿ�.
��¸��] �μ���ȣ, �μ���, �̸�, ��, �޿�, ������ID
�� departments ���̺� �� �μ��� �޴����� �ֽ��ϴ�.
*/
select
    E.department_id, department_name, first_name, last_name, salary, job_id
from departments D, employees E
where
    D.manager_id=E.employee_id
order by department_id asc;


/*
9. ���������� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� 
��� �޿��� ����Ͻÿ�. ��½� �⵵�� �������� �������� �����Ͻÿ�. 
����׸� : �Ի�⵵, ��ձ޿�
*/
select * from jobs where job_title='Sales Manager';
select * from employees where job_id='SA_MAN';
select hire_date, to_char(hire_date, 'yyyy') from employees where job_id='SA_MAN';    

select to_char(hire_date, 'yyyy') , avg(salary)
    from employees inner join jobs using(job_id)
    where job_title='Sales Manager'
    group by to_char(hire_date, 'yyyy')
    order by to_char(hire_date, 'yyyy') asc;




    
    
    