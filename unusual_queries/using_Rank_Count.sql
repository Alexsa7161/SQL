/*
Для каждого отдела вывести фамилии и зарплаты трех сотрудников, получающих самые высокие зарплаты в отделе.
Если самую  низкую зарплату  у найденных трех сотрудников отдела получают и какие-то другие сотрудники этого отдела, они тоже должны попасть в список.
Для отделов, в которых меньше трех сотрудников, информацию не выводить.
*/
WITH tmp1 AS
(SELECT department_id, last_name, salary,
COUNT(*) OVER(PARTITION BY department_id) cnt,
RANK() OVER(PARTITION BY department_id ORDER BY NVL(salary,0) DESC) rank
FROM employees
WHERE department_id IS NOT NULL)
SELECT department_id, last_name, NVL(salary,0) salary
FROM tmp1
WHERE rank<=3 and cnt>=3