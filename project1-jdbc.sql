
create table phonebook_tb(
    name varchar2(30) primary key,
    phone varchar2(30),
    birth date
);

create sequence seq_phonebook
    increment by 1      
    start with 1      
    minvalue 1        
    nomaxvalue        
    nocycle              
    nocache;  
    
    
SELECT name, phone, birth FROM phonebook_tb WHERE name LIKE '% lee %'; 
    