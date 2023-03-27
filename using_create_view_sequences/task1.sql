/*
Создайте представление DEPT50, содержащее номер служащего и номер отдела для всех служащих отдела 50.
Запретите операцию перевода служащего в другой отдел через представление.
*/
CREATE VIEW DEPT50 AS
SELECT EMPLOYEE_ID EMPNO,LAST_NAME EMPLOYEE, DEPARTMENT_ID DEPTNO
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
WITH CHECK OPTION;
