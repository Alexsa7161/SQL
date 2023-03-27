/*
Имеется таблица с символьным столбцом.
Создать запрос для вывода тех значений, которые содержат в себе палиндромы, и самые длинные выражения, представляющие из себя палиндром.
*/
CREATE TABLE tab13(TEXT VARCHAR2(50)CONSTRAINT zad13_pk PRIMARY KEY);

INSERT INTO tab13 VALUES('Крокодил');
INSERT INTO tab13 VALUES('Колокол');
INSERT INTO tab13 VALUES('Крокодил и колокол');
INSERT INTO tab13 VALUES('Станок');
INSERT INTO tab13 VALUES('        Крокодил          ');
INSERT INTO tab13 VALUES('                 ');
INSERT INTO tab13 VALUES('Крокодил и                  колокол');

with doptable as (select text,length(text) L from tab13 group by text),
splitted1 AS (select text
from doptable, (
     select level lvl
     from dual 
     connect by level <= (select max(L) from doptable)) x
where length(text) >= x.lvl
order by text),
splitted2 as (select text strr, DENSE_RANK() OVER (ORDER BY text) R1 from splitted1),
splitted as (select strr, R1, row_number() over(partition by strr,r1 order by strr,R1) R from splitted2),
variants AS (
SELECT substr(s1.strr, s1.r, s2.r - s1.r + 1) AS palindroms, ROWNUM ROW1, s1.R1, s1.strr
FROM splitted s1, splitted s2 where s2.r > s1.r and s1.r1 = s2.r1),
RESULT (palindroms, N, R,ROW2,R1, strr) AS
(SELECT palindroms, 0 N, '' R, ROWNUM ROW2,R1, strr
FROM variants
UNION ALL
SELECT palindroms, N + 1, R || SUBSTR(RESULT.palindroms, LENGTH(RESULT.palindroms) - N, 1), ROW2,R1, strr
FROM RESULT
WHERE N < LENGTH(palindroms)),
final as (SELECT variants.palindroms RES, res1.r1, res1.strr str
FROM VARIANTS, RESULT res1
WHERE ROW1 = ROW2 AND lower(variants.PALINDROMS) = lower(R) AND (LENGTH(VARIANTS.PALINDROMS),res1.r1) = 
(SELECT MAX(LENGTH(VARIANTS.PALINDROMS)),res2.r1 FROM VARIANTS, RESULT res2
WHERE ROW1 = ROW2 AND lower(variants.PALINDROMS) = lower(R) and res1.r1 = res2.r1 group by res2.r1))
select distinct str text, listagg(res,', ') within group(order by r1) over(partition by r1) palindrom from final;