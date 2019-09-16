CREATE TABLE mise ( 
일련번호 number(7) primary key,
지역 VARCHAR2(26),
측정소명 VARCHAR2(26),
측정일시 NUMBER(38),
PM10 NUMBer(26),
주소 VARCHAR2(36),
시도 VARCHAR2(36),
연도 NUMBER(38),
월 NUMBER(38),
일 NUMBER(38),
시간 NUMBER(38),
지역번호 number(1) references gu_tbl(지역번호));

create table gu_tbl(
지역번호 number(1) primary key,
지역이름 varchar2(10)
)
INSERT INTO gu_tbl VALUES ( 1, '대덕구');
INSERT INTO gu_tbl VALUES ( 2, '유성구');
INSERT INTO gu_tbl VALUES ( 3, '동구');
INSERT INTO gu_tbl VALUES ( 4, '중구');
INSERT INTO gu_tbl VALUES ( 5, '서구');

/* 하루평균 */
SELECT g.지역이름, ROUND(AVG(m.PM10),2) AS AVG_PM10
FROM mise m, gu_tbl g
WHERE m.지역번호 = g.지역번호
GROUP BY g.지역이름
ORDER BY ROUND(AVG(m.PM10),2)

/* 출근시간(8시) 평균 */
SELECT g.지역이름, ROUND(AVG(m.PM10),2) AS AVG_PM10
FROM mise m, gu_tbl g
WHERE m.지역번호 = g.지역번호 AND
      m.시간 = 8
GROUP BY g.지역이름
ORDER BY ROUND(AVG(m.PM10),2)

/* 출근시간 + 2시간 후인 10시 평균 */
SELECT g.지역이름, ROUND(AVG(m.PM10),2) AS AVG_PM10
FROM mise m, gu_tbl g
WHERE m.지역번호 = g.지역번호 AND
      m.시간 = 10
GROUP BY g.지역이름
ORDER BY ROUND(AVG(m.PM10),2)
