/*
Выведите номера , наименования и местоположения отделов,
в которых не работают торговые представители (job_id = ‘SA_REP’).
*/
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_ID != ALL((SELECT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE JOB_ID LIKE('SA_REP')
                            GROUP BY DEPARTMENT_ID
                            HAVING DEPARTMENT_ID IS NOT NULL))
