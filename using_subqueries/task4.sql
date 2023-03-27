/*
Напишите запрос для вывода наименования отделов и фондов заработной платы отделов,
размер которых больше 1/8 от общего фонда заработной платы всей компании. ffff калярны
*/
WITH
SUMMARY AS (SELECT D.DEPARTMENT_NAME, SUM(E.SALARY) AS DEPT_TOTAL
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME)
SELECT DEPARTMENT_NAME, DEPT_TOTAL
FROM SUMMARY
WHERE DEPT_TOTAL > ( SELECT SUM(DEPT_TOTAL) * 1/8
FROM SUMMARY );



