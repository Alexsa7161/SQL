/*
Создать запрос для записи произвольного символьного выражения в обратном 
порядке символов. Обеспечьте вывод исходной и измененной строк. Задачу решить 
средствами раздела WITH.
*/
DEFINE input_str = 'Hello, world!';

WITH tab (change_str, res_str, str_data) AS (
    SELECT '&input_str' AS change_str, 
    CAST(' ' AS VARCHAR2(999)) AS res_str, 
    '&input_str' AS str_data
    FROM dual
        UNION ALL
    SELECT SUBSTR(change_str, 2, LENGTH(str_data) - 1), 
--соединяем первый элемент новой подстроки с уже имеющимся результатом итеративно
        SUBSTR(change_str, 1, 1) || res_str,
        str_data
    FROM tab
    WHERE LENGTH(change_str) > 0
)

SELECT str_data AS input, 
    res_str AS result
FROM tab
WHERE change_str IS NULL