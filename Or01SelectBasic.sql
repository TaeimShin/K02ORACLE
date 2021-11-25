/***********************
���ϸ� : Or01SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
���� : select, where �� ���� �⺻���� DQL�� ����غ���
************************/

/*
SQL Developer���� �ּ� ����ϱ�
    �������ּ� : �ڹٿ� ������
    ���δ����ּ� : -- ���๮��. ������ 2���� �������� ���
*/

--select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�. 
/*
����]
    select �÷�1, �÷�2, .....[�Ǵ� *]
    from ���̺��
    where ����1 and ����2 or ����3 .....
    order by �������÷� asc(��������), desc(��������) ;
*/

--������̺� ����� ��� ���ڵ带 ��ȸ�ϱ� 
select * from employees;

/*
�÷����� �����ؼ� �����ڰ� ������� �÷��� ��ȸ�ϱ�
=> �����ȣ, �̸�, �̸���, �μ����̵� ��ȸ�غ���. 
*/
select employee_id, first_name, last_name, email, department_id from employees;

--���̺��� �Ӽ��� �ڷ����� Ȯ���ϴ� ��ɾ�
desc employees;

--�ش� �÷��� number(����)�� ��� ������� ����
select employee_id, first_name, salary, salary+100 from employees;
--���� Ÿ���� �÷������� ���굵 �����ϴ�. 
select employee_id, first_name, salary, commission_pct, salary+commission_pct
    from employees;

/*
AS(�˸��ƽ�) : ���̺� Ȥ�� �÷��� ��Ī(����)�� �ο��Ҷ� ����Ѵ�. 
    ���� ���ϴ� �̸�(����, �ѱ�)���� ������ �� ����� �� �ִ�. 
    Ȱ���] ���� 2�� �̻��� ���̺��� JOIN(����)�ؾ� �� ��� �÷�����
        �ߺ��ɶ� �����ϴ� �뵵�� ����Ѵ�. 
*/
select first_name, salary, salary+100 as "�޿�100����" from employees;
select first_name, salary, salary+100 as salaryUp100 from employees;

--as�� ������ �� �ִ�. 
select employee_id "������̵�", first_name, last_name "��"
    from employees where first_name='William';
    
--����Ŭ�� �⺻������ ��ҹ��ڸ� �������� �ʴ´�. ������ �Ѵ� ����� �� �ִ�. 
SELECT employee_id "�����ȣ", first_name, email
    FROM employees WHERE first_name='Alexander';
--��, ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�. �Ʒ� SQL�������� �ƹ��� ����� ��µ��� �ʴ´�.     
SELECT employee_id "�����ȣ", first_name, email
    FROM employees WHERE first_name='ALEXander';--�̸��� ��ҹ��ڰ� �߸��Էµ�.    

/*
where���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
    : last_name�� Smith�� ���ڵ带 �����Ѵ�. 
    ����] where���� ������ �Է��Ҷ� �÷��� �������̸�
        �̱������̼��� ����ؾ� �Ѵ�. �������� ��� ������ �� �ִ�. 
*/
select * from employees where last_name='Smith'; --2������
select * from employees where last_name='Smith' and salary=8000; --1������
select * from employees where last_name='Smith' or salary=8000;--4������

/*
�񱳿����ڸ� ���� �����ۼ�
    : �̻�, ���Ͽ� ���� ���ǿ� >, <= �� ���� �񱳿����ڸ� ����Ҽ� �ִ�. 
    ��¥�� ��� ������ ��¥�� ���� ���ǵ� �����ϴ�. 
*/
--�޿��� 5000�̸��� ����� ������ �����Ͻÿ�.
select * from employees where salary<5000;
--�Ի����� 04��01��01�� ������ ��� ������ �����Ͻÿ�
select * from employees where hire_date>='04/01/01';

/*
in������ : or �����ڿ� ����� ������� �ϳ��� �÷��� ����������
    ������ �ɰ������ ����ϴ� ������
    �޿��� 4200, 6400, 8000�� ������ ������ ��ȸ�Ͻÿ�.
*/
--���1 : or�� ����Ѵ�. �÷����� �ݺ������� ����ؾ� �Ѵ�.
select * from employees where salary=4200 or salary=6400 or salary=8000;
--���2 : in�� ����ϸ� �÷��� �ѹ��� ����ϸ� �ǹǷ� ���ϴ�.
select * from employees where salary in (4200, 6400, 8000);


/*
not������ : �ش� ������ �ƴ� ���ڵ带 �����´�. 
    �μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�Ͻÿ�.
*/
select * from employees where department_id<>50;
select * from employees where not (department_id=50);


/*
between and ������ : �÷��� ������ ���� �˻��Ҷ� ����Ѵ�. 
    �޿��� 4000~8000 ������ ��������� ��ȸ�Ͻÿ�.
*/
select * from employees where salary>=4000 and salary<=8000; 
select * from employees where salary between 4000 and 8000;

/*
distinct : �÷����� �ߺ��Ǵ� ���ڵ带 �����Ҷ� ����Ѵ�. 
    Ư�� �������� select������ �ϳ��� �÷����� �ߺ��Ǵ� ����
    �ִ°�� �ߺ����� ������ �� ����� ����� �� �ִ�. 
*/
select job_id from employees;
select distinct job_id from employees;

/*
like������ : Ư�� Ű���带 ���� ���ڿ� �˻��ϱ�
    ����) �÷��� like '%�˻���%'
    ���ϵ�ī�� ����
        % : ��� ���� Ȥ�� ���ڿ��� ��ü�Ѵ�. 
        Ex) D�� �����ϴ� �ܾ� : D% -> Da, Dae, Daewoo
            Z�� ������ �ܾ� : %Z -> aZ, abcZ
            C�� ���ԵǴ� �ܾ� : %C% -> aCb, abCde, Vitamin-C
        _ : ����ٴ� �ϳ��� ���ڸ� ��ü�Ѵ�. 
        Ex) D�� �����ϴ� 3������ �ܾ� : D__ -> Dab , Ddd, Dxy
            A�� �߰��� ���� 3������ �ܾ� : _A_ -> aAa, xAy
*/
--first_name�� 'D'�� �����ϴ� ������ �˻��Ͻÿ�.
select * from employees where first_name like 'D%';
--first_name�� ����° ���ڰ� 'a'�� ������ �����Ͻÿ�.
select * from employees where first_name like '__a%';
--last_name���� 'y'�� ������ ������ �����Ͻÿ�.
select * from employees where last_name like '%y';
--��ȭ��ȣ�� 1344�� ���Ե� ���� ��ü�� �˻��Ͻÿ�.
select * from employees where phone_number like '%1344%';


/*
���ڵ� �����ϱ�(Sorting)
    ������������ : order by �÷��� asc (Ȥ�� ��������)
    ������������ : order by �÷��� desc
    
    2�� �̻��� �÷����� �����ؾ� �� ��� �޸��� �����ؼ� �����Ѵ�. 
    ��, �̶� ���� �Է��� �÷����� ���ĵ� ���¿��� �ι�° �÷��� ���ĵȴ�. 
*/
/*
������� ���̺��� �޿��� ������������ ���������� �������� �����Ͽ� ��ȸ�Ͻÿ�
������÷� : first_name, salary, email, phone_number
*/
select first_name, salary, email, phone_number from employees
    order by salary asc;

/*
�μ���ȣ�� ������������ ������ �� �ش� �μ����� ���� �޿��� �޴� ������
���� ��µǵ��� �ϴ� SQL���� �ۼ��Ͻÿ�
����׸� : �����ȣ, �̸�, ��, �޿�, �μ���ȣ
*/
select employee_id, first_name, last_name, salary, department_id
    from employees
    order by department_id desc, salary asc;

/*
is null Ȥ�� is not null
    : ���� null�̰ų� null�� �ƴ� ���ڵ� ��������
    �÷��� null���� ����ϴ� ��� ���� �Է����� ������ null���� 
    �Ǵµ� �̸� ������� select�Ҷ� ����Ѵ�. 
*/
--���ʽ����� ���� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is null;
--���ʽ����� �ִ� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is not null;
--��������̸鼭 �޿��� 8000�̻��� ����� ��ȸ�Ͻÿ�
select * from employees where salary>=8000 and commission_pct is not null;





/*****************************
��������
******************************/
/*
1. ���� �����ڸ� �̿��Ͽ� ��� ����� ���ؼ� $300�� �޿��λ��� ������� 
�̸�, �޿�, �λ�� �޿��� ����Ͻÿ�.
*/
select * from emp;
select ename, sal, (sal+300) AS RiseSalary from emp;

/*
2. ����� �̸�, �޿�, ������ ������ �����ͺ��� ���������� ����Ͻÿ�. 
������ ���޿� 12�� ������ $100�� ���ؼ� ����Ͻÿ�.
*/
select ename, sal, (sal*12+100) "����" from emp;
--���Ľ� ���������� �����ϴ� �÷����� ����ϴ°� �⺻�̴�. 
select ename, sal, (sal*12+100) "����" from emp order by sal desc;
--���������� �������� �ʴ� �÷��̶�� ���� �״�θ� order by ���� ����Ѵ�. 
select ename, sal, (sal*12+100) "����" from emp order by (sal*12+100) desc;
select ename, sal, (sal*12+100) "����" from emp order by "����" desc;

/*
3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�
*/
select ename, sal from emp 
    where sal > 2000
    order by ename desc, sal desc;

/*
4. �����ȣ��  7782�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
*/
select ename, deptno from emp where empno=7782;


/*
5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�.
*/
select ename, sal from emp where not (sal>=2000 and sal<=3000);
select ename, sal from emp where not (sal between 2000 and 3000);

/*
6. �Ի����� 81��2��20�� ���� 81��5��1�� ������ ����� �̸�, ������, �Ի����� ����Ͻÿ�.
*/
select ename, job, hiredate from emp
    where hiredate>='81/02/20' and hiredate<='81/05/01';
select ename, job, hiredate from emp
    where hiredate between '81/02/20' and '81/05/01';

/*
7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� 
�̸��� ����(��������)���� ����Ͻÿ�
*/
select ename, deptno from emp where deptno=20 or deptno=30 order by ename desc;
select ename, deptno from emp where deptno in (20,30) order by ename desc;

/*
8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� 
�μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� 
�̸���(��������)���� ����Ͻÿ�
*/
select ename, sal, deptno from emp 
    where (sal between 2000 and 3000) and deptno in (20,30)
    order by ename asc;

/*
9. 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. (like �����ڿ� ���ϵ�ī�� ���)
*/
select ename, sal, hiredate from emp where hiredate like '81%';

/*
10. �����ڰ� ���� ����� �̸��� �������� ����Ͻÿ�. 
*/
select ename, job from emp where mgr is null;

/*
11. Ŀ�̼��� ������ �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� 
�޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ����Ͻÿ�.
*/
select ename, sal, comm from emp
    where comm is not null
    order by sal desc, comm desc;

/*
12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp where ename like '__R%';--���� ���� %�� ������ �������� ���ڵ常 �˻��Ѵ�.

/*
13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp where ename like '%A%' and ename like '%E%';
/*
�Ʒ��� ���� ��� A�� E�� ���ԵǱ� �ϳ� ������ �����Ƿ� E�� �����ϰ� A�� ������
�̸��� �˻����� �ʴ´�. */
--select ename from emp where ename like '%A%E%';

/*
14. �������� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭 
�޿��� $1600, $950, $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 
*/
select ename, job, sal from emp
    where job in ('CLERK','SALESMAN') and sal not in (1600, 950, 1300);

/*
15. Ŀ�̼��� $500 �̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�. 
*/
select ename, sal, comm from emp where comm>=500;



