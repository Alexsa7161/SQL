/*
Покажите номер отдела с наивысшей средней заработной платой и наименьший оклад работающего в нём сотрудника.
*/
SELECT DEPARTMENT_ID, MIN(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY)=(SELECT MAX(AVG(SALARY))
                    FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID)
