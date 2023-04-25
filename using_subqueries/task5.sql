/*
Выведите номера, фамилии и наименования отделов всех сотрудников.
Используйте скалярный подзапрос в команде SELECT для вывода наименований отделов.
*/
SELECT EMPLOYEE_ID, LAST_NAME,
(SELECT DEPARTMENT_NAME
FROM DEPARTMENTS D
WHERE E.DEPARTMENT_ID =
D.DEPARTMENT_ID ) DEPARTMENT
FROM EMPLOYEES E
ORDER BY DEPARTMENT;

