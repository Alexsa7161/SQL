/*
Создать запрос для вычисления суммарных зарплат сотрудников, работающих на 
должностях MK_MAN, MK_REP, AD_ASST, SA_REP, IT_PROG, PU_MAN, 
PU_CLERK для всех отделов, в которых работают сотрудники на перечисленных 
должностях. Задачу решить без использования функций DECODE и CASE.
*/
WITH data AS (
    SELECT DISTINCT department_id, MK_MAN, MK_REP, AD_ASST, SA_REP, IT_PROG, 
PU_MAN, PU_CLERK
    FROM employees
    WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')
    MODEL
    RETURN UPDATED ROWS 
    DIMENSION BY (department_id, job_id)
    MEASURES (salary, CAST(null AS NUMBER) AS MK_MAN, CAST(null AS NUMBER) AS 
MK_REP, CAST(null AS NUMBER) AS AD_ASST,
    CAST(null AS NUMBER) AS SA_REP, CAST(null AS NUMBER) AS IT_PROG, CAST(null 
AS NUMBER) AS PU_MAN, CAST(null AS NUMBER) AS PU_CLERK)
    UNIQUE SINGLE REFERENCE 
    RULES (
        MK_MAN[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'MK_MAN'] = SUM(salary)[CV(), CV()],
        MK_REP[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'MK_REP'] = SUM(salary)[CV(), CV()],
        AD_ASST[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'AD_ASST'] = SUM(salary)[CV(), CV()],
        SA_REP[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'SA_REP'] = SUM(salary)[CV(), CV()],
        IT_PROG[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'IT_PROG'] = SUM(salary)[CV(), CV()],
        PU_MAN[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'PU_MAN'] = SUM(salary)[CV(), CV()],
        PU_CLERK[FOR department_id IN (SELECT DISTINCT department_id FROM employees 
        WHERE job_id IN ('MK_MAN', 'MK_REP', 'AD_ASST', 'SA_REP', 'IT_PROG', 'PU_MAN', 
'PU_CLERK')), 'PU_CLERK'] = SUM(salary)[CV(), CV()]
    )
)

SELECT department_id,
    NVL(TO_CHAR(SUM(MK_MAN)), ' ') AS MK_MAN,
    NVL(TO_CHAR(SUM(MK_REP)), ' ') AS MK_REP,
    NVL(TO_CHAR(SUM(AD_ASST)), ' ') AS AD_ASST,
    NVL(TO_CHAR(SUM(SA_REP)), ' ') AS SA_REP,
    NVL(TO_CHAR(SUM(IT_PROG)), ' ') AS IT_PROG,
    NVL(TO_CHAR(SUM(PU_MAN)), ' ') AS PU_MAN,
    NVL(TO_CHAR(SUM(PU_CLERK)), ' ') AS PU_CLERK
FROM data
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1