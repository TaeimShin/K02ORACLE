/******************
���ϸ� : 12Sequence&Index.sql
������ & �ε���
���� : ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� ��������
    �˻��ӵ��� ����ų�� �ִ� �ε��� 
******************/

--study �������� �н��մϴ�. 

/*
������
-���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��Ѵ�. 
-�������� ���̺� ������ ������ ������ �Ѵ�. �� �������� ���̺��
    ���������� ����ǰ� �����ȴ�. 

[������ ��������]    
create sequence ��������
    [Increment by N]    -> ����ġ����
    [Start with N]      -> ���۰�����
    [Minvalue n | NoMinvalue]   -> ������ �ּҰ� ���� : ����Ʈ1
    [Maxvalue n | NoMaxvalue]   -> ������ �ִ밪 ���� : ����Ʈ1.0000E+28
    [Cycle | NoCycle] -> �ִ�/�ּҰ��� ������ ��� ó������ �ٽ�
                        �������� ���θ� ����(cycle�� �����ϸ� �ִ밪����
                        ������ �ٽ� ���۰����� �� ���۵�)
    [Cache | NoCache] -> cache �޸𸮿� ����Ŭ������ ����������
                        �Ҵ��ϴ°� ���θ� ����

���ǻ���
1. start with �� minvalue���� �������� ������ �� ����. �� start with����
    minvalue�� ���ų� Ŀ���Ѵ�. 
2. nocycle �� �����ϰ� �������� ��� ���ö� maxvalue�� �������� �ʰ��ϸ�
    ������ �߻��Ѵ�. 
3. primary key�� cycle�ɼ��� ���� �����ϸ� �ȵȴ�. 
*/


--��ǰ������ �Է��� ���̺� ����
create table tb_goods (
    g_idx number(10) primary key,   /* ��ǰ�� �Ϸù�ȣ */
    g_name varchar2(30)             /* ��ǰ�� */
);
insert into tb_goods values (1, '���ݷ�');
insert into tb_goods values (1, '�����');

--������ �����ϱ�
create sequence seq_serial_num
    increment by 1      /* ����ġ : 1�� ���� */
    start with 100      /* �ʱⰪ : 100���� ������ */
    minvalue 99         /* �ּҰ� : 99�� ���� */
    maxvalue 110        /* �ִ밪 : 110���� ���� */
    cycle               /* �ִ밪 ���޽� ���۰����� �� �������� ���� : yes */
    nocache;            /* ĳ�û�뿩�� : no */

/*
    ������ ���� �� ���ʽ���ÿ��� ������ �߻��ȴ�. nextval�� ���� 
    ������ �� �����ؾ� �������� ��µȴ�. 
    �������� ��µ� �������� ��µȴ�. 
*/
select seq_serial_num.currval from dual;
/*
    ���� �Է��� �Ϸù�ȣ(������)�� ��ȯ�Ѵ�. �����Ҷ����� ��������
    �Ѿ��. 
*/
select seq_serial_num.nextval from dual;

insert into tb_goods values (seq_serial_num.nextval, '���ݷ�1');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�2');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�3');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�4');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�5');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�6');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�7');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�8');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�9');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�10');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�11');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�12');
insert into tb_goods values (seq_serial_num.nextval, '���ݷ�13');/*
            �������� cycle�ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ 
            �Ϸù�ȣ�� �����ǹǷ� ���Ἲ �������ǿ� ����ȴ�. �� �⺻Ű��
            ����� �������� cycle�ɼ��� ������� �ʾƾ� �Ѵ�. 
        */

select * from tb_goods;

--������ ������ ������ ������ ����
select * from user_sequences where sequence_name=upper('seq_serial_num');
/*
������ �����ϱ�
alter sequence ��������
    increment by ������
    maxvalue N Ȥ�� minvalue N
    cycle | nocycle
    cache | nocache ;

start with �� ������ �� ����. �̹� ������ �������� �ʱⰪ�� �����Ҽ� ����.    
*/
alter sequence seq_serial_num
    increment by 10
    nomaxvalue /* �������� ǥ���� �� �ִ� �ִ�ġ�� �����ȴ�. */
    minvalue 1
    nocycle
    nocache;
select * from user_sequences where sequence_name=upper('seq_serial_num');
select seq_serial_num.nextval from dual;

--�����ϱ�
drop sequence seq_serial_num;

--�Ϲ����� ������ ������ �����ϱ� 
create sequence seq_serial_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
/*
    �Ϲ������� start with, increment, minvalue�� 1�� �����ϰ�
    �������� no�� �����Ѵ�. 
*/


/*
�ε���
-���� �˻��ӵ��� ����ų�� �ִ� ��ü
-�ε����� �����(create index) �� �ڵ���(primary key, unique)
    ���� ������ �� �ִ�. 
-�÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��ϰԵȴ�. 
-�� �ε����� ������ ������ ����Ű�� ���� �����̴�. 
-�ε����� �Ʒ��� ���� ��쿡 �����Ѵ�. 
    1.where�����̳� join���ǿ� ���� ����ϴ� �÷�
    2.�������� ���� �����ϴ� �÷�
    3.���� null���� �����ϴ� �÷�
*/
--�ε��� �����ϱ�
/*
    tb_goods ���̺��� g_name �÷��� �ε����� �����Ѵ�. 
    �ε������� tb_goods_name_idx ���� �����Ѵ�.
*/
create index tb_goods_name_idx on tb_goods (g_name);

/*
    PK�� ������ �÷��� �ڵ����� �ε����� �����ȴ�. 
    �����ڰ� ���� �����ϴ� �ε����� '����� �ε���'��� ǥ���Ѵ�. 
*/
select * from user_ind_columns 
    where table_name=upper('tb_goods');

--�ε��� ����
drop index tb_goods_name_idx;

--�ε��� ���� : �ε����� ������ �Ұ����ϴ�. ���� ������ �ٽ� �����ؾ� �Ѵ�.



