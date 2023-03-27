/*
По всем служащим, нанятым раньше своих менеджеров,
выведите фамилии и даты найма самих служащих, а также фамилии и даты найма их менеджеров.
*/
SELECT EMP1.LAST_NAME "Employee", EMP1.HIRE_DATE "Emp Hired", EMP2.LAST_NAME "Manager", EMP2.HIRE_DATE "Mgr Hired"
FROM EMPLOYEES EMP1 JOIN EMPLOYEES EMP2 ON EMP1.HIRE_DATE<EMP2.HIRE_DATE AND EMP2.EMPLOYEE_ID LIKE(EMP1.MANAGER_ID)

