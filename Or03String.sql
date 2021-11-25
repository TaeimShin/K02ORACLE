/***************
���ϸ� : Or03String.sql
���ڿ� ó���Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� �� ���ڿ���
    �����ϴ� �Լ�
***************/

/*
concat(���ڿ�1, ���ڿ�2)
    : ���ڿ� 1�� 2�� ���� �����ؼ� ����ϴ� �Լ�
    ����1 : concat('���ڿ�1', '���ڿ�2')
    ����2 : '���ڿ�1' || '���ڿ�2'
*/
select concat('Good ', 'morning') as "��ħ�λ�" from dual;
select 'Oracle'||' 11g'||' Good' from dual;
-- => ���� SQL���� concat()���� �����ϸ� �Ʒ��� ����. 
    select concat(concat('Oralce', ' 11g'), ' Good') from dual;

/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�.
    ��³��� : first+last name, �޿�, �μ���ȣ
*/    
--�̸��� ���������� ���Ⱑ �ȵǼ� �б� ������.
select concat(first_name, last_name) AS fullname, salary, department_id
    from employees;
--���Ⱑ �Ǿ����� �ΰ��� �Լ��� �����ؾ� �ϹǷ� ����� ������.    
select concat(concat(first_name, ' '), last_name) AS fullname, salary, department_id
    from employees;    
--concat �����ڸ� ���� ���� ���ϰ� ����� �� �ִ�. 
select first_name||' '||last_name AS fullname, salary, department_id
    from employees;
    

/*
initcap(���ڿ�)
    : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�. 
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����. 
    -���鹮�� ������ ������ ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�. 
    -���ĺ��� ���ڸ� ������ ������ ���� ������ ������ ù��° ���ڸ� �빮�ڷ� ��ȯ�Ѵ�. 
*/
select initcap('hi hello �ȳ�') from dual;--�� ��� h�� �빮�ڷ� �����
select initcap('good/bad morning') from dual;--g, b, m�� �빮�ڷ� �����
select initcap('never6say*good��bye') from dual;--n, g, b�� �빮�ڷ� �����

/*
�ó�����] ������̺��� first_name�� john�� ����� ã�� �����Ͻÿ�.
*/
select * from employees where first_name='john';--�������(�����ʹ� ��ҹ��� ������)
select * from employees where first_name='John';--3�� ����
select * from employees where first_name=initcap('john');--3�� ����

/*
��ҹ��� �����ϱ�
lower() : �ҹ��ڷ� ������
upper() : �빮�ڷ� ������
*/
select lower('GOOD'), upper('bad') from dual;
--�������� ���� john�� �˻��Ϸ���...
select lower(first_name), upper(first_name), first_name, last_name
    from employees where lower(first_name)='john';
select first_name, last_name from employees where upper(first_name)='JOHN';    


/*
lpad(), rpad()
    : ���ڿ��� ����, �������� Ư���� ��ȣ�� ä�ﶧ ����Ѵ�. 
    ����] lpad('���ڿ�', '��ü�ڸ���', 'ä�﹮�ڿ�')
        ->  ��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ������ ������
        �����κ��� �־��� ���ڿ��� ä���ִ� �Լ�.
        rpad()�� �������� ä����.
*/
select
    'good', 
    lpad('good', 7, '#'), rpad('good', 7, '#'),
    lpad('good', 7)
from dual;--���ڸ� 2���� �ִ� ��� ���ڸ��� �������� ä������.

/*
trim() : ������ �����Ҷ� ����Ѵ�. 
    ����] trim([leading | trailing | both] �����ҹ��� from �÷�)
        - leading : ���ʿ��� ������
        - trailing : �����ʿ��� ������
        - both : ���ʿ��� ������. �������� ������ both�� ����Ʈ��.
        [����1] ���ʳ��� ���ڸ� ���ŵǰ�, �߰��� �ִ� ���ڴ� ���ŵ��� ����.
        [����2] '����'�� �����Ҽ��ְ�, '���ڿ�'�� �����Ҽ� ����. �����߻���
*/
select
    ' ���������׽�Ʈ ' as trim1,
    trim(' ���������׽�Ʈ ') as trim2,
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�') trim3, /* �ɼ��� ���°�� both�� ����Ʈ */
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') trim4,
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') trim5,
    trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') trim6,
    trim('��' from '�ٶ��㰡 �ٸ����� ������ ž�ϴ�') trim7 /* ���ڿ� �߰��� '��'�� ���ŵ��� ����*/
from dual;
--�Ʒ� �������� ������ �߻��Ѵ�. ���ڿ��� ������ �� ����.
select
    trim('�ٶ���' from '�ٶ��㰡 ������ Ÿ�ٰ� ���������ϴ�') AS trimError
from dual;


/*
ltrim(), rtrim() : L[eft]TRIM, R[ight]TRIM
    : ����, ���� '����' Ȥ�� '���ڿ�'�� �����Ҷ� ����Ѵ�.
    �� TRIM�� ���ڿ��� ������ �� ������, LTRIM�� RTRIM�� ���ڿ����� 
    ������ �� �ִ�.
*/
select
    ltrim(' ������������ ') ltrim1, 
    ltrim(' �������ڿ�����', '����') ltrim2, /* �̰�� �����̽��� ���Ե� ���ڿ��̹Ƿ� �����ȵ� */
    ltrim('�������ڿ�����', '����') ltrim3, /* '����' ���ڿ��� ������ */
    rtrim('�������ڿ�����', '����') rtrim4,
    rtrim('�������ڿ�����', '���ڿ�') rtrim5 /* �߰��� �ִ� ���ڿ��� �����ȵ� */
from dual;

/*
substr() : ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�. 
    ����] substr(�÷�, �����ε���, ����)
    
    ����1) ����Ŭ�� �ε����� 1���� �����Ѵ�. (0���;ƴ�)
    ����2) '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�.
    ����3) �����ε����� ������ ���������� �·� �ε����� �����Ѵ�. 
*/
select substr('good morning john', 8, 4) from dual;--rnin
select substr('good morning john', 8) from dual;--rning john
--�ε��� 2���� �������� �߶����� �ѱ��̹Ƿ� �������� ����� ���� �ٸ���. 
select substr('�ȳ��ϼ��� ��', 2) from dual;

/*
substrb() : ����Ʈ(byte)������ �߶󳽴�. 
    ��������� �ѱ۰� ���� �����ڵ�� �ѱ��ڿ� 3byte�� ǥ���ǳ�
    ���ݽ� ��߳��� ��찡 ����Ƿ� �׽�Ʈ�� �ʿ��ϴ�. 
*/
select substrb('�ȳ��ϼ��� ��', 1) from dual;
select substrb('�ȳ��ϼ��� ��', 2) from dual;
select substrb('�ȳ��ϼ��� ��', 3) from dual;
select substrb('�ȳ��ϼ��� ��', 4) from dual;
select substrb('�ȳ��ϼ��� ��', 5) from dual;
select substrb('�ȳ��ϼ��� ��', 6) from dual;
select substrb('�ȳ��ϼ��� ��', 7) from dual;


/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�Ҷ� ����Ѵ�. 
    ���� �������� ���ڿ��� ��ü�Ѵٸ� ���ڿ��� �����Ǵ� ����� �ȴ�. 
    ����] replace(�÷��� or ���ڿ�, '������ ����� ����', '������ ����')

     ��trim(), ltrim(), rtrim()�޼ҵ��� ����� replace()�޼ҵ� �ϳ��� ��ü�Ҽ� 
    �����Ƿ� trim()�� ���� replace()�� �ξ� �� ���󵵰� ����.
*/
select replace('good morning john', 'morning', 'evening') from dual; --���ڿ� ����
select replace('good morning john', 'john', '') from dual; --���ڿ� ����
--trim�� �¿����� ������ ���ŵ�����, �߰��� ������ �����Ҽ� ����. 
select trim(' ����1 ����2 ') blank1 from dual;
--replace�� �¿��� �Ӹ� �ƴ϶� �߰��� ���鵵 �����Ҽ� �ִ�. 
select replace(' ����1 ����2 ', ' ', '') AS blank2 from dual;

/*
������̺��� ���ڵ带 ������� ���ڿ������� �����غ���. 
102	Lex	De Haan	LDEHAAN
*/
--102�� ����� ��ü������ �����Ѵ�. 
select * from employees where employee_id=102;
--�� �Լ��� ���� ���ڿ����� ����� �غ���. 
select
    first_name, last_name,
    ltrim(first_name, 'L') "����L����", 
    rtrim(first_name, 'ex') "����ex����",
    replace(last_name, ' ', '') "�߰���������", 
    replace(first_name, 'Lex', 'Joy') "�̸�����"
from employees where employee_id=102;

/*
instr() : �ش� ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�. 
    ����1] instr(�÷���, 'ã������')
        => ���ڿ��� ó������ ���ڸ� ã�´�. 
    ����2] instr(�÷���, 'ã������', 'Ž���� ������ �ε���', '���°����')
        => Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� 
        �ִ� �������� ������ �� �ִ�. 
*/
--n�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning tom', 'n') from dual;
--�ε���1���� Ž���� �����ؼ� n�� �߰ߵ� �ι�° �ε��� ��ȯ
select instr('good morning tom', 'n', 1, 2) from dual;
--�ε���8���� Ž���� �����Ͽ� m�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning tom', 'm', 8, 1) from dual;







