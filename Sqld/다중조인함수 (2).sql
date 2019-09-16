SELECT d.deptno, d.dname, AVG(e.sal) AS AVG_SAL, MAX(e.sal) AS MAX_SAL,
        MIN(e.sal) AS MIN_SAL, COUNT(*) AS CNT
FROM emp e, dept d
WHERE d.deptno = e.deptno
GROUP BY d.deptno, d.dname
ORDER BY d.deptno;
