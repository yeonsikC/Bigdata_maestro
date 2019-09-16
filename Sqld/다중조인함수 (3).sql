SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
FROM dept d, emp e
WHERE d.deptno = e.deptno
ORDER BY d.deptno, d.dname;