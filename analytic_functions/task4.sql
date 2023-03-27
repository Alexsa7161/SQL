/*
Определить список отделов, суммарная зарплата в которых больше средней 
суммарной зарплаты в отделах в городах, где расположены отделы. В отделах без 
сотрудников суммарную зарплату считать равной нулю и учитывать при подсчёте среднего 
значения по городу.
*/
WITH data AS (SELECT DISTINCT e.department_id AS dep_id, d.location_id AS loc_id,
    NVL(SUM(salary) OVER(PARTITION BY e.department_id), 0) AS sum_dep
    FROM departments d
    LEFT JOIN employees e
    ON e.department_id = d.department_id  ),
all_data AS (SELECT dep_id, loc_id, sum_dep, 
        AVG(sum_dep) OVER(PARTITION BY loc_id) AS avg_loc
    FROM data)
SELECT *
FROM all_data
WHERE sum_dep > avg_loc
ORDER BY dep_id;