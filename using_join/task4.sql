/*
Выведите фамилии и номера всех служащих вместе с фамилиями и номерами их менеджеров.
*/
SELECT EMP1.LAST_NAME "Employee", EMP1.EMPLOYEE_ID "Emp#", EMP2.LAST_NAME "Manager", EMP2.EMPLOYEE_ID "Mgr#"
FROM EMPLOYEES EMP1 LEFT JOIN EMPLOYEES EMP2 ON EMP2.EMPLOYEE_ID=EMP1.MANAGER_ID;



