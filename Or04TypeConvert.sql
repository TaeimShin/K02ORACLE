/**********************************
���ϸ� : Or04TypeConvert.sql
����ȯ�Լ� / ��Ÿ�Լ�
���� : ������Ÿ���� �ٸ� Ÿ������ ��ȯ�ؾ� �Ҷ� ����ϴ� �Լ��� ��Ÿ�Լ�
***********************************/

/*
sysdate : ���糯¥�� �ð��� �ʴ����� ��ȯ���ش�. �ַ� �Խ��ǿ���
    ���ο� �������� ������ �Է��� ��¥�� ǥ���ϱ� ���� ���ȴ�. 
*/
select sysdate from dual;
/*
��¥���� : ��ҹ��ڸ� �������� �ʴ´�. ���� mm�� MM�� ������ ����� ����Ѵ�. 
*/
select to_char(sysdate, 'yyyy/mm/dd') "���ó�¥" from dual;
select to_char(sysdate, 'YY-MM-DD') "���ó�¥" from dual;

--���糯¥�� "������ 0000��00��00�� �Դϴ�" �� ���� ���·� ����Ͻÿ�.
select
    to_char(sysdate, '������ yyyy��mm��dd�� �Դϴ�') "�����ɱ�?"
from dual;--�����߻� : ��¥������ ��������.

--���Ĺ��ڸ� ������ ������ ���ڿ��� ���������̼����� �����ش�. 
select
    to_char(sysdate, '"������ "yyyy"��"mm"��"dd"�� �Դϴ�"') "�����ȴ�"
from dual;

select  
    to_char(sysdate, 'day') "����(�����)",
    to_char(sysdate, 'dy') "����(��)",
    to_char(sysdate, 'mon') "��(10��)",
    to_char(sysdate, 'mm') "��(10)",
    to_char(sysdate, 'month') "��(10��)",
    to_char(sysdate, 'yy') "���ڸ��⵵",
    to_char(sysdate, 'dd') "�������ڷ�ǥ��",
    to_char(sysdate, 'ddd') "1���߸��°��"
from dual;

/* �ð� ���� */
--����ð��� 00:00:00 ���·� ǥ���ϱ�(��ҹ��� ���о���)
select
    to_char(sysdate, 'HH:MI:SS') ,
    to_char(sysdate, 'hh:mi:ss') 
from dual;
--���糯¥�� �ð��� �Ѳ����� ǥ���ϱ�
select
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "����ð�"
from dual;



/*
��������
    0 : ������ �ڸ����� ��Ÿ���� �ڸ����� ���� �ʴ°��
        0���� �ڸ��� ä���. 
    9 : 0�� ����������, �ڸ����� �����ʴ� ��� �������� ä���. 
*/
select
    to_char(123, '0000') "���Ĺ���0���", /* �տ� 0�� ���ͼ� �̻��� */
    to_char(123, '9999') "���Ĺ���9���" /* �տ� ������ �־� �̻��� */
from dual;
--���ڿ� ���ڸ����� �ĸ� ǥ���ϱ�
select
    12345, 
    to_char(12345, '000,000'),
    to_char(12345, '999,999'),
    to_char(1000000, '999,999,000'),
    ltrim(to_char(1000000, '999,999,000')) "������������",
    ltrim(to_char(10000000, '999,999,000')) "������������"
from dual;--����Ŭ������ �Լ��� 2���̻� ��ø�ؼ� ����Ҽ� �ִ�. 

--��ȭǥ�� : L => �� ���� �´� ��ȭǥ�ð� �ȴ�. �ѱ��� ��� \(��)
select to_char(12345, 'L999,000') from dual;

/*
���� ��ȯ�Լ�
    to_number() : ������ �����͸� ���������� ��ȯ�Ѵ�. 
*/
--�ΰ��� ���ڰ� ���ڷ� ��ȯ�Ǿ� ������ ����� ����ȴ�. 
select to_number('123') + to_number('456') from dual;


/*
to_date()
    : ���ڿ� �����͸� ��¥�������� ��ȯ�ؼ� ������ش�. �⺻������
    ��/��/�� ������ �����ȴ�. 
*/
select
    to_date('2021-10-14') "��¥�⺻����1" ,
    to_date('20211014') "��¥�⺻����2" ,
    to_date('2021/10/14') "��¥�⺻����3"
from dual;

/*
��¥ ������ ��-��-�� ���� �ƴ� ���� ����Ŭ�� �ν����� ���Ͽ� ������ 
�߻��ȴ�. �̶��� ��¥������ �̿��ؼ� ����Ŭ�� �ν��Ҽ� �ֵ��� ó���ؾ��Ѵ�. 
*/
select to_date('14-10-2021') from dual; -- �����߻�
/*
�ó�����] ������ �־��� ��¥������ ���ڿ��� ���� ��¥�� �ν��Ҽ�
    �ֵ��� �������� �����Ͻÿ�.
    '14-10-2021' => 2021-10-14�� �ν�
    '10-14-2021' => 2021-10-14�� �ν�
*/
select 
    to_date('14-10-2021', 'dd-mm-yyyy') "��¥���ľ˷��ֱ�1" ,
    to_date('10-14-2021', 'mm-dd-yyyy') "��¥���ľ˷��ֱ�2"
from dual;

/*
�ó�����] '2020-10-14 15:51:39' �� ���� ������ ���ڿ��� ��¥�� �ν��Ҽ� 
    �ֵ��� �������� �����Ͻÿ�.
*/
--��¥���� ������ ������ �ð��� ���ԵǾ� �����߻���.
select
    to_date('2020-10-14 15:51:39')
from dual;
--���1 : ��¥�κи� �߶�ͼ� �νĽ�Ŵ
select 
    substr('2020-10-14 15:51:39', 1, 10) "���ڿ��ڸ���",
    to_date(substr('2020-10-14 15:51:39', 1, 10)) "��¥�������κ���"
from dual;

/*
����] ���ڿ� '2021/05/05'�� � �������� ��ȯ�Լ��� ���� ����غ��ÿ�.
*/
select
    to_char(sysdate, 'day') "�����ǿ���",
    to_date('2021/05/05') "1�ܰ�:��¥�����ν�",
    to_char(to_date('2021/05/05'), 'dy') "2�ܰ�:���ϼ�������"
from dual;

/*
����] ���ڿ� '2021��01��01��'�� � �������� ��ȯ�Լ��� ���� ����غ��ÿ�.
    �� ���ڿ��� ���Ƿ� ������ �� �����ϴ�. 
*/
select
    to_date('2021��01��01��', 'yyyy"��"mm"��"dd"��"') "1�ܰ�:��¥�κ���" ,
    to_char(to_date('2021��01��01��', 'yyyy"��"mm"��"dd"��"'), 'day') "2�ܰ�:�������",
    to_char(to_date('2021��01��01��', 'yyyy"��"mm"��"dd"��"'), 'dy')
from dual;

/*
�ó�����] '2015-10-24 12:34:56' ���·� �־��� �����͸� ���ڷ��Ͽ�
    '0000��00��00�� 0����' �������� ��ȯ�Լ��� �̿��Ͽ� ����Ͻÿ�.
*/
select
    to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss') "1�ܰ�:��¥�κ�ȯ",
    to_char(to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss'), 
        'yyyy"��"mm"��"dd"�� "dy"����"') "2�ܰ�:������"
from dual;

/*
�ó�����] ������̺� ����� �Ի����� ���ϱ��� ǥ���Ͻÿ�.
*/
select
    first_name, hire_date, to_char(hire_date, 'yyyy"��"mm"��"dd"�� "day')
from employees 
order by hire_date asc;

/*
nvl() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�.
    ����] nvl(�÷���, ��ü�Ұ�)
    
    �ط��ڵ带 select�ؼ� ���������� ����� �ϴ°�� �ش� �÷��� null�̸�
    NullPointerException�� �߻��ϰ� �ȴ�. �׷��Ƿ� �ƿ� �����͸� �����ö� null���� 
    ���ü� �ִ� �÷��� ���� �̸� ó���ϸ� ���ܹ߻��� �̸� �����Ҽ� �����Ƿ� ���ϴ�.
*/
select
    first_name, commission_pct, nvl(commission_pct, 0) AS "���ʽ���",
    (salary+commission_pct) "���������", (salary+nvl(commission_pct, 0)) "���������"
from employees;


/*
decode() : java�� switch���� ����ϰ� Ư������ �ش��ϴ� ��¹���
    �ִ� ��� ����Ѵ�. 
    ����] decode(�÷���, 
                ��1, ���1, ��2, ���2, .....
                �⺻��)
    �س������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����Ҷ� ���� ���ȴ�.                 
*/
/*
�ó�����] ������̺��� �� �μ��� �ش��ϴ� �μ����� ����ϴ� ��������
    decode�� �̿��ؼ� �ۼ��Ͻÿ�.
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
        '�μ���Ȯ�ξȵ�') AS TeamName
from employees;

/*
case() : java�� if~else���� ����� ������ �ϴ� �Լ�
    ����] case
            when ����1 then ��1
            when ����2 then ��2
            .....
            else �⺻��
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
        else '�μ�Ȯ�ξȵ�'
    end AS TeamName
from employees
order by employee_id asc;


--��������
/*
1. substr() �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
*/
select * from emp;
select
    hiredate,
    substr(hiredate, 1, 5) "�Ի���1",
    to_char(hiredate, 'yy-mm') "�Ի���2"
from emp;

/*
2. substr()�Լ��� ����Ͽ� 4���� �Ի��� ����� ����Ͻÿ�. 
��, ������ ������� 4���� �Ի��� ������� ��µǸ� �ȴ�.
*/
select * from emp where substr(hiredate, 4, 2)='04';
select * from emp where to_char(hiredate, 'mm')='04';

/*
3. mod() �Լ��� ����Ͽ� �����ȣ�� ¦���� ����� ����Ͻÿ�.
*/
select * from emp where mod(empno, 2)=0;

/*
4. �Ի����� ������ 2�ڸ�(YY), ���� ����(MON)�� ǥ���ϰ� 
������ ���(DY)�� �����Ͽ� ����Ͻÿ�.
*/
select
    hiredate, 
    to_char(hiredate, 'yy') "�Ի�⵵", 
    to_char(hiredate, 'mon') "�Ի��", 
    to_char(hiredate, 'dy') "�Ի����1", 
    to_char(hiredate, 'day') "�Ի����2" 
from emp;

/*
5. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� 
���� 1��1���� �� ����� ����ϰ� TO_DATE()�Լ��� ����Ͽ� ������ ���� ��ġ ��Ű�ÿ�. 
��, ��¥�� ���´� ��01-01-2020�� �������� ����Ѵ�. 
�� sysdate - ��01-01-2020�� �̿Ͱ��� ������ �����ؾ��Ѵ�. 
*/
select
    to_date('01-01-2020', 'dd-mm-yyyy') "��¥���ĺ���",
    sysdate - to_date('01-01-2020', 'dd-mm-yyyy') "��¥����",
    round(sysdate - to_date('01-01-2020', 'dd-mm-yyyy')) AS "���1",
    trunc(sysdate - to_date('01-01-2020', 'dd-mm-yyyy')) AS "���2"
from dual;

/*
6. ������� �޴��� ����� ����ϵ� ����� ���� ����� ���ؼ��� NULL�� ��� 0���� ����Ͻÿ�.
*/
select 
    ename, nvl(mgr, 0) "�޴������"
from emp;

/*
7. decode �Լ��� ���޿� ���� �޿��� �λ��Ͽ� ����Ͻÿ�. 
��CLERK���� 200, ��SALESMAN���� 180, ��MANAGER���� 150, ��PRESIDENT���� 100�� �λ��Ͽ� ����Ͻÿ�.
*/
select
    ename, sal,
    decode(job,
        'CLERK', sal+200,
        'SALESMAN', sal+180, 
        'MANAGER', sal+150,
        'PRESIDENT', sal+100,
        sal) AS "�λ�ȱ޿�"
from emp;






