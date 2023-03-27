/*
2.	Создать запрос, который выведет из символьного столбца таблицы всю информацию за исключением значений,
которые могут быть получены из другого  значения столбца за счет циклической перестановки символов.
*/
with doptable as (select text,length(text),DENSE_RANK() over(ORDER BY TEXT) RES from Input),
RESULT (TEXT, N, R,RES) AS
(SELECT TEXT, 0 N, '' R, RES
FROM DOPTABLE
UNION ALL
SELECT TEXT, N + 1, SUBSTR(RESULT.TEXT,N+1,LENGTH(TEXT))|| SUBSTR(RESULT.TEXT, 1, N), RES
FROM RESULT
WHERE N+2 < LENGTH(TEXT))
SELECT TEXT FROM TAB13 MINUS SELECT DISTINCT TEXT FROM RESULT WHERE RES IN (
SELECT RES FROM 
( SELECT RES,R FROM RESULT WHERE R IN  (SELECT R FROM RESULT WHERE R IS NOT NULL GROUP BY R HAVING COUNT(R)>1)));
