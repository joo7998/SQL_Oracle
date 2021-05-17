--------------------
-- DB OBJECTS
--------------------

-- SYSTEM 계정 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO PARKMJ;
-- 사용자 계정으로 복귀

-- SimpleView
-- 단일 테이블, 함수나 연산식을 포함한 컬럼이 없는 단순 뷰
DROP TABLE emp123;
CREATE TABLE emp123
    AS SELECT * FROM hr.employees
        WHERE department_id IN (10, 20, 30);
SELECT * FROM emp123;

-- emp123 테이블을 기반으로 30 번 부서 사람들만 보여주는 View 생성
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id = 10;

DESC emp10;

-- View는 테이블처럼 SELECT 할 수 있다
-- 다만 실제 데이터는 원본 테이블 내에 있는 데이터 활용
SELECT * FROM emp10;
SELECT first_name || ' ' || last_name, salary FROM emp10;

-- Simple View는 제약 사항에 위배되지 않는다면 내용을 갱신할 수 있다
-- salary를 2배로 올려봅시다
SELECT first_name, salary FROM emp10;

UPDATE emp10 SET salary = salary * 2;
SELECT first_name, salary FROM emp10;
SELECT first_name, salary FROM emp123;
ROLLBACK;

-- VIEW는 가급적 조회용으로만 사용하도록 하자
-- READ ONLY 옵션 부여 View 생성
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id=10
    WITH READ ONLY;
    
SELECT * FROM emp10;

UPDATE emp10 SET salary=salary * 2; -- 읽기 전용 뷰에서는 DML 수행 불가

-- 복합 뷰
DESC author;
DESC book;
-- author와 book을 join 정보를 출력하는 복합 뷰
CREATE OR REPLACE VIEW book_detail
    (bood_id, title, author_name, pub_date)
    AS SELECT book_id,
                title,
                author_name,
                pub_date
        FROM book b, author a
        WHERE b.author_id = a.author_id;
        
DESC book_detail;

SELECT * FROM book_detail;

UPDATE book_detail SET author_name='Unknown';
-- 복합 뷰에서는 기본적으로 DML 수행할 수 없다


-- VIEW Dictionary 
SELECT * FROM USER_VIEWS;
-- specifi view check -> VIEW_NAME in WHERE
SELECT view_name, text FROM USER_VIEWS
WHERE view_name='BOOK_DETAIL'

-- table check using USER_OBJECTS
SELECT * FROM USER_OBJECTS
WHERE object_type='VIEW';

-- delete view 
DROP VIEW book_detail;
SELECT * FROM USER_VIEWS;

--  INDEX
--
CREATE TABLE s_emp
     AS SELECT * FROM hr.employees;
     
SELECT * FROM s_emp;
CREATE UNIQUE INDEX s_emp_id_pk
     ON s_emp (employee_id);

SELECT * FROM USER_INDEXES;

SELECT * FROM USER_IND_COLUMNS;

SELECT t.index_name, t.table_name, c.column_name, c.column_position
FROM USER_INDEXES t, USER_IND_COLUMNS c
WHERE t.index_name = c.index_name AND
   t.table_name = 'S_EMP';
   
-- DELETE INDEX
DROP INDEX s_emp_id_pk;
SELECT * FROM USER_INDEXES;

-- SEQUENCE
-- author table -> insert new record

DESC author;
SELECT * FROM author;

SELECT MAX(author_id) FROM author; 

INSERT INTO author(author_id, author_name)
   VALUES ( (SELECT MAX(author_id) + 1 FROM author), 'Unknown');
SELECT * FROM author;

ROLLBACK;
   
   
   
   
   
   
   
     