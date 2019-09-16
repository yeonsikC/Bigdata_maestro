SELECT deptno, TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR, COUNT(*) AS CNT,
        MAX(sal) AS MAX_SAL, SUM(sal) AS SUM_SAL, AVG(sal) AS AVG_SAL
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(hiredate, 'YYYY'))
ORDER BY deptno;