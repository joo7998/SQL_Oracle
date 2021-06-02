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

SELECT * FROM phone_book;

CREATE SEQUENCE seq_phone_book_pk
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 100000000
    NOCACHE;
    
SELECT * FROM USER_SEQUENCES;

INSERT INTO phone_book VALUES (1, 'Coco', '010-10**-23**','02-43**-90**');
INSERT INTO phone_book VALUES (2, 'Nana', '010-55**-55**','02-43**-90**');
INSERT INTO phone_book VALUES (3, 'Micheal', '010-99**-77**','02-43**-90**');
INSERT INTO phone_book VALUES (4, 'Sam', '010-88**-90**','02-43**-90**');
INSERT INTO phone_book VALUES (5, 'Park', '010-98**-14**','02-9**-98**');

COMMIT;

SELECT * FROM phone_book;

DESC phone_book





