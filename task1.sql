/*
Создайте отчёт с отступом, в котором отражается иерархия управления, начиная с сотрудника по фамилии Kochhar.
Выведите фамилии, номера менеджеров и номера отделов сотрудников.
*/
SELECT LPAD(LAST_NAME, LENGTH(LAST_NAME) + LEVEL*3-3, '_') NAME, MANAGER_ID MANAGER, DEPARTMENT_ID DEPTNO
FROM EMPLOYEES
START WITH LAST_NAME = 'Kochhar'
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;
