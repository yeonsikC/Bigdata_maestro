SELECT * FROM traffic

CREATE TABLE gu_tbl(
    guno    NUMBER( 2 ) PRIMARY KEY,
    guname  VARCHAR2( 14 )
)
INSERT INTO gu_tbl VALUES ( 1, '대덕구');
INSERT INTO gu_tbl VALUES ( 2, '유성구');
INSERT INTO gu_tbl VALUES ( 3, '동구');
INSERT INTO gu_tbl VALUES ( 4, '서구');
INSERT INTO gu_tbl VALUES ( 5, '중구');

ALTER TABLE traffic ADD guno NUMBER( 2 );
ALTER TABLE traffic ADD traffic_AVG NUMBER( 6,2 );
ALTER TABLE traffic ADD addrno NUMBER( 2 );

/*ALTER TABLE traffic DROP COLUMN addrno*/
DELETE FROM traffic
WHERE addr IS NULL

CREATE SEQUENCE traffic_seq
    INCREMENT BY 1  /* 증가값 */
    MAXVALUE 34     /* 최대값 */
    MINVALUE 0      /* 최소값 */
    NOCYCLE         /* 순환하지 않는다. ex : 99다음에 1로 순환할건지. */
    CACHE 2

UPDATE traffic SET addrno = traffic_seq.NEXTVAL

/* 평균 = 합계/24 */
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=0
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=1
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=2
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=3
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=4
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=5
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=6
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=7
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=8
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=9
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=10
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=11
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=12
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=13
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=14
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=15
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=16
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=17
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=18
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=19
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=20
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=21
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=22
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=23
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=24
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=25
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=26
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=27
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=28
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=29
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=30
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=31
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=32
UPDATE traffic SET traffic_avg = traffic_SUM/24
WHERE addrno=33

ALTER TABLE traffic ADD CONSTRAINT traffic_fk_guno FOREIGN KEY(guno) REFERENCES gu_tbl(guno)

SELECT * FROM traffic

UPDATE traffic SET guno = 1
WHERE addrno=0
UPDATE traffic SET guno = 1
WHERE addrno=1
UPDATE traffic SET guno = 1
WHERE addrno=2
UPDATE traffic SET guno = 1
WHERE addrno=3
UPDATE traffic SET guno = 1
WHERE addrno=4
UPDATE traffic SET guno = 1
WHERE addrno=5
UPDATE traffic SET guno = 1
WHERE addrno=6
UPDATE traffic SET guno = 1
WHERE addrno=7
UPDATE traffic SET guno = 2
WHERE addrno=8
UPDATE traffic SET guno = 2
WHERE addrno=9
UPDATE traffic SET guno = 2
WHERE addrno=10
UPDATE traffic SET guno = 2
WHERE addrno=11
UPDATE traffic SET guno = 2
WHERE addrno=12
UPDATE traffic SET guno = 2
WHERE addrno=13
UPDATE traffic SET guno = 2
WHERE addrno=14
UPDATE traffic SET guno = 3
WHERE addrno=15
UPDATE traffic SET guno = 3
WHERE addrno=16
UPDATE traffic SET guno = 3
WHERE addrno=17
UPDATE traffic SET guno = 3
WHERE addrno=18
UPDATE traffic SET guno = 3
WHERE addrno=19
UPDATE traffic SET guno = 3
WHERE addrno=20
UPDATE traffic SET guno = 3
WHERE addrno=21
UPDATE traffic SET guno = 4
WHERE addrno=22
UPDATE traffic SET guno = 4
WHERE addrno=23
UPDATE traffic SET guno = 4
WHERE addrno=24
UPDATE traffic SET guno = 4
WHERE addrno=25
UPDATE traffic SET guno = 4
WHERE addrno=26
UPDATE traffic SET guno = 4
WHERE addrno=27
UPDATE traffic SET guno = 4
WHERE addrno=28
UPDATE traffic SET guno = 4
WHERE addrno=29
UPDATE traffic SET guno = 5
WHERE addrno=30
UPDATE traffic SET guno = 5
WHERE addrno=31
UPDATE traffic SET guno = 5
WHERE addrno=32
UPDATE traffic SET guno = 5
WHERE addrno=33


SELECT g.guname,
       COUNT(g.guno) AS gu_COUNT,
       ROUND(AVG(t.TRAFFIC8),2) AS traffic_am08,
       ROUND(AVG(t.TRAFFIC_AVG),2) AS traffic_AVG
FROM traffic t, gu_tbl g
WHERE t.guno = g.guno
GROUP BY g.guno, g.guname