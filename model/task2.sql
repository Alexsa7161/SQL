/*
Создайте запрос для вывода всех суббот и воскресений между двумя заданными 
датами. Задачу решить с использованием раздела WITH и MODEL.
*/
UNDEFINE start_date;
UNDEFINE end_date;
DEFINE start_date = '01.10.2018'; 
DEFINE end_date = '25.10.2018';
WITH dates AS(
    SELECT holiday AS "Выходные" 
    FROM(
        SELECT holiday
        FROM DUAL
        MODEL
        DIMENSION BY(1 AS id) 
        MEASURES(   
            CAST(NULL AS VARCHAR2(30)) AS holiday
        )
        RULES ITERATE(99999) UNTIL(iteration_number + 1 > 
TO_NUMBER(TO_DATE('&&end_date') - TO_DATE('&&start_date')))(
            holiday[iteration_number + 1] = 
            CASE WHEN TO_CHAR(TO_DATE('&&start_date') + iteration_number, 'D') IN (6, 7) 
                THEN TO_CHAR(TO_DATE('&&start_date') + iteration_number, 'DD-Mon-YYYY')
                || ' ' || TO_CHAR(TO_DATE('&&start_date') + iteration_number, 'Day')
            ELSE NULL END
        )
    )
    WHERE holiday IS NOT NULL
)
SELECT *
FROM dates;