/*****************************
���ϸ� : Or06GroupBy.sql
�׷��Լ�(select�� 2��°)
���� : ��ü ���ڵ�(�ο�)���� ������� ����� ���ϱ� ���� �ϳ� �̻���
    ���ڵ带 �׷����� ��� ������ ����� ��ȯ�ϴ� �Լ� Ȥ�� ������
*******************************/

/*
distinct 
    - �ߺ��Ǵ� ���ڵ带 ������ �� �ϳ��� ���ڵ常 �����ͼ� �����ش�.
    - ���� ������� �����͸� ����� �� ����.
*/
select distinct job_id from employees;

/*
group by
    - ������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����´�. 
    - �������°� �ϳ��� ���ڵ����� �������� ���ڵ尡 ������ ����̹Ƿ�
        ������� �����͸� ����� �� �ִ�. 
    -�ִ�, �ּ�, ���, �ջ� ���� ������ �Ҽ� �ִ�. 
*/
select job_id from employees group by job_id;

/*
�׷��Լ��� �⺻����

    select
        �÷�1, �÷�2,... Ȥ�� *(��ü)
    from
        ���̺�
    [where
        ����1 or ����2 and ����3 ...]    
    [group by
        ������ �׷�ȭ�� ���� �÷���]
    [having
        �׷쿡�� ã�� ����] 
    [order by
        ���ڵ� ������ ���� �÷��� ���Ĺ��]
    
    �� ������ �������
    from -> where -> group by -> having -> select -> order by
*/


/*
sum() : �հ踦 ���Ҷ� ����ϴ� �Լ�
    -number Ÿ���� �÷������� ����� �� �ִ�. 
    -�ʵ���� �ʿ��� ��� as�� �̿��ؼ� ��Ī�� �ο��Ҽ� �ִ�.
*/
--��ü������ �޿��� �հ踦 ����Ͻÿ�.
select
    sum(salary) "�޿���1",
    to_char(sum(salary), '999,000') "�޿���2"
from employees;

--10���μ��� �ٹ��ϴ� ������� �޿��հ�� ������ ����Ͻÿ�.
select
    sum(salary),
    to_char(sum(salary), '999,999'),
    ltrim(to_char(sum(salary), '999,999')),
    ltrim(to_char(sum(salary), 'L999,999'))
from employees
where department_id=10;

--sum()�� ���� �׷��Լ��� numberŸ���� �÷������� ����Ҽ��ִ�.
select sum(first_name) from employees;--�����߻�


/*
count() : ���ڵ��� ������ ī��Ʈ�Ҷ� ����ϴ� �Լ�
*/
--������̺� ����� ��ü ������� ����ΰ�?
select count(*) from employees;--���1 : �������
select count(employee_id) from employees;--���2 : ��������� �ƴ�
select count(first_name) from employees;--count()�Լ��� ����Ÿ���� �÷��� ��밡��
/*
    count()�Լ��� ����Ҷ��� �� 2���� ��� ��� ����������
    *�� ����Ұ��� �����Ѵ�. �÷��� Ư�� Ȥ�� �����Ϳ� ���� 
    ���ظ� ���� �����Ƿ� �˻��ӵ��� �ξ� ������.
*/

/*
count()�Լ��� 
    ����1 : count(all �÷���)
        => ����Ʈ �������� �÷� ��ü�� ���ڵ带 �������� ī��Ʈ�Ѵ�. 
    ����2 : count(distinct �÷���)
        -> �ߺ��� ������ ���¿��� ī��Ʈ �Ѵ�. 
*/
select
    count(job_id) "��������ü����1",
    count(all job_id) "��������ü����2",
    count(distinct job_id) "��������������"
from employees;


/*
avg() : ��հ��� ���Ҷ� ����ϴ� �Լ�
*/
--��ü����� ��ձ޿��� �������� ����ϴ� �������� �ۼ��Ͻÿ�.
select
    count(*) "�����", 
    sum(salary) "�޿����հ�",
    sum(salary) / count(*) "��ձ޿�1",
    avg(salary) "��ձ޿�2",
    trim(to_char(avg(salary), '$999,000')) "��ձ޿�3"
from employees;

--�������� ��ձ޿��� ���ΰ���?
--1.�μ����̺��� �������� �μ���ȣ�� �������� Ȯ���Ѵ�. 
select * from departments where lower(department_name)='sales';
select * from departments where department_name=initcap('sales');
/*
    �����˻��� ��ҹ��� Ȥ�� ������ ���Ե� ��� ��� ���ڵ忡 ����
    ���ڿ��� Ȯ���ϴ°��� �Ұ����ϹǷ� �ϰ����� ��Ģ�� ���� upper()��
    ���� ��ȯ�Լ��� ����Ͽ� �˻��ϴ°��� ����.
*/
select
    avg(salary),
    to_char(avg(salary), '$999,000.00')
from employees
where department_id=80;


/*
min(), max() �Լ� : �ִ밪, �ּҰ��� ã���� ����ϴ� �Լ�
*/
--������̺��� ���� ���� �޿��� ���ΰ���?
select min(salary) from employees;

--������̺��� ���� ���� �޿��� �޴� ����� �����ΰ���??
select * from employees where salary=2100;/* ������ ���� �޿��� �ּҰ��� �������� 
                                            �ٽ��ѹ� select�ؾ��Ѵ�. */
/*
    ����� ���� ���� �޿��� min()���� ���Ҽ� ������ 
    ���� ���� �޿��� �޴� ����� �Ʒ��� ���� ���������� ����
    ���� �� �ִ�. 
    ���� ������ ���� ���������� ������� ���θ� �����ؾ� �Ѵ�.
*/
select * from employees where salary=(select min(salary) from employees);


/*
group by�� : �������� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� ������
    ����� ��ȯ�ϴ� ������.
    �� distinct �� �ܼ��� �ߺ����� ������.
*/
--������̺��� �� �μ��� �޿��� �հ�� ���ΰ�?
--step1 : �� �μ��� �׷�ȭ �ϱ�
select department_id from employees
    group by department_id;
--step2 : �� �μ����� �޿��հ� ���ϱ�
select department_id , sum(salary), to_char(sum(salary),'$999,000')
    from employees
    group by department_id
    order by sum(salary) desc;

/*
����] ������̺��� �� �μ��� ������� ��ձ޿��� ������
    ����ϴ� �������� �ۼ��Ͻÿ�.
    ��°�� : �μ���ȣ, �޿�����, �������, ��ձ޿�
        �μ���ȣ ������� �������� �����Ͻÿ�.
*/
select
    department_id "�μ���ȣ",
    sum(salary) "�޿�����",
    count(*) "�������",
    to_char(avg(salary), '999,000.00') "��ձ޿�"
from employees
group by department_id
order by department_id asc;

/*
������ ����ߴ� �������� �Ʒ��� ���� �����ϸ� ������ �߻��Ѵ�. 
group by������ ����� �÷��� select������ ����� �� ������, 
�׿��� �����÷��� select������ ����� �� ����. 
�׷�ȭ�� ���¿��� Ư�� ���ڵ� �ϳ��� �����ϴ°��� �ָ��ϹǷ� ������ �߻��Ѵ�. 
*/
select
    department_id "�μ���ȣ",
    sum(salary) "�޿�����",
    first_name
from employees
group by department_id
order by department_id asc;

--�μ��� �޿��� �հ�� distinct�� ���� �ۼ��� �� ����. 
select distinct department_id, sum(salary) from employees;



/*
�ó�����] �μ����̵� 50�� ������� ��������, ��ձ޿�, �޿�������
    ������ ����ϴ� �������� �ۼ��Ͻÿ�.
*/
select
    department_id "�μ���ȣ",
    count(*) "������",
    trim(to_char(avg(salary), '999,000.00')) "��ձ޿�", 
    trim(to_char(sum(salary), '9,999,000')) "�޿�����"
from employees
where department_id=50
group by department_id;


/*
having�� : ���������� �����ϴ� �÷��� �ƴ� �׷��Լ��� ���� ��������
    ������ �÷��� ������ �߰��Ҷ� ����Ѵ�. 
    �ش� ������ where���� �߰��ϸ� ������ �߻��Ѵ�.
*/
/*
�ó�����] ������̺��� �� �μ����� �ٹ��ϰ� �ִ� ������ �������� �������
    ��ձ޿��� �������� ����ϴ� �������� �ۼ��Ͻÿ�.
    ��, ����� ������ 10���� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�. 
*/
select
    department_id "�μ���ȣ", job_id "������",
    count(*) "�����", avg(salary) "��ձ޿�"
from employees
group by department_id, job_id
--where count(*)>10; /* ������� ���������� �������� �����Ƿ� where���� ���� �����߻� */
having count(*)>10 /* �̿� ���� ��� having���� ������ �߰��ؾ� �Ѵ�. */
order by department_id asc;


/*
����] �������� ����� �����޿��� ����Ͻÿ�.
    ��, �����ڰ� ���� ����� �����޿��� 3000�̸��� �׷��� ���ܽ�Ű��
    ����� �޿��� ������������ �����Ͽ� ����Ͻÿ�. 
*/
select
    job_id, min(salary)
from employees 
where manager_id is not null  
group by job_id
having not min(salary)<3000
order by min(salary) desc;







--------------------------------------------------
----��������

/*
1. ��ü ����� �޿��ְ��, ������, ��ձ޿��� ����Ͻÿ�. �÷��� ��Ī�� 
�Ʒ��� ���� �ϰ�, ��տ� ���ؼ��� �������·� �ݿø� �Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
*/
select      
    max(salary) MaxPay, min(salary) MinPay, round(avg(salary)) AvgPay
from employees;
/*
    �� �������� ��� �׷��Լ��� ���� ����� ����ϰ� �����Ƿ� 
    select ���� first_name �� ���� �������� ����� �� ����. 
*/




/*
2. �� ������ �������� �޿��ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. 
�÷��� ��Ī�� �Ʒ��� �����ϰ� ��� ���ڴ� to_char�� �̿��Ͽ� ���ڸ����� 
�ĸ��� ��� �������·� ����Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
�޿��Ѿ� -> SumPay
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
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
    group by ������ �׷��� ���� ���� ����� job_id �÷���
    select������ ����� �� �ִ�. 
*/


/*
3. count() �Լ��� �̿��Ͽ� �������� ������ ������� ����Ͻÿ�.
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
select
    job_id, count(*) "�����"
from employees
group by job_id
--order by count(*) desc;
order by "�����" desc;


/*
4. �޿��� 10000�޷� �̻��� �������� �������� �հ��ο����� ����Ͻÿ�.
*/
select
    job_id, count(*) "�������ο��հ�"
from employees where salary>=10000
group by job_id;



/*
5. �޿��ְ�װ� �������� ������ ����Ͻÿ�. 
*/
select max(salary)-min(salary) from employees;


/*
6. �� �μ��� ���� �μ���ȣ, �����, �μ� ���� ��� ����� ��ձ޿��� 
����Ͻÿ�. ��ձ޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�.
*/
select
    department_id "�μ���ȣ", 
    count(*) "�����", 
    trim(to_char(round(avg(salary), 2), '999,000.00')) "��ձ޿�"
from employees
group by department_id
order by department_id asc;






