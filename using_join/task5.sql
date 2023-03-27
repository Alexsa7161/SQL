/*
получите фамилии всех служащих и их номера, их менаджеров и их номера, включая Кинга, который не имеют менеджера.
*/
SELECT EMP1.LAST_NAME "Employee", EMP1.EMPLOYEE_ID "Emp#",
NVL(EMP2.LAST_NAME, ' ') "Manager", NVL(TO_CHAR(EMP2.EMPLOYEE_ID), ' ') "Mgr#"
FROM EMPLOYEES EMP1 LEFT JOIN EMPLOYEES EMP2 ON EMP2.EMPLOYEE_ID LIKE(EMP1.MANAGER_ID)
ORDER BY EMP1.EMPLOYEE_ID;




