SELECT d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno,
        s.losal, s.grade, e.mgr AS MGR_EMPNO, m.ename AS MGR_ENAME
FROM emp e, emp m, dept d, salgrade s
WHERE e.mgr = m.empno(+) AND e.deptno = d.deptno AND e.sal BETWEEN s.losal AND s.hisal
ORDER BY d.deptno, e.empno;