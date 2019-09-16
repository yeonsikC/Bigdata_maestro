SELECT NVL2(comm, 'O', 'X') AS EXIST_COMM, COUNT(*) AS CNT
FROM emp
GROUP BY NVL2(comm, 'O', 'X');