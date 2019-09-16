DATA 중복 배제하는 이유 : DATA 신뢰성 보장. ( 무결성 )

1. File System
: Data를 file에 저장 (csv, txt)
: Data 중복, 동시사용 불가.
-> 수강신청을 동시에 못함.

2. DataBase System(DBMS)
: 위 문제를 해결하고, 데이터 무결성.
: 연결자를 사용할 줄 알면 된다. ( ex: 카페의 바리스타 )


SQL(Structured Query Language)
: Script, Interpreter 방식

데이터 정의 DDL(CRUD)
데이터 조작 DML(주로다룸) - 데이터 사입 수정 삭제
데이터 제어 DCL

DataBase : Table(행렬 Array) 집합
Table : Field 집함
Field : scalar(원시) 값
row = record / col = field
#DML의 명령어 4가지 : Table에 있는 row/col에 변화를 줌
SELECT	검색, Data 추출	(row/col 단위)
 - row 조회 (selection)
 - col  조회 (projection)
 - join 두 개 이상의 테이블을 결합해서 selection을 하거나 projection을 하겠다.
INSERT	row 삽입		(row 단위)
UPDATE	row 수정		(col 단위)
DELETE	row 삭제		(row 단위)

DBMS -> DataBase -> Table -> Field

#헷갈림 방지를 위하여
#SQL : 대문자 / sqlplus : 소문자
1. cmd 열기
2. sqlplus scott/tiger 입력 (sqlplus : oracle CLI(명령입력방식) 방식)
* CLI 환경 : prompt는 명령 입력 대기상태
** sqlplus 명령, sql 명령 (대소문자 구분X)
3. show user; : 현재 접속한 유저 나타냄. (sqlplus) 
4. select * from all_users; : 현재 등록된 사용자 목록(dcl을 통하여 사용자 추가)
5. select * from tab; : 현재 로그인 한 계정의 DB 속 테이블을 모두 나타냄
6. desc emp; : descript의 약자, emp - table 이름 : emp 테이블의 필드 구성
*NOT NULL : 제약조건 - 꼭 있어야 하는 값. ex) 고유키
*VARCHAR2(10) : 최대 10자리. 하지만, 가변변수이므로 데이터가 6으로 끝나면 6까지만.

# 기본 틀
SELECT column 목록
FROM table 목록
(WHERE 조건)

# projection
SELECT * FROM DEPT;
 - DEPT 테이블에서 전체 col을 출력하라.
SELECT deptno FROM dept;
 - dept 테이블에서 deptno col만 출력하라.
SELECT * FROM emp;
 - MGR : 관리사 사원번호(키). --->> 자기 자신과 관계.
SELECT empno, mer FROM emp;
SELECT mgr, empno FROM emp;
SELECT empno, job FROM emp;
SELECT job, deptno FROM emp;
SELECT DISTINCT job, empno FROM emp;
 - DISTINCT : 중복제거
SELECT ALL job, deptno FROM emp;
 - ALL : 중복데이터 출력
SELECT ename, sal, sal * 0.5 FROM emp;
 - sal의 50%값을 나타냄(Field에 산술식 가능) : + - * / 만 가능
SELECT ename, sal, sal * 0.5 AS SAL_50 FROM emp;
 - AS : 변수명 설정. (별명) / 기존 변수도 가능.
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp;
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp ORDER BY ename;
 - ORDER BY : 해당 변수의 오름차순으로 출력
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp ORDER BY ename DESC;
 - DESC : 이름의 내림차순으로 출력
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp ORDER BY sal DESC, ename ASC;
 - sal 기준 내림차순 후, ename 기준 오름차순 출력.   /  ASC : 오름차순
SELECT ename, job, sal FROM emp WHERE sal >= 3000;
 - sal 3000 이상만 출력.
SELECT ename, job, sal FROM emp WHERE deptno = 30;
SELECT * FROM emp WHERE ename = 'SCOTT'; /* 가능하면 "가 아닌 ' 사용. */

SELECT * FROM emp WHERE ename != 'SCOTT';
SELECT ename, job, sal FROM emp WHERE deptno = 30 AND sal >= 1500;
 - AND, OR 연산자 가능
SELECT ename, job, sal FROM emp WHERE sal * 0.5 = 1500;
SELECT ename, job, sal FROM emp WHERE (sal * 0.5) = 1500;
SELECT ename, job, sal FROM emp WHERE NOT (sal * 0.5) = 1500;
 - NOT : 그 해당 조건이 아닌 것을 출력
SELECT ename, job, deptno FROM emp WHERE deptno = 10 OR deptno = 20;
SELECT ename, job, deptno FROM emp WHERE deptno IN (10,20);
 - deptno가 괄호안의 값에 해당되면 출력
SELECT ename, job, deptno FROM emp WHERE NOT deptno IN (10,20);
SELECT ename, job, deptno FROM emp WHERE job = 'SALESMAN' AND deptno = 30;
SELECT ename, job, deptno, sal FROM emp WHERE sal >= 1500 AND sal <= 3000;
SELECT ename, job, deptno, sal FROM emp WHERE sal BETWEEN 1500 AND 3000;
 - 사이값을 출력
SELECT ename, job, deptno, sal FROM emp WHERE sal NOT BETWEEN 1500 AND 3000;
SELECT ename, job, deptno, sal FROM emp WHERE job LIKE 'S%';
 - LIKE 'S%'; : S로 시작되는 값 출력		// % : 길이와 상관없이 모든 문자 데이터를 의미
SELECT ename, job, deptno, sal FROM emp WHERE job LIKE '%N';
 - 마지막 글자가 N인 값 출력
SELECT ename, job, deptno, sal FROM emp WHERE job LIKE '_L%';
 - 두번째 글자가 L인 값 출력			// _ : 어떤 값이든 상관없이 한 개의 문자 데이터를 의미
SELECT ename, job, deptno, sal, comm FROM emp WHERE comm IS NULL;
 - IS NULL : NULL인 것.
SELECT ename, job, deptno, sal, comm FROM emp WHERE comm IS NOT NULL;
 - NULL이 아닌 것.

UPPER(ename),	LOWER(ename)	INITCAP(ename)	LENGTH(ename)	LENGTHB(ename)
대문자		소문자		첫글자대문자	길이		바이트수(한글:2Byte/영문:1Byte)

SUBSTR(job, 1, 2)	SUBSTR(job, 3, 2)	SUBSTR(job, 5)	SUBSTR(문자열 데이터, 시작위치, 추출길이)
SA		LE		SMAN

SUBSTR(job, -LENGTH(job))	SUBSTR(job, -LENGTH(job), 2)
CLERK			CL

INSTR(대상문자열, 찾을 부분문자, 찾기 시작할 부분, 몇번째를 찾을지)
SELECT ename FROM emp WHERE INSTR(ename, 'L')>0;
SELECT ename FROM emp WHERE ename LIKE '%L%';
 - 위 두 문구 결과 같음.

REPLACE('010-1234-5678', '-', ' ')	REPLACE('010-1234-5678', '-')
010 1234 5678			01012345678

전체크기를 잡아두고(14) 나머지 공백을 '*'로 채워라.
PAD : 채우다. RPAD : 오른쪽에 채워라.
RPAD('123456-', 14, '*')	RPAD('010-1234-', 13, '#')
123456-*******		010-1234-####

CONCAT(empno, ename)	CONCAT(empno, concat(':', ename))	empno||ename
empnoename		empno:ename			empnoename

TRIM('    hello   ') RTRIM LTRIM 지원
hello

ROUND(숫자형 데이터, 나타낼 소숫점 수) : 반올림함
TRUNC(숫자형 데이터, 나타낼 소숫점 수) : 내림
CEIL(숫자형 데이터) : 올림
FLOOR(숫자형 데이터) : 내림
MOD(큰 수, 작은 수) : 나누기 나머지 함수 // MOD(3, 2) : 1
SYSDATE : 19/06/25 날짜
ADD_MONTHS(SYSDATE, 3) : 3개월 후 날짜
MONTH_BETWEEN(날짜데이터1, 날짜데이터2) : 두 날짜의 개월 수 사이
NEXT_DAY(날짜데이터, 요일) : 날짜 데이터 기준으로 돌아오는 요일의 날짜를 출력
LAST_DAY(날짜 데이터) : 특정 날짜가 속한 달의 마지막 날짜를 출력


#형 변환(Data Type 변환) (Casting)

- 암시적 형변환 (자동 형변환) ex) 10 + 10.0 = 20,     600 + '300' = 900 [좋지는 않음]
- 명시적 형변환 (직접 형변환)
TO_NUMBER('500')
TO_CHAR(500)
TO_DATE()

NVL(crrromm, 0) : NULL은 0으로 바꿈

#조건문
DECODE(조건변수, 조견결과, TRUE값, FALSE값)

@func_ex1.sql	외부 sql 파일 불러오기
@@func_ex1.sql	외부 sql 파일 불러오기(경로설정가능)
L 		입력하면 마지막으로 사용한 sql 코드 나옴.

#다중행 함수 - NULL을 제외하고 계산 : 여러행이 나오는 것과 같이 사용 불가.
SUM, COUNT, MAX, MIN, AVG
COUNT(*) : 레코드 수
COUNT(comm) : NULL이 없는 레코드 수
SELECT deptno, MAX(sal), MIN(sal), AVG(sal) FROM emp GROUP BY deptno;
 - FORM문 다음에		GROUP BY 변수 : 변수별 계산.
SELECT deptno, MAX(sal), MIN(sal), AVG(sal) FROM emp GROUP BY deptno ORDER BY deptno;
 - GROUP 다음에 ORDER가 와야됨.
SELECT deptno, MAX(sal), MIN(sal), AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal) >= 2000 ORDER BY deptno;
 - HAVING : GROUP BY에서만 사용 가능 ( WHERE와 비슷 )

####### 내부조인 - NULL은 허용하지 않음.
# 등가조인 - 관계가 성립된 테이블 간에 하는것이 원칙.
SELECT e.empno, e.deptno,d.deptno, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno;
# 비등가조인 - 만약 관계성이 없다면 WHERE문 사용.
SELECT e.empno, e.ename, e.sal, e.comm, s.losal, s.hisal FROM emp e, salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal;
# 자체조인 (MGR이 NULL인 것은 빠짐)
SELECT e.empno, e.ename, e.mgr, m.ename FROM emp e, emp m WHERE e.mgr = m.empno;

####### 외부조인
# NULL 값도 포함 (+)   :  + 기호가 붙지않은 곳이 기준.
SELECT e.empno, e.ename, e.mgr, m.ename FROM emp e, emp m WHERE e.mgr = m.empno(+) ORDER BY e.empno;

# 괄호 밖 메인 부분 : 메인쿼리
# 괄호 안 부분 : 서브쿼리
SELECT *
FROM emp
WHERE sal > ( SELECT sal
              FROM emp
              WHERE ename = 'JONES')              
SELECT *
FROM emp
WHERE hiredate < ( SELECT hiredate
                   FROM emp
                   WHERE ename = 'SCOTT');
                   
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno AND
      e.deptno = 20 AND
      e.sal > ( SELECT AVG(sal)
                FROM emp );

SELECT *
FROM emp
WHERE deptno IN ( 20, 30);

SELECT *
FROM emp
WHERE sal IN ( SELECT MAX(sal)
                  FROM emp
                  GROUP BY deptno );

/* 하나라도 만족하면 출력하라. = OR와 비슷 , 서브쿼리의 조건식이 하나라도 참이면 모두 참*/                                    
SELECT *
FROM emp
WHERE sal = ANY ( SELECT MAX(sal)
                  FROM emp
                  GROUP BY deptno );
                  
/* 위와 동일 */                  
SELECT *
FROM emp
WHERE sal = SOME ( SELECT MAX(sal)
                  FROM emp
                  GROUP BY deptno );                  

/* 다 TURE여야 TRUE.   = AND와 비슷*/
SELECT *
FROM emp
WHERE sal < ALL ( SELECT sal
                  FROM emp
                  WHERE deptno = 30 );  
                  
SELECT *
FROM emp
WHERE (deptno, sal) IN ( SELECT deptno, MAX(sal)
                         FROM emp
                         GROUP BY deptno );
                         
SELECT e10.empno, e10.ename, e10.deptno, d.dname, d.loc
FROM ( SELECT * FROM emp WHERE deptno = 10 ) e10,
    ( SELECT * FROM dept) D
WHERE e10.deptno = d.deptno;

SELECT empno, ename, job, sal,
        ( SELECT grade
          FROM salgrade
          WHERE e.sal BETWEEN losal AND hisal ) AS SALGRADE,
        deptno,
        ( SELECT dname
          FROM dept
          WHERE e.deptno = dept.deptno ) AS DNAME
FROM emp e;

/* p.262, Q-1 */
SELECT job, e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE d.deptno = e.deptno AND
      e.job = (SELECT job
             FROM emp
             WHERE ename = 'ALLEN');
/* p.262, Q-2 */
SELECT e.empno, e.ename, d.dname, TO_CHAR(hiredate, 'YYYY-MM-DD') AS HIREDATE, d.loc, e.sal,
        ( SELECT grade
          FROM salgrade
          WHERE e.sal BETWEEN losal AND hisal ) AS GRADE
FROM emp e, dept d
WHERE e.deptno = d.deptno AND
      e.sal > (SELECT AVG(sal)
               FROM emp)
ORDER BY e.sal DESC, e.empno;

/*
DML : Data 조작, CRUD 동작
SELECT Data 검색(추출)
INSERT : row 추가
UPDATE : column 수정
DELETE : row 삭제
DDL : DB/TABLE 생성/삭제/수정
CREATE TABLE
DROP TABLE
*/

/* 테이블 삭제. 위험함. 우리가 쓸 게 아님. */
DROP TABLE student_tbl

/* 테이블 생성 */
CREATE TABLE score_tbl (
        studentno       NUMBER( 4 ), /* 4 : 숫자 4자리 */
        studentname     VARCHAR2( 20 ),
        subject1        NUMBER( 3 ),
        subject2        NUMBER( 3 ),
        subject3        NUMBER( 3 )
)

/* 데이터 열 개수에 맞게 넣어야 함. */
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3)
        VALUES ( 1, 'hong', 55, 56, 57 )
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3)
        VALUES ( 2, 'kim', 55, 66, 44 ) 
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3)
        VALUES ( 3, 'park', 76, 45, 28 )
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3)
        VALUES ( 4, 'lee', 77, 37, 99 )
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3)
        VALUES ( 5, 'choi', 100, 100, 100 )

/* 변수명 입력안해도 데이터만 잘 집어넣으면 가능 */        
INSERT INTO score_tbl
        VALUES ( 6, 'im', 77, 87, 97)
        
/* 변수 추가 */
ALTER TABLE score_tbl 
        ADD total       NUMBER( 5 )
ALTER TABLE score_tbl
        ADD average     NUMBER( 6, 2 )

/* 데이터 수정 */
UPDATE score_tbl SET total = subject1 + subject2 + subject3
WHERE studentno = 1
UPDATE score_tbl SET total = subject1 + subject2 + subject3
WHERE studentno = 2
UPDATE score_tbl SET total = subject1 + subject2 + subject3
WHERE studentno = 3
UPDATE score_tbl SET total = subject1 + subject2 + subject3
WHERE studentno = 4
UPDATE score_tbl SET total = subject1 + subject2 + subject3
WHERE studentno = 5
UPDATE score_tbl SET total = subject1 + subject2 + subject3
WHERE studentno = 6

UPDATE score_tbl SET average = total/3
WHERE studentno = 1
UPDATE score_tbl SET average = total/3
WHERE studentno = 2
UPDATE score_tbl SET average = total/3
WHERE studentno = 3
UPDATE score_tbl SET average = total/3
WHERE studentno = 4
UPDATE score_tbl SET average = total/3
WHERE studentno = 5
UPDATE score_tbl SET average = total/3
WHERE studentno = 6

/* 특정 행 삭제 */
DELETE FROM score_tbl
WHERE studentno = 6

/* 테이블 내 모든 행 삭제 */
DELETE FROM score_tbl

SELECT COUNT(*), MAX(subject1), MIN(subject1), AVG(subject1)
FROM score_tbl

/* 테이블 수정해보기 */
ALTER TABLE score_tbl
        ADD majorname     VARCHAR2( 20 )

UPDATE score_tbl SET majorname = '컴퓨터 공학'
WHERE studentno = 1
UPDATE score_tbl SET majorname = '컴퓨터 공학'
WHERE studentno = 2
UPDATE score_tbl SET majorname = '빅데이터 전공'
WHERE studentno = 3
UPDATE score_tbl SET majorname = '빅데이터 전공'
WHERE studentno = 4
UPDATE score_tbl SET majorname = '컴퓨터 공학'
WHERE studentno = 5
UPDATE score_tbl SET majorname = '빅데이터 전공'
WHERE studentno = 6
/* 위 데이터 추가 결과, 무결성을 침해함 */
/* major_tbl을 생성해 major를 따로 관리한다. */
ALTER TABLE score_tbl DROP COLUMN majorname;
ALTER TABLE score_tbl ADD majorno NUMBER( 4 );

UPDATE score_tbl SET majorno = 1
WHERE studentno = 1;
UPDATE score_tbl SET majorno = 1
WHERE studentno = 2;
UPDATE score_tbl SET majorno = 2
WHERE studentno = 3;
UPDATE score_tbl SET majorno = 2
WHERE studentno = 4;
UPDATE score_tbl SET majorno = 1
WHERE studentno = 5;
UPDATE score_tbl SET majorno = 2
WHERE studentno = 6;

/* 테이블 생성 */
CREATE TABLE major_tbl (
        majorno       NUMBER( 4 ),
        majorname     VARCHAR2( 20 )
)

/* 데이터 열 개수에 맞게 넣어야 함. */
INSERT INTO major_tbl
        VALUES ( 1, '컴퓨터공학');
INSERT INTO major_tbl
        VALUES ( 2, '빅데이터');
        
SELECT * FROM score_tbl, major_tbl WHERE score_tbl.majorno = major_tbl.majorno;

/* 트랜젝션 : sqldeveloper에서 수정을 해도, cmd에서 바로 실행되지 않음. */
COMMIT /* 하나의 트랜젝션을 종료. -> DB에 완전히 넘어감. */
ROLLBACK /* 트랜젝션이 끝나기 전에(COMMIT 하기전에) 하면 다시 원래상태로 돌아감. */

ALTER TABLE score_tbl ADD testno NUMBER( 4 );
UPDATE score_tbl SET testno =1 WHERE studentno = 1;
UPDATE score_tbl SET testno =1 WHERE studentno = 2;
UPDATE score_tbl SET testno =1 WHERE studentno = 3;
UPDATE score_tbl SET testno =1 WHERE studentno = 4;
UPDATE score_tbl SET testno =1 WHERE studentno = 5;
UPDATE score_tbl SET testno =1 WHERE studentno = 6;

CREATE TABLE test_tbl(
        testno      NUMBER( 4 ),
        testname    VARCHAR2( 20 )
);
INSERT INTO test_tbl VALUES ( 1, '중간고사');
INSERT INTO test_tbl VALUES ( 2, '기말고사');

SELECT * FROM score_tbl s, major_tbl m, test_tbl t WHERE s.testno = t.testno AND s.majorno = m.majorno;

/*
NOT NULL : NULL 허용 x
UNIQUE : 고유값을 가져야함, 중복 X
PRIMARY KEY : NOT NULL, UNIQUE 특성 모두 가짐.
FOREIGN KEY : 다른 데이터 테이블 열을 참조, UNIQUE 하면 안됨, 중복이 허용되야 됨.
CHECK : 설정한 조건식을 만족하는 데이터만 입력 가능.
*/

CREATE TABLE master(
    masterid        NUMBER( 2 ) PRIMARY KEY,
    mastername      VARCHAR2( 20 )
);
CREATE TABLE slave(
    slaveid     NUMBER( 2 ) PRIMARY KEY,
    slavename   VARCHAR2( 20 ),
    masterid    NUMBER( 2 ) REFERENCES master( masterid ) /* REFERENCE 테이블명(해당테이블의_고유키) */
);

DROP TABLE score_tbl;
DROP TABLE test_tbl;
DROP TABLE major_tbl;
DROP TABLE slave;
DROP TABLE master;
DROP TABLE examtype_tbl;
COMMIT;

/* 1:1 or 1:다 ('다:다'는 없음) */

CREATE TABLE major_tbl(
        majorno     NUMBER( 2 ) PRIMARY KEY
                                CHECK( majorno > 0 ),
        majorname   VARCHAR( 30 ) NOT NULL
);
INSERT INTO major_tbl VALUES( 0, '컴퓨터 공학' ); /* CHECK : 부정확한 데이터가 들어오는것을 막아줌.*/
INSERT INTO major_tbl VALUES( 100, '컴퓨터 공학' ); /* 자릿수 제한으로 인하여 입력 불가. */
CREATE TABLE examtype_tbl(
        examtypeno   NUMBER( 2 ) PRIMARY KEY
                                 CHECK( examtypeno > 0 ),
        examtypename VARCHAR( 30 ) NOT NULL
);

CREATE TABLE score_tbl (
        studentno       NUMBER( 4 ) PRIMARY KEY,
        studentname     VARCHAR2( 20 ) NOT NULL,
        subject1        NUMBER( 3 ) DEFAULT 0 /* 값이 없으면 0으로 지정 */
                                    CHECK ( subject1 >= 0 AND subject1 <= 100 ),
        subject2        NUMBER( 3 ) DEFAULT 0
                                    CHECK ( subject2 >= 0 AND subject2 <= 100 ),
        subject3        NUMBER( 3 ) DEFAULT 0
                                    CHECK ( subject3 >= 0 AND subject3 <= 100 ),
        total           NUMBER( 5 ) DEFAULT 0, /* 나중에 계산에 의해서 나오는 값이므로 굳이 check 안함. */
        average         NUMBER( 6, 2 ) DEFAULT 0,
        majorno         NUMBER( 2 ) REFERENCES major_tbl( majorno ),
        examtypeno      NUMBER( 2 ) REFERENCES examtype_tbl( examtypeno )
);
COMMIT

CREATE SEQUENCE seq_major
    INCREMENT BY 1  /* 증가값 */
    START WITH 1    /* 시작값 */
    MAXVALUE 99     /* 최대값 */
    MINVALUE 1      /* 최소값 */
    NOCYCLE         /* 순환하지 않는다. ex : 99다음에 1로 순환할건지. */
    NOCACHE         /* 생성할 번호를 메모리에 미리 할당 X, 기본값 20 */
    
CREATE SEQUENCE seq_examtype
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 99
    MINVALUE 1
    NOCYCLE
    NOCACHE
    
CREATE SEQUENCE seq_score
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 9999
    MINVALUE 1
    NOCYCLE
    NOCACHE

INSERT INTO major_tbl VALUES( seq_major.NEXTVAL, '컴퓨터 공학' ) /* NEXTVAL : 다음값 (1 - 2 -3 - 4 - 5 .....) */
INSERT INTO major_tbl VALUES( seq_major.NEXTVAL, '빅데이터 공학' )
INSERT INTO examtype_tbl VALUES( seq_examtype.NEXTVAL, '중간고사' )
INSERT INTO examtype_tbl VALUES( seq_examtype.NEXTVAL, '기말고사' )
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3, majorno, examtypeno)
        VALUES ( seq_score.NEXTVAL, 'choi', 100, 100, 100, 1, 1 )
        
        
SELECT * FROM score_tbl
SELECT s.studentname, m.majorname, e.examtypename,
s.subject1, s.subject2, s.subject3
FORM score_tbl s, major_tbl m, examtype e
WHERE s.majorno = m.majorno AND s.examtypeno = e.examtypeno

/* 대전시 CCTV 데이터 */
SELECT * FROM cctv_tbl

CREATE TABLE CCTV_PURPOSE_TBL
AS SELECT * FROM cctv_tbl WHERE purpose = '교통정보수집' /* SUB쿼리 */

SELECT * FROM cctv_purpose_tbl

