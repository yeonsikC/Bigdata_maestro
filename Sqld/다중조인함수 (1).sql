SELECT d.deptno, d.dname, e.empno, e.ename, e.sal
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2000
ORDER BY d.deptno;