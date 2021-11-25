/*****************
���ϸ� : Or05Date.sql
��¥�Լ�
���� : ��, ��, ��, ��, ��, ���� �������� ��¥������ �����ϰų� 
    ��¥�� ����Ҷ� Ȱ���ϴ� �Լ���
*******************/

/*
months_between() : ���糯¥�� ���س�¥ ������ �������� ��ȯ�Ѵ�. 
    ����] months_between(���糯¥, ���س�¥[���ų�¥])
*/
--2020��1��1�Ϻ��� ���ݱ��� ���� ��������??
select
    MONTHS_BETWEEN(SYSDATE, '2020-01-01') "���1", 
    MONTHS_BETWEEN(SYSDATE, to_date('2020��01��01��','yyyy"��"mm"��"dd"��"')) "���2",
    ceil(MONTHS_BETWEEN(SYSDATE, to_date('2020��01��01��','yyyy"��"mm"��"dd"��"'))) "���3"
from dual;

/*
�ó�����] employees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ�
    ����Ͻÿ�. ����� �ټӰ������� �������� �����Ͻÿ�.
*/
select
    first_name, hire_date, 
    months_between(sysdate, hire_date) "�ټӰ�����1",
    trunc(months_between(sysdate, hire_date), 1) "�ټӰ�����2"
from employees
order by "�ټӰ�����1" asc;


/*
add_months() : ��¥�� �������� ���� ����� ��ȯ�Ѵ�. 
    ����] add_months(���糯¥, ���Ұ�����)
*/
--���縦 �������� 7���� ������ ��¥�� ���Ͻÿ�.
select
    sysdate , 
    add_months(sysdate, 7) "7������"
from dual;

/*
next_day() : ���糯¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ� 
    �̷��� ��¥�� ��ȯ�ϴ� �Լ�
    ����] next_day(���糯¥, '������')
        => ������ �������� �����ΰ���??
*/
select
    to_char(sysdate, 'yyyy-mm-dd') "���ó�¥",
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "������������?",
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "������������?",
    to_char(next_day(sysdate, '�ݿ���'), 'yyyy-mm-dd') "�����ݿ�����?"
from dual;--������ ������ ��¥�� ��ȸ�� �� ����. 

/*
last_day() : �ش���� ������ ��¥�� ��ȯ�Ѵ�. 
*/
select last_day('21/02/01') from dual;--28�� ���
select last_day('20/02/01') from dual;--20���� �����̹Ƿ� 29�� ��µ�


--�÷��� date���� ��� ������ ��¥������ �����ϴ�.
select
    sysdate "���糯¥",
    sysdate+1 "���ϳ�¥",
    sysdate-1 "������¥",
    sysdate+30 "�Ѵ��ĳ�¥"
from dual;


select job_id from employees;
select distinct job_id from employees;
select job_id from employees group by job_id;
















