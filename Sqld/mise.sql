CREATE TABLE mise ( 
�Ϸù�ȣ number(7) primary key,
���� VARCHAR2(26),
�����Ҹ� VARCHAR2(26),
�����Ͻ� NUMBER(38),
PM10 NUMBer(26),
�ּ� VARCHAR2(36),
�õ� VARCHAR2(36),
���� NUMBER(38),
�� NUMBER(38),
�� NUMBER(38),
�ð� NUMBER(38),
������ȣ number(1) references gu_tbl(������ȣ));

create table gu_tbl(
������ȣ number(1) primary key,
�����̸� varchar2(10)
)
INSERT INTO gu_tbl VALUES ( 1, '�����');
INSERT INTO gu_tbl VALUES ( 2, '������');
INSERT INTO gu_tbl VALUES ( 3, '����');
INSERT INTO gu_tbl VALUES ( 4, '�߱�');
INSERT INTO gu_tbl VALUES ( 5, '����');

/* �Ϸ���� */
SELECT g.�����̸�, ROUND(AVG(m.PM10),2) AS AVG_PM10
FROM mise m, gu_tbl g
WHERE m.������ȣ = g.������ȣ
GROUP BY g.�����̸�
ORDER BY ROUND(AVG(m.PM10),2)

/* ��ٽð�(8��) ��� */
SELECT g.�����̸�, ROUND(AVG(m.PM10),2) AS AVG_PM10
FROM mise m, gu_tbl g
WHERE m.������ȣ = g.������ȣ AND
      m.�ð� = 8
GROUP BY g.�����̸�
ORDER BY ROUND(AVG(m.PM10),2)

/* ��ٽð� + 2�ð� ���� 10�� ��� */
SELECT g.�����̸�, ROUND(AVG(m.PM10),2) AS AVG_PM10
FROM mise m, gu_tbl g
WHERE m.������ȣ = g.������ȣ AND
      m.�ð� = 10
GROUP BY g.�����̸�
ORDER BY ROUND(AVG(m.PM10),2)
