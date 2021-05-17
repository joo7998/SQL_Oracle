--------------------
-- CUD (Create, Update, Delete)
--------------------

DESC author;

-- INSERT: 테이블에 새 데이터 추가
-- 데이터를 넣을 컬럼을 지정하지 않으면 전체 데이터를 제공
-- 테이블 정의시 지정한 순서대로 INSERT
INSERT INTO author
VALUES(1, 'park', 'land');

-- 특정 컬럼의 내용만 입력할 때는 컬럼의 목록 지정
INSERT INTO author (author_id, author_name)
VALUES(2, 'kim');

SELECT * FROM author;

COMMIT; --  변경 사항 커밋

INSERT INTO author (author_id, author_name)
VALUES(3, 'king');

SAVEPOINT a;
SELECT * FROM author;

INSERT INTO author (author_id, author_name)
VALUES(4, 'tolstoy');

SELECT * FROM author;
ROLLBACK TO a;  --   Savepoint a로 복구
SELECT * FROM author;

ROLLBACK;   --  트랜잭션 시작 위치로 복구
SELECT * FROM author;

DESC book;
INSERT INTO book 
VALUES(1, 'land', sysdate, 1);

INSERT INTO book (book_id, title, author_id)
VALUES(2, 'the momery', 2);

--  무결성 제약 조건을 위반한 레코드는 삽입되지 않는다.
INSERT INTO book (book_id, title, author_id)
VALUES(3, 'prison break', 3);

SELECT * FROM book;

COMMIT;

-- UPDATE 테이블명 Set 컬럼명=값, 컬럼명=값
UPDATE author SET author_desc='tv';
SELECT * FROM author;

-- WHERE 절을 명시하지 않으면 모든 레코드가 변경
ROLLBACK;
UPDATE author SET author_desc='tv'
WHERE author_id=2;

SELECT * FROM author;

-- 연습
-- hr.employees 테이블로부터 department_id가 10, 20, 30인 사람들만 
-- 새 테이블로 생성
CREATE TABLE emp123 AS
    ( SELECT * FROM hr.employees
        WHERE department_id IN (10, 20, 30));
DESC emp123;
SELECT first_name, salary, department_id FROM emp123;

-- 부서가 30인 직원들의 급여를 10% 인상해 줍시다.
UPDATE emp123
SET salary = salary + salary * 0.1
WHERE department_id=30;
SELECT first_name, salary, department_id, job_id FROM emp123;

ROLLBACK;

-- DELETE : 테이블로부터 레코드 삭제
SELECT * FROM emp123;
DELETE FROM emp123;
--  WHERE 절 없이 DELETE 수행하면 모든 레코드 삭제
ROLLBACK;

SELECT * FROM emp123;

-- emp123으로부터 job_id가 PU_로 시작되는 레코드 삭제
DELETE FROM emp123
WHERE job_id LIKE 'PU_%';

SELECT * FROM emp123;
ROLLBACK;

-- DELETE vs TRUNCATE
-- DELETE : Transaction의 대상 -> ROLLBACK;
-- TRUNCATE : Transaction의 대상이 아님 -> ROLLBACK 불가
DELETE FROM emp123;
SELECT * FROM emp123;
ROLLBACK;

TRUNCATE TABLE emp123;
SELECT * FROM emp123;
ROLLBACK;   --  TRUNCATE는 롤백의 대상이 아니다
SELECT * FROM emp123;

