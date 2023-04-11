/*
Вычислить разницу между двумя следующими друг за другом зарплатами сотрудников.
*/
SELECT employee_id, last_name, job_id, NVL(salary, 0) AS salary, 
    LAG(NVL(salary, 0), 1, 0) OVER(order by employee_id) AS sal_prev,
    NVL(salary, 0) - LAG(NVL(salary, 0), 1, 0) OVER(order by employee_id) AS sal_diff
FROM employees;
