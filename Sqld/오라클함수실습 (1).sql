SELECT deptno, TRUNC(AVG(sal)) AS AVG_SAL, MAX(sal) AS MAX_SAL, MIN(sal) AS MIN_SAL, COUNT(deptno) AS CNT
    FROM emp GROUP BY deptno;