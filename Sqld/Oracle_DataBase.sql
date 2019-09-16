DATA �ߺ� �����ϴ� ���� : DATA �ŷڼ� ����. ( ���Ἲ )

1. File System
: Data�� file�� ���� (csv, txt)
: Data �ߺ�, ���û�� �Ұ�.
-> ������û�� ���ÿ� ����.

2. DataBase System(DBMS)
: �� ������ �ذ��ϰ�, ������ ���Ἲ.
: �����ڸ� ����� �� �˸� �ȴ�. ( ex: ī���� �ٸ���Ÿ )


SQL(Structured Query Language)
: Script, Interpreter ���

������ ���� DDL(CRUD)
������ ���� DML(�ַδٷ�) - ������ ���� ���� ����
������ ���� DCL

DataBase : Table(��� Array) ����
Table : Field ����
Field : scalar(����) ��
row = record / col = field
#DML�� ��ɾ� 4���� : Table�� �ִ� row/col�� ��ȭ�� ��
SELECT	�˻�, Data ����	(row/col ����)
 - row ��ȸ (selection)
 - col  ��ȸ (projection)
 - join �� �� �̻��� ���̺��� �����ؼ� selection�� �ϰų� projection�� �ϰڴ�.
INSERT	row ����		(row ����)
UPDATE	row ����		(col ����)
DELETE	row ����		(row ����)

DBMS -> DataBase -> Table -> Field

#�򰥸� ������ ���Ͽ�
#SQL : �빮�� / sqlplus : �ҹ���
1. cmd ����
2. sqlplus scott/tiger �Է� (sqlplus : oracle CLI(����Է¹��) ���)
* CLI ȯ�� : prompt�� ��� �Է� ������
** sqlplus ���, sql ��� (��ҹ��� ����X)
3. show user; : ���� ������ ���� ��Ÿ��. (sqlplus) 
4. select * from all_users; : ���� ��ϵ� ����� ���(dcl�� ���Ͽ� ����� �߰�)
5. select * from tab; : ���� �α��� �� ������ DB �� ���̺��� ��� ��Ÿ��
6. desc emp; : descript�� ����, emp - table �̸� : emp ���̺��� �ʵ� ����
*NOT NULL : �������� - �� �־�� �ϴ� ��. ex) ����Ű
*VARCHAR2(10) : �ִ� 10�ڸ�. ������, ���������̹Ƿ� �����Ͱ� 6���� ������ 6������.

# �⺻ Ʋ
SELECT column ���
FROM table ���
(WHERE ����)

# projection
SELECT * FROM DEPT;
 - DEPT ���̺��� ��ü col�� ����϶�.
SELECT deptno FROM dept;
 - dept ���̺��� deptno col�� ����϶�.
SELECT * FROM emp;
 - MGR : ������ �����ȣ(Ű). --->> �ڱ� �ڽŰ� ����.
SELECT empno, mer FROM emp;
SELECT mgr, empno FROM emp;
SELECT empno, job FROM emp;
SELECT job, deptno FROM emp;
SELECT DISTINCT job, empno FROM emp;
 - DISTINCT : �ߺ�����
SELECT ALL job, deptno FROM emp;
 - ALL : �ߺ������� ���
SELECT ename, sal, sal * 0.5 FROM emp;
 - sal�� 50%���� ��Ÿ��(Field�� ����� ����) : + - * / �� ����
SELECT ename, sal, sal * 0.5 AS SAL_50 FROM emp;
 - AS : ������ ����. (����) / ���� ������ ����.
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp;
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp ORDER BY ename;
 - ORDER BY : �ش� ������ ������������ ���
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp ORDER BY ename DESC;
 - DESC : �̸��� ������������ ���
SELECT ename AS emp_name, sal, sal * 0.5 AS SAL_50 FROM emp ORDER BY sal DESC, ename ASC;
 - sal ���� �������� ��, ename ���� �������� ���.   /  ASC : ��������
SELECT ename, job, sal FROM emp WHERE sal >= 3000;
 - sal 3000 �̻� ���.
SELECT ename, job, sal FROM emp WHERE deptno = 30;
SELECT * FROM emp WHERE ename = 'SCOTT'; /* �����ϸ� "�� �ƴ� ' ���. */

SELECT * FROM emp WHERE ename != 'SCOTT';
SELECT ename, job, sal FROM emp WHERE deptno = 30 AND sal >= 1500;
 - AND, OR ������ ����
SELECT ename, job, sal FROM emp WHERE sal * 0.5 = 1500;
SELECT ename, job, sal FROM emp WHERE (sal * 0.5) = 1500;
SELECT ename, job, sal FROM emp WHERE NOT (sal * 0.5) = 1500;
 - NOT : �� �ش� ������ �ƴ� ���� ���
SELECT ename, job, deptno FROM emp WHERE deptno = 10 OR deptno = 20;
SELECT ename, job, deptno FROM emp WHERE deptno IN (10,20);
 - deptno�� ��ȣ���� ���� �ش�Ǹ� ���
SELECT ename, job, deptno FROM emp WHERE NOT deptno IN (10,20);
SELECT ename, job, deptno FROM emp WHERE job = 'SALESMAN' AND deptno = 30;
SELECT ename, job, deptno, sal FROM emp WHERE sal >= 1500 AND sal <= 3000;
SELECT ename, job, deptno, sal FROM emp WHERE sal BETWEEN 1500 AND 3000;
 - ���̰��� ���
SELECT ename, job, deptno, sal FROM emp WHERE sal NOT BETWEEN 1500 AND 3000;
SELECT ename, job, deptno, sal FROM emp WHERE job LIKE 'S%';
 - LIKE 'S%'; : S�� ���۵Ǵ� �� ���		// % : ���̿� ������� ��� ���� �����͸� �ǹ�
SELECT ename, job, deptno, sal FROM emp WHERE job LIKE '%N';
 - ������ ���ڰ� N�� �� ���
SELECT ename, job, deptno, sal FROM emp WHERE job LIKE '_L%';
 - �ι�° ���ڰ� L�� �� ���			// _ : � ���̵� ������� �� ���� ���� �����͸� �ǹ�
SELECT ename, job, deptno, sal, comm FROM emp WHERE comm IS NULL;
 - IS NULL : NULL�� ��.
SELECT ename, job, deptno, sal, comm FROM emp WHERE comm IS NOT NULL;
 - NULL�� �ƴ� ��.

UPPER(ename),	LOWER(ename)	INITCAP(ename)	LENGTH(ename)	LENGTHB(ename)
�빮��		�ҹ���		ù���ڴ빮��	����		����Ʈ��(�ѱ�:2Byte/����:1Byte)

SUBSTR(job, 1, 2)	SUBSTR(job, 3, 2)	SUBSTR(job, 5)	SUBSTR(���ڿ� ������, ������ġ, �������)
SA		LE		SMAN

SUBSTR(job, -LENGTH(job))	SUBSTR(job, -LENGTH(job), 2)
CLERK			CL

INSTR(����ڿ�, ã�� �κй���, ã�� ������ �κ�, ���°�� ã����)
SELECT ename FROM emp WHERE INSTR(ename, 'L')>0;
SELECT ename FROM emp WHERE ename LIKE '%L%';
 - �� �� ���� ��� ����.

REPLACE('010-1234-5678', '-', ' ')	REPLACE('010-1234-5678', '-')
010 1234 5678			01012345678

��üũ�⸦ ��Ƶΰ�(14) ������ ������ '*'�� ä����.
PAD : ä���. RPAD : �����ʿ� ä����.
RPAD('123456-', 14, '*')	RPAD('010-1234-', 13, '#')
123456-*******		010-1234-####

CONCAT(empno, ename)	CONCAT(empno, concat(':', ename))	empno||ename
empnoename		empno:ename			empnoename

TRIM('    hello   ') RTRIM LTRIM ����
hello

ROUND(������ ������, ��Ÿ�� �Ҽ��� ��) : �ݿø���
TRUNC(������ ������, ��Ÿ�� �Ҽ��� ��) : ����
CEIL(������ ������) : �ø�
FLOOR(������ ������) : ����
MOD(ū ��, ���� ��) : ������ ������ �Լ� // MOD(3, 2) : 1
SYSDATE : 19/06/25 ��¥
ADD_MONTHS(SYSDATE, 3) : 3���� �� ��¥
MONTH_BETWEEN(��¥������1, ��¥������2) : �� ��¥�� ���� �� ����
NEXT_DAY(��¥������, ����) : ��¥ ������ �������� ���ƿ��� ������ ��¥�� ���
LAST_DAY(��¥ ������) : Ư�� ��¥�� ���� ���� ������ ��¥�� ���


#�� ��ȯ(Data Type ��ȯ) (Casting)

- �Ͻ��� ����ȯ (�ڵ� ����ȯ) ex) 10 + 10.0 = 20,     600 + '300' = 900 [������ ����]
- ����� ����ȯ (���� ����ȯ)
TO_NUMBER('500')
TO_CHAR(500)
TO_DATE()

NVL(crrromm, 0) : NULL�� 0���� �ٲ�

#���ǹ�
DECODE(���Ǻ���, ���߰��, TRUE��, FALSE��)

@func_ex1.sql	�ܺ� sql ���� �ҷ�����
@@func_ex1.sql	�ܺ� sql ���� �ҷ�����(��μ�������)
L 		�Է��ϸ� ���������� ����� sql �ڵ� ����.

#������ �Լ� - NULL�� �����ϰ� ��� : �������� ������ �Ͱ� ���� ��� �Ұ�.
SUM, COUNT, MAX, MIN, AVG
COUNT(*) : ���ڵ� ��
COUNT(comm) : NULL�� ���� ���ڵ� ��
SELECT deptno, MAX(sal), MIN(sal), AVG(sal) FROM emp GROUP BY deptno;
 - FORM�� ������		GROUP BY ���� : ������ ���.
SELECT deptno, MAX(sal), MIN(sal), AVG(sal) FROM emp GROUP BY deptno ORDER BY deptno;
 - GROUP ������ ORDER�� �;ߵ�.
SELECT deptno, MAX(sal), MIN(sal), AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal) >= 2000 ORDER BY deptno;
 - HAVING : GROUP BY������ ��� ���� ( WHERE�� ��� )

####### �������� - NULL�� ������� ����.
# ����� - ���谡 ������ ���̺� ���� �ϴ°��� ��Ģ.
SELECT e.empno, e.deptno,d.deptno, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno;
# ������ - ���� ���輺�� ���ٸ� WHERE�� ���.
SELECT e.empno, e.ename, e.sal, e.comm, s.losal, s.hisal FROM emp e, salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal;
# ��ü���� (MGR�� NULL�� ���� ����)
SELECT e.empno, e.ename, e.mgr, m.ename FROM emp e, emp m WHERE e.mgr = m.empno;

####### �ܺ�����
# NULL ���� ���� (+)   :  + ��ȣ�� �������� ���� ����.
SELECT e.empno, e.ename, e.mgr, m.ename FROM emp e, emp m WHERE e.mgr = m.empno(+) ORDER BY e.empno;

# ��ȣ �� ���� �κ� : ��������
# ��ȣ �� �κ� : ��������
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

/* �ϳ��� �����ϸ� ����϶�. = OR�� ��� , ���������� ���ǽ��� �ϳ��� ���̸� ��� ��*/                                    
SELECT *
FROM emp
WHERE sal = ANY ( SELECT MAX(sal)
                  FROM emp
                  GROUP BY deptno );
                  
/* ���� ���� */                  
SELECT *
FROM emp
WHERE sal = SOME ( SELECT MAX(sal)
                  FROM emp
                  GROUP BY deptno );                  

/* �� TURE���� TRUE.   = AND�� ���*/
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
DML : Data ����, CRUD ����
SELECT Data �˻�(����)
INSERT : row �߰�
UPDATE : column ����
DELETE : row ����
DDL : DB/TABLE ����/����/����
CREATE TABLE
DROP TABLE
*/

/* ���̺� ����. ������. �츮�� �� �� �ƴ�. */
DROP TABLE student_tbl

/* ���̺� ���� */
CREATE TABLE score_tbl (
        studentno       NUMBER( 4 ), /* 4 : ���� 4�ڸ� */
        studentname     VARCHAR2( 20 ),
        subject1        NUMBER( 3 ),
        subject2        NUMBER( 3 ),
        subject3        NUMBER( 3 )
)

/* ������ �� ������ �°� �־�� ��. */
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

/* ������ �Է¾��ص� �����͸� �� ��������� ���� */        
INSERT INTO score_tbl
        VALUES ( 6, 'im', 77, 87, 97)
        
/* ���� �߰� */
ALTER TABLE score_tbl 
        ADD total       NUMBER( 5 )
ALTER TABLE score_tbl
        ADD average     NUMBER( 6, 2 )

/* ������ ���� */
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

/* Ư�� �� ���� */
DELETE FROM score_tbl
WHERE studentno = 6

/* ���̺� �� ��� �� ���� */
DELETE FROM score_tbl

SELECT COUNT(*), MAX(subject1), MIN(subject1), AVG(subject1)
FROM score_tbl

/* ���̺� �����غ��� */
ALTER TABLE score_tbl
        ADD majorname     VARCHAR2( 20 )

UPDATE score_tbl SET majorname = '��ǻ�� ����'
WHERE studentno = 1
UPDATE score_tbl SET majorname = '��ǻ�� ����'
WHERE studentno = 2
UPDATE score_tbl SET majorname = '������ ����'
WHERE studentno = 3
UPDATE score_tbl SET majorname = '������ ����'
WHERE studentno = 4
UPDATE score_tbl SET majorname = '��ǻ�� ����'
WHERE studentno = 5
UPDATE score_tbl SET majorname = '������ ����'
WHERE studentno = 6
/* �� ������ �߰� ���, ���Ἲ�� ħ���� */
/* major_tbl�� ������ major�� ���� �����Ѵ�. */
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

/* ���̺� ���� */
CREATE TABLE major_tbl (
        majorno       NUMBER( 4 ),
        majorname     VARCHAR2( 20 )
)

/* ������ �� ������ �°� �־�� ��. */
INSERT INTO major_tbl
        VALUES ( 1, '��ǻ�Ͱ���');
INSERT INTO major_tbl
        VALUES ( 2, '������');
        
SELECT * FROM score_tbl, major_tbl WHERE score_tbl.majorno = major_tbl.majorno;

/* Ʈ������ : sqldeveloper���� ������ �ص�, cmd���� �ٷ� ������� ����. */
COMMIT /* �ϳ��� Ʈ�������� ����. -> DB�� ������ �Ѿ. */
ROLLBACK /* Ʈ�������� ������ ����(COMMIT �ϱ�����) �ϸ� �ٽ� �������·� ���ư�. */

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
INSERT INTO test_tbl VALUES ( 1, '�߰����');
INSERT INTO test_tbl VALUES ( 2, '�⸻���');

SELECT * FROM score_tbl s, major_tbl m, test_tbl t WHERE s.testno = t.testno AND s.majorno = m.majorno;

/*
NOT NULL : NULL ��� x
UNIQUE : �������� ��������, �ߺ� X
PRIMARY KEY : NOT NULL, UNIQUE Ư�� ��� ����.
FOREIGN KEY : �ٸ� ������ ���̺� ���� ����, UNIQUE �ϸ� �ȵ�, �ߺ��� ���Ǿ� ��.
CHECK : ������ ���ǽ��� �����ϴ� �����͸� �Է� ����.
*/

CREATE TABLE master(
    masterid        NUMBER( 2 ) PRIMARY KEY,
    mastername      VARCHAR2( 20 )
);
CREATE TABLE slave(
    slaveid     NUMBER( 2 ) PRIMARY KEY,
    slavename   VARCHAR2( 20 ),
    masterid    NUMBER( 2 ) REFERENCES master( masterid ) /* REFERENCE ���̺��(�ش����̺���_����Ű) */
);

DROP TABLE score_tbl;
DROP TABLE test_tbl;
DROP TABLE major_tbl;
DROP TABLE slave;
DROP TABLE master;
DROP TABLE examtype_tbl;
COMMIT;

/* 1:1 or 1:�� ('��:��'�� ����) */

CREATE TABLE major_tbl(
        majorno     NUMBER( 2 ) PRIMARY KEY
                                CHECK( majorno > 0 ),
        majorname   VARCHAR( 30 ) NOT NULL
);
INSERT INTO major_tbl VALUES( 0, '��ǻ�� ����' ); /* CHECK : ����Ȯ�� �����Ͱ� �����°��� ������.*/
INSERT INTO major_tbl VALUES( 100, '��ǻ�� ����' ); /* �ڸ��� �������� ���Ͽ� �Է� �Ұ�. */
CREATE TABLE examtype_tbl(
        examtypeno   NUMBER( 2 ) PRIMARY KEY
                                 CHECK( examtypeno > 0 ),
        examtypename VARCHAR( 30 ) NOT NULL
);

CREATE TABLE score_tbl (
        studentno       NUMBER( 4 ) PRIMARY KEY,
        studentname     VARCHAR2( 20 ) NOT NULL,
        subject1        NUMBER( 3 ) DEFAULT 0 /* ���� ������ 0���� ���� */
                                    CHECK ( subject1 >= 0 AND subject1 <= 100 ),
        subject2        NUMBER( 3 ) DEFAULT 0
                                    CHECK ( subject2 >= 0 AND subject2 <= 100 ),
        subject3        NUMBER( 3 ) DEFAULT 0
                                    CHECK ( subject3 >= 0 AND subject3 <= 100 ),
        total           NUMBER( 5 ) DEFAULT 0, /* ���߿� ��꿡 ���ؼ� ������ ���̹Ƿ� ���� check ����. */
        average         NUMBER( 6, 2 ) DEFAULT 0,
        majorno         NUMBER( 2 ) REFERENCES major_tbl( majorno ),
        examtypeno      NUMBER( 2 ) REFERENCES examtype_tbl( examtypeno )
);
COMMIT

CREATE SEQUENCE seq_major
    INCREMENT BY 1  /* ������ */
    START WITH 1    /* ���۰� */
    MAXVALUE 99     /* �ִ밪 */
    MINVALUE 1      /* �ּҰ� */
    NOCYCLE         /* ��ȯ���� �ʴ´�. ex : 99������ 1�� ��ȯ�Ұ���. */
    NOCACHE         /* ������ ��ȣ�� �޸𸮿� �̸� �Ҵ� X, �⺻�� 20 */
    
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

INSERT INTO major_tbl VALUES( seq_major.NEXTVAL, '��ǻ�� ����' ) /* NEXTVAL : ������ (1 - 2 -3 - 4 - 5 .....) */
INSERT INTO major_tbl VALUES( seq_major.NEXTVAL, '������ ����' )
INSERT INTO examtype_tbl VALUES( seq_examtype.NEXTVAL, '�߰����' )
INSERT INTO examtype_tbl VALUES( seq_examtype.NEXTVAL, '�⸻���' )
INSERT INTO score_tbl ( studentno, studentname, subject1, subject2, subject3, majorno, examtypeno)
        VALUES ( seq_score.NEXTVAL, 'choi', 100, 100, 100, 1, 1 )
        
        
SELECT * FROM score_tbl
SELECT s.studentname, m.majorname, e.examtypename,
s.subject1, s.subject2, s.subject3
FORM score_tbl s, major_tbl m, examtype e
WHERE s.majorno = m.majorno AND s.examtypeno = e.examtypeno

/* ������ CCTV ������ */
SELECT * FROM cctv_tbl

CREATE TABLE CCTV_PURPOSE_TBL
AS SELECT * FROM cctv_tbl WHERE purpose = '������������' /* SUB���� */

SELECT * FROM cctv_purpose_tbl

