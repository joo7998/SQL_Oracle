CREATE USER bituser IDENTIFIED BY bituser

GRANT create session TO bituser;

GRANT connect, resource TO bituser;

ALTER USER bituser DEFAULT TABLESPACE USERS QUOTA unlimited ON USERS;


CREATE TABLE phone_book ( 
    id NUMBER(10) PRIMARY KEY,  
    name VARCHAR2(20) NOT NULL, 
    mobile VARCHAR2(30) NOT NULL,    
    tel VARCHAR2(30) NOT NULL     
);

DESC phone_book;

CREATE SEQUENCE seq_phone_book_pk
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 100000000
    NOCACHE;

--commit push test