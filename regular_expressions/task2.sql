/*
Создать запрос для определения в тексте чисел, за которыми ни в одном месте текста не стоит знак  +.
Знак числа не выводить. Предположить, что разделителей разрядов в тексте нет.
Результат отсортировать по возрастанию.
*/
DEFINE str = 'Результатом вычисления выражения 2.5*3-6*5 будет число -22.5, а результатом вычисления выражения (3+5)-9*4 – число -28' 
WITH ALL_NUMBERS AS (
SELECT regexp_substr('&str', '\d+(\.\d+)?', 1, LEVEL) str 
FROM DUAL 
WHERE REGEXP_SUBSTR('&str', '\d+(\.\d+)?', 1, LEVEL) IS NOT NULL 
CONNECT BY LEVEL < LENGTH('&str')),
DELETED_NUM AS (
SELECT REGEXP_SUBSTR(str, '\d+(\.\d+)?') str 
FROM (
SELECT REGEXP_SUBSTR('&str', '\d+(\.\d+)?\D*\+', 1, level, 'i') str 
FROM DUAL 
WHERE REGEXP_SUBSTR('&str', '\d+(\.\d+)?\D*\+', 1, LEVEL, 'i') IS NOT NULL 
CONNECT BY LEVEL < LENGTH('&str'))), 
CORRECT_NUMBERS AS (SELECT TO_NUMBER(str, '9999.999') str 
FROM ALL_NUMBERS 
MINUS 
SELECT TO_NUMBER(str, '9999.999') 
FROM DELETED_NUM ORDER BY 1), 
RESULT_STRING AS (
SELECT SYS_CONNECT_BY_PATH(TO_CHAR(str), ' ') RESUL, ROWNUM RN 
FROM CORRECT_NUMBERS 	
CONNECT BY str > PRIOR str) 
SELECT '&str' "Текст", RESUL "Результат" 
FROM RESULT_STRING 
WHERE rn = (SELECT COUNT(str) FROM CORRECT_NUMBERS);
