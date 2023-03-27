/*
Создать запрос для вычисления суммарных зарплат сотрудников  и количеств 
сотрудников, работающих на должностях ST_CLERK, ST_MAN, AD_PRES и SA_REP в 
отделах Shipping и Executive,  а также не приписанных ни к одному отделу. 
Предусмотрите нумерацию записей (столбец ID)  и сортировку по DEP_ID, SAL, CNT и 
JOB_ID.
*/
WITH data AS (
    SELECT e.department_id AS dept_n, department_name AS dept_name, 
    job_id, COUNT(*) as cnt, SUM(salary) AS sal
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    WHERE (department_name IS NULL 
    OR department_name IN ('Shipping', 'Executive')) 
    AND job_id IN ('ST_CLERK', 'ST_MAN', 'AD_PRES', 'SA_REP')
    GROUP BY e.department_id, department_name, job_id
),
dept_jobs AS (
    SELECT dept_n, dept_name, job_id
    FROM (SELECT DISTINCT dept_n, dept_name
            FROM data)
    CROSS JOIN (
        SELECT DISTINCT job_id
        FROM employees
        WHERE job_id IN ('ST_CLERK', 'ST_MAN', 'AD_PRES', 'SA_REP'))
)
SELECT ROW_NUMBER() OVER (ORDER BY dj.dept_n, sal DESC NULLS LAST, dj.job_id) 
AS ID,
    NVL(TO_CHAR(dj.dept_n), ' ') AS dep_id, 
    NVL(dj.dept_name, ' ') AS dep_name, 
    NVL(dj.job_id, ' ') AS job_id,
    NVL(TO_CHAR(cnt), ' ') AS cnt, 
    NVL(TO_CHAR(sal), ' ') AS sal
FROM dept_jobs dj
LEFT JOIN data
ON NVL(dj.dept_n, 0) = NVL(data.dept_n, 0)
    AND dj.job_id = data.job_id
ORDER BY dj.dept_n, sal DESC NULLS LAST, dj.job_id;