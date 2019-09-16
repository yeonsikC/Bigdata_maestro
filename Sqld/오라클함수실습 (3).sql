SELECT TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR, deptno, COUNT(*) AS CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY'), deptno;
