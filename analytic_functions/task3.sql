/*
 Вывести список из трех или менее сотрудников, получающих один из трех 
максимальных окладов по отделу. Если четыре человека получают одинаковый – самый 
максимальный – оклад, в ответ не должно выдаваться ни одной строки. Если два сотрудника 
имеют максимальный оклад, а два – следующий по значению, ответ будет предполагать две 
строки (два сотрудника с максимальным окладом).
*/
WITH data AS (SELECT department_id, last_name, salary,
    RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS sal_rank,
    COUNT(*) OVER(PARTITION BY department_id, salary ORDER BY salary DESC) AS cnt,
    ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) as row_n
FROM employees 
ORDER BY 1)
SELECT department_id, last_name, salary, row_n AS cnt
FROM data
WHERE row_n <= 3
    AND sal_rank + cnt + row_n <= 7;