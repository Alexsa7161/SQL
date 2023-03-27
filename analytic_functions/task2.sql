/*
Определить накапливаемую в пределах отделов сумму зарплат сотрудников.
*/
SELECT department_id, employee_id, salary,
    SUM(salary) OVER(PARTITION BY department_id ORDER BY salary) AS cum_sum
FROM employees;