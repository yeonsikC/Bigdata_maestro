SELECT JOB, COUNT(*)
FROM emp
GROUP BY job
HAVING COUNT(job) >= 3;