/*
Создать запрос, который позволит получать все комбинации сумм для чисел, 
содержащихся в числовом столбце таблицы.
*/
WITH strings(id, num) AS(
    SELECT 1, 7 FROM DUAL
    UNION ALL
    SELECT 2, 12 FROM DUAL
    UNION ALL
    SELECT 3, 31 FROM DUAL
),
-- получаем все комбинации с 2+ числами
strings_nums AS (
    SELECT ROWNUM AS r, str, lvl
    FROM (
        SELECT DISTINCT LEVEL AS id, LTRIM(SYS_CONNECT_BY_PATH(num, '+'), '+') 
AS str, LEVEL AS lvl
        FROM strings 
        WHERE LEVEL >= 2
        CONNECT BY NOCYCLE PRIOR id != id AND PRIOR num <= num 
        ORDER BY LEVEL
    )
),
-- получаем числа из каждой строки
numbers_from_string AS (
    SELECT DISTINCT r, LEVEL AS lvl, str, TO_NUMBER(REGEXP_SUBSTR(str, '-
(\d+)|(\d+)', 1, LEVEL)) AS numm
    FROM strings_nums 
    CONNECT BY LEVEL <= REGEXP_COUNT(str, '(\d+)')
    ORDER BY 1, numm
),
-- считаем сумму чисел для каждой строки
result AS(
    SELECT r, lvl, str, sum_num
    FROM numbers_from_string
    MODEL
    DIMENSION BY (r, lvl, str)
    MEASURES (numm, 1 AS sum_num)
    RULES (
        sum_num[ANY, 1, ANY] = SUM(numm)[CV(), ANY, CV()]
    )
)

SELECT r, str AS "Слагаемые", sum_num AS "Сумма"
FROM result
WHERE lvl = 1
ORDER BY 1;
